#==> feature importance extraction
f.importance <- function(model, cnmaes){
  if(class(model)=="randomForest"){
    imp <- base::round(c(randomForest::importance(rf)),2)
  }else{
    if(class(model)=="Rdimtools" | class(model)=="list"){
      imp <- base::round(c(model[[which(grepl("score", names(model)))]]),2)
    }else{
      stop("Model non prise en compte")
    }
  }
  res <- data.frame(feature = cnmaes, importance =  imp)
  return(res)
}

#==> feature importance extraction
plot.importance <- function(df.imp, n.imp, asc_=TRUE, title){
  if(asc_){
    df.imp <- head(arrange(df.imp, desc(importance)), n = n.imp)  
    df.imp$feature <- reorder(df.imp$feature,df.imp$importance)
    
  }else{
    df.imp <- head(arrange(df.imp, -desc(importance)), n = n.imp)
    df.imp$feature <- reorder(df.imp$feature,-df.imp$importance)
    
  }
  
  df.imp %>%
    ggplot(aes(feature, importance)) +
    geom_point(size = 1.5, colour = "#7f00ff") +
    coord_flip() +
    labs(x = "", y = "Importance criterion") + #Features
    ggtitle(title) +
    theme_bw()+
    theme(axis.title.y=element_blank(),
          axis.text.y=element_blank(),
          axis.ticks.y=element_blank()) + 
    #theme(panel.grid.major = element_blank()) +
    theme(panel.background = element_rect(fill = '#fffff8'),
          plot.background = element_rect(fill = "#fffff8"))
}





##==> Initialisation des fonction
processing <- function(df_features){
  na_col <- df_features %>%
    map_df(function(x) sum(is.na(x))) %>%
    gather(feature, num_nulls)
  
  dropList <- as.character(na_col[na_col$num_nulls>50,]$feature)
  df_features <- df_features[, !colnames(df_features) %in% dropList]
  
  imputList <- as.character(na_col[na_col$num_nulls>0 & na_col$num_nulls<50 ,]$feature)
  df_features[imputList] <- colMeans(df_features[,imputList], na.rm=TRUE)  
  
  sup.var <- function(df, kpi){
    df <- df %>% dplyr:: select(-contains(kpi))
    return(df)
  }
  df_features <- sup.var(df_features, 
                         kpi=c("nb_remplissages","__range_count__max_5__min_0",
                               "__number_cwt_peaks__n_5", "__quantile__q_"))
  
  return(df_features)
}





select_data <- function(algo){
  load("input/select/model_data.Rdata")
  
  if(algo=='RF'){
    imp <- base::round(randomForest::importance(rf,type=2),2)
    varimp_rf <- cbind.data.frame(feature = colnames(df_features)[-1], importance =  as.numeric(imp))
    df.imp <- dplyr::arrange(varimp_rf, desc(importance))  
    df.imp$feature <- reorder(df.imp$feature,df.imp$importance)
    return(list(df.imp, df_features))
  }
  if(algo=='LS'){
    imp <- base::round(c(lscore[[which(grepl("score", names(lscore)))]]),2)
    varimp_lscore <- data.frame(feature =  colnames(df_features)[-1], importance =  imp)
    df.imp <- dplyr::arrange(varimp_lscore, -desc(importance))
    df.imp$feature <- reorder(df.imp$feature,-df.imp$importance)
    return(list(df.imp,df_features))
  }
}


avg_silhouette_1 <-function(model, data){
  mas <-  as.data.frame(model$mass)
  Cluster <- as.numeric(as.factor(colnames(mas)[apply(mas,1,which.max)]))
  ss <- silhouette(Cluster, dist(data, method = "manhattan"), full=TRUE)
  return(mean(ss[, 3]))
}





#==> Clustering Algorithm
select_quality <- function(data,var,n_c,m,relational){
  sc <- -1
  if(relational){
    for(C in 2:n_c){
      set.seed(1234)
      clus.ecm <-  tryCatch({evclust::recm(dist(data, method = "manhattan"),
                                           c=C,type='full',
                                           beta = 1.5,  alpha=0.5,
                                           disp = F)},
                            error=function(e){NULL})
      
      asw <- tryCatch({round(avg_silhouette_1(clus.ecm, dist(data, method = "manhattan")),2)},error=function(e){NA})
      Nonspecificity <- round(clus.ecm$N,2)
      if(asw >= sc){
        sc <- asw 
        quality <- cbind.data.frame(C,Nonspecificity,asw)
        ml <- clus.ecm
        vr <- var
      }
    }
  }else{
    for(C in 2:n_c){
      set.seed(1234)
      clus.ecm <- tryCatch({ecmm(data, c=C,
                                 type='full', beta = 1.1,  alpha=0.1,
                                 delta=9, init="kmeans",disp = F)},
                           error=function(e){NULL})
      
      asw <- tryCatch({round(avg_silhouette_1(clus.ecm, data),2)},error=function(e){NA})
      Nonspecificity <- round(clus.ecm$N,2)
      if(asw >= sc){
        sc <- asw 
        quality <- cbind.data.frame(C,Nonspecificity,asw)
        ml <- clus.ecm
        vr <- var
      }
    }
  }

  colnames(quality) <- c('C','Nonspecificity','ASW')
  return(list(quality, ml, vr))
}





#==> Comparaison
select_select <- function(model, params, C, relational){
  var <- ml <- res <- c()
  
  for(m in model){
    select_list <- params[params$algorithm==m,]$nb_var
    df <- select_data(algo=m)
    
    for(nvr in select_list){
      start.time <- Sys.time()
      
      select_var <- as.character(df[[1]]$feature[1:nvr])
      select_df <-  df[[2]][,select_var]
      
      select <- select_quality(data=select_df,var=select_var,n_c=C,m=m, relational=relational)
      
      end.time <- Sys.time()
      time.taken <- round(as.numeric(end.time - start.time), 1)
      
      select.quality <- cbind.data.frame(Algothms=m,Features=nvr, select[[1]], Time=time.taken)
      
      res <- c(res,list(select.quality))
      var <- c(var,list(select[[3]]))
      ml <- c(ml,list(select[[2]]))
      
      cat(m,'__standard__',nvr,"\n")
    }
  }
  save(res, var, ml,  file = paste0("input/select/cluster_slect_Rel_",relational,".Rdata"))
}


#Visualisation et meilleur selection  
Visualisation <- function(data, flag, title=NULL){
  colors <- c("Nonspecificity" = "#7f00ff", "ASW" = "black")
  p <- ggplot(data = data, aes(x = index, group=1)) +
    geom_line(aes(y = Nonspecificity, color = "#7f00ff",size = 0.5)) +
    geom_point(aes(y = Nonspecificity, size = 0.6, color = "Nonspecificity")) +
    geom_line(aes(y = ASW, color = "black", size = 0.5)) +
    geom_point(aes(y = ASW, size =  0.6, color = "ASW")) +
    theme_minimal () +
    theme(axis.title.x = element_blank(),
          axis.text.x = element_blank(),
          axis.line = element_line(colour = "grey40", linewidth = 0.8)) +
    theme(text=element_text(colour = "black", size = 14,
                            family="serif",face="bold",color="grey40"), legend.position = "top")+ 
    labs(y = "%", color = "Legend :") +
    scale_color_manual(values = colors) + guides(size = FALSE) + 
    ggtitle(title) +
    theme(panel.background = element_rect(fill = '#fffff8'),
          plot.background = element_rect(fill = "#fffff8"),
          panel.border = element_blank())
  
  
  dfm <- melt(data[,-c(4,5)][,c("index","Time","Algothms","Features","C")], id=c("index"))
  data_table <- ggplot(dfm, aes(x = index, y = factor(variable), label = format(value, nsmall = 1))) +
    geom_text(size = 3, colour = ifelse(dfm$index==flag,"black","grey40") , fontface = ifelse(dfm$index==flag,2,0)) + 
    scale_color_discrete(guide = "none")+
    xlab(NULL) + ylab("  ")+
    theme_bw() +
    theme(panel.grid.major = element_blank(),
          panel.border = element_blank(),
          axis.text.x = element_blank(),
          axis.ticks = element_blank(),
          plot.margin = unit(c(0, 0, 0, -0.5), "lines"))+
    theme(text=element_text(colour = "black", size = 10,
                            family="serif",face="bold",color="grey40"))
  Layout <- grid.layout(nrow = 2, ncol = 1, heights = unit(c(2.3, 0.6), c("null", "null")))
  #grid.show.layout(Layout)
  vplayout <- function(...) {
    grid.newpage()
    pushViewport(grid::viewport(layout = Layout))
  }
  subplot <- function(x, y) viewport(layout.pos.row = x,layout.pos.col = y)
  mmplot <- function(a, b) {
    vplayout()
    print(a, vp = subplot(1, 1))
    print(b, vp = subplot(2, 1))
  }
  
  #rm(Layout)
  mmplot(p, data_table)
}


avg_silhouette <-function(model, data){
  mas <-  as.data.frame(model$mass)
  Cluster <- as.numeric(as.factor(colnames(mas)[apply(mas,1,which.max)]))
  ss <- silhouette(Cluster, dist(data, method = "manhattan"))
  return(ss)
}



