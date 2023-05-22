#==> Importation library
library(caret)
library(cluster)
library(RColorBrewer)
library(tidyverse)
library(purrr)
library(ggplot2)
library(randomForest)
library(Rdimtools)
library(evclust)
library(gridExtra)
library(factoextra)
library(ggpubr)
library(grid)
library(reshape2)
library(RColorBrewer)
library(WeightedCluster)
library(labelled)
library(gtsummary)
library(fpc)
library(GGally)
library(nnet)

#==> Function
source("ECM_Functions.R")
source("OTHERS_Functions.R")

#==> Importation data
df_features <- read.csv("input/df_features.csv")
summary(df_features$nb_remplissages)

#pheatmap((as.matrix(data[,-1])), display_numbers = T)

#var= 235.3112
#Une grande ecrat entre les patients en terme de nombre de
#durée de suivi. Ce qui peut entrainer une dispersion ou variabilité très élévé dans les données
#Cependant la moyenne est proche de la médiane, les valeurs ne sont pas biaisées par des valeurs extrêmes ou aberrantes

#==> Data processing
na_col <- df_features %>%
        map_df(function(x) sum(is.na(x))) %>%
        gather(feature, num_nulls)
dropList <- as.character(na_col[na_col$num_nulls>50,]$feature)
df_features <- df_features[, !colnames(df_features) %in% dropList]
imputList <- as.character(na_col[na_col$num_nulls>0 & na_col$num_nulls<50 ,]$feature)
df_features[imputList] <- colMeans(df_features[,imputList], na.rm=TRUE)  



#Suppressions variance
cls <- c("nb_remplissages","__range_count__max_5__min_0",
          "__number_cwt_peaks__n_5", "__quantile__q_")   
df_features <- df_features %>% dplyr::select(-contains(cls))


#Normalisation
c_df_features <- scale(df_features[,-1], center = TRUE, scale = FALSE)
df_features <- cbind.data.frame(user_uuid=df_features[,1], c_df_features)
#df_features <- df_features


descrCor <- cor(df_features[,-1], method = "kendall")
highlyCorDescr <- findCorrelation(descrCor, cutoff = .6)
df_features <- df_features[,-highlyCorDescr]


#unsupervised selection
set.seed(1234)
rf <- randomForest(df_features[,-1])
lscore <- Rdimtools::do.lscore(as.matrix(df_features[,-1]))
specu <- Rdimtools::do.specu(as.matrix(df_features[,-1]))
ugfs <- do.ugfs(as.matrix(df_features[,-1]))


save(df_features, rf, lscore, specu, ugfs, file = paste0("input/select/model_data.Rdata"))







#visualisation
load("input/select/model_data.Rdata") 

varimp_rf <- f.importance(rf, colnames(df_features[,-1]))
varimp_lscore <- f.importance(lscore, colnames(df_features[,-1]))
varimp_specu <- f.importance(specu, colnames(df_features[,-1]))
varimp_ugfs <- f.importance(ugfs, colnames(df_features[,-1]))

prf <- plot.importance(varimp_rf,50,TRUE,"Random Forest feature selection")
plscore <- plot.importance(varimp_lscore,50,FALSE,"Laplace Score feature selection")
pspecu <- plot.importance(varimp_specu,50,FALSE,"Spectral Feature Selection")
pugfs <- plot.importance(varimp_ugfs,50,TRUE,"Graph-based Feature Selection")

grid.arrange(prf, plscore, ncol = 2)
grid.arrange(prf, plscore, pspecu, ncol = 3)







#==> Comparaison
#Iteration sur toutes les sélection
params <- data.frame(nb_var=c(6,7,13,18,19,22,26,
                              7,10,15,18,19,26,29),
                     algorithm=c(rep('RF',7),rep('LS',7)))

model <- c('RF','LS')
set.seed(1234)
select_select(model, params, C=5, relational=FALSE)
select_select(model, params, C=5, relational=TRUE)


load("input/select/cluster_slect_Rel_FALSE.Rdata")
df_res <- do.call(rbind, mapply(transform, res, ID=seq_along(res), SIMPLIFY = FALSE))





# visualisation
load("input/select/model_data.Rdata") 


# RECM with Manhattan distance
load("input/select/cluster_slect_Rel_TRUE.Rdata")
df_res <- do.call(rbind, mapply(transform, res, ID=seq_along(res), SIMPLIFY = FALSE))
data <-  df_res %>% mutate_if(is.factor, as.character)
data$index <- 1:nrow(data)
flag<- data$index[which.max(data$ASW)]
Visualisation(data,flag, title='RECM with Manhattan distance')


# ECM with Euclidean distance
load("input/select/cluster_slect_Rel_FALSE.Rdata")
df_res <- do.call(rbind, mapply(transform, res, ID=seq_along(res), SIMPLIFY = FALSE))
data <-  df_res %>% mutate_if(is.factor, as.character)
data$index <- 1:nrow(data)
flag<- data$index[which.max(data$ASW)]
Visualisation(data,flag, title='ECM with Euclidean distance')





# ==> Clustering
# Parametres du modèle
load("input/select/model_data.Rdata") 
load("input/select/cluster_slect_Rel_FALSE.Rdata")
flag<- 2
var <- var[[flag]]
clus.ecm <- ml[[flag]]
data <- cbind.data.frame(user_uuid=df_features[,1],df_features[,var])
C <- 2

summary(clus.ecm)
var


# Etude de la silhoutte
ss <- avg_silhouette(clus.ecm,data[,-1])
fviz_silhouette(ss, label = FALSE) +
  theme_bw()+
  theme(panel.grid.major = element_blank(),
        panel.border = element_blank()) + 
  theme(panel.background = element_rect(fill = '#fffff8'),
        plot.background = element_rect(fill = "#fffff8"))

# Objects with negative silhouette
neg_sil_index <- which(ss[, 'sil_width'] < 0)
sss <-  as.data.frame(ss[neg_sil_index, , drop = FALSE])
tab <- table(sss$cluster, sss$neighbor)
library(pheatmap)
p <- pheatmap(tab, display_numbers = T, 
         color = colorRampPalette(c('white','red'))(3), angle_col=0,
         fontsize_row=14, fontsize_col=14, number_format="%.0f",
         fontsize_number=12,legend=F)

grid.draw(rectGrob(gp=gpar(fill="#fffff8", lwd=0)))
grid.draw(p)


# Statistics for ECM clustering
mas <-  as.data.frame(clus.ecm$mass)
Cluster <- as.numeric(as.factor(colnames(mas)[apply(mas,1,which.max)]))
km_stats <- cluster.stats(dist(data, method = "manhattan"),  Cluster)

km_stats_ <- do.call(rbind.data.frame, km_stats)
colnames(km_stats_) <- c("cl_1","cl_2","Cl_incertains")


#Imparct de incertain set
mas <-  as.data.frame(clus.ecm$mass)
mas$Cluster <- as.numeric(as.factor(colnames(mas)[apply(mas,1,which.max)]))
df_select_y0 <- cbind.data.frame(data, Cluster=as.factor(mas$Cluster))
df_select_y0 <- df_select_y0 %>% filter(Cluster %in% c(1,2))
df_select_y0$Cluster <- as.numeric(df_select_y0$Cluster)
df_y0 <- df_select_y0 %>% select(-contains(c("user_uuid","Cluster")))
ss <- silhouette(df_select_y0$Cluster, dist(df_y0, method = "manhattan"))
fviz_silhouette(ss, label = FALSE) +
  theme_bw()+
  theme(panel.grid.major = element_blank(),
        panel.border = element_blank()) + 
  theme(panel.background = element_rect(fill = '#fffff8'),
        plot.background = element_rect(fill = "#fffff8"))



##### Visualisation
mas <- as.data.frame(clus.ecm$mass)
result <- c()
for (i in 1:C) {
  if (i == 1) {result <- c(result, '1')}
  else if(i == 2){result <- c(result, '2')}
  else{result <- c(result,as.character(i), paste0(i, '_',1:(i-1)))}
}
colnames(mas) <- c("Cl_atypique", result, "Cl_incertains")
mas$Cluster <- colnames(mas)[apply(mas,1,which.max)]
df_select_y <- cbind.data.frame(data, Cluster=as.factor(mas$Cluster))





# ACP
pca_res <- prcomp(data[,-1], scale. = F)
ind.coord <- as.data.frame(get_pca_ind(pca_res)$coord)
eigenvalue <- round(get_eigenvalue(pca_res), 1)
variance.percent <- eigenvalue$variance.percent
ind.coord$Cluster <- df_select_y$Cluster

#Plot
pcolor <- colorspace::qualitative_hcl(as.numeric(length(unique(df_select_y$Cluster))), "Dark2")
ggscatter(
  ind.coord, x = "Dim.1", y = "Dim.2", 
  color = "Cluster", palette = pcolor ,  ellipse = F, 
  xlab = paste0("Dim 1 (", variance.percent[1], "% )" ),
  ylab = paste0("Dim 2 (", variance.percent[2], "% )" ),
  mean.point = TRUE, star.plot = TRUE) +
  stat_mean(aes(color = Cluster), size = 5) +
  theme_minimal()



# Hierarchical clustering visualisation
hc.res <- eclust(data[,-1], "hclust", k = 3, hc_metric = "euclidean", 
                 hc_method = "ward.D2", graph = FALSE)
fviz_dend(hc.res, show_labels = FALSE, type = "phylogenic", palette = pcolor,
          phylo_layout = "layout_with_lgl") 

#,phylo_layout = "layout_as_tree"




#biplot
fviz_pca_biplot(pca_res, label = "var",addEllipses=F, 
          geom.ind = "point",pointshape = 21,pointsize = 2.5,labelsize = 2,
          fill.ind = ind.coord$Cluster,
          ggtheme = theme_minimal())



#dendextend
library(dendextend)
row_dend = hclust(dist(data[,-1])) # row clustering
col_dend = hclust(dist(t(data[,-1]))) # column clustering
Heatmap(data[,-1],  
        row_names_gp = gpar(fontsize = 6.5),
        cluster_rows = color_branches(row_dend, k = 3),
        cluster_columns = color_branches(col_dend, k = 2))


heatmap(as.matrix(data[,-1]), Colv=T,
        hclustfun=function(x) hclust(x, method="ward.D2"), scale='none', col=pcolor,cexCol=0.6)






##### categorisation des clusters
stat.comp<-function(x,y){
  #K <-length(unique(y))
  n <-length(x)
  m <-mean(x)
  TSS <-sum((x-m)^2)
  nk<-table(y)
  mk<-tapply(x,y,mean)
  BSS <-sum(nk* (mk-m)^2)
  result<-c(mk,100.0*BSS/TSS)
  #nm <- ifelse(nchar(names(result))<2,)
  K <- length(names(result)[nchar(names(result))<2])
  names(result)[nchar(names(result))<2] <- c(paste("Cl_",1:(K-1)),"% epl.")
  return(result)
}

df_c <- df_select_y
C <-length(unique(df_c$Cluster))
df_c$Cluster <- factor(df_c$Cluster)
contrib <- sapply(df_c[,-which(names(df_c) %in% c("user_uuid","Cluster","Cluster.f"))],
                  stat.comp,y=df_c$Cluster)
barplot(contrib, 
        legend = rownames(contrib), beside=TRUE, 
        las=1, cex.names=.7,
        args.legend = list(x ='topright',cex=0.6))


library(pheatmap)
annotation_col <- as.data.frame(contrib[4,])
names(annotation_col) <- "% epl."
ann_colors = list(`% epl.` = c('#D4D8F9','#071DF5'))
p <- pheatmap(contrib[-4,], display_numbers = T, 
         color = colorRampPalette(c('white','red'))(7), angle_col=45,
         fontsize_row=10, fontsize_col=8, number_format="%.2f",
         fontsize_number=10,legend=F,
         
         annotation_col = annotation_col,
         annotation_legend = TRUE,
         annotation_colors = ann_colors)






##### Analyse descriptive
df_suivi <- df_select_y

df_names <- read.csv("input/db_patients.csv", encoding="UTF-8",stringsAsFactors=FALSE)
df_names$uuid_patient <- gsub('-','',df_names$uuid_patient)
names(df_names)[1] <- 'user_uuid'
df_fusion <- merge(df_names, df_suivi, by="user_uuid",all.y =TRUE)
df_fusion2 <- df_fusion



#l'impact des données incertaines sur la qualité d'un clustering évidentiel
#=> Significativité des groupes
## Analyse de variance (ANOVA)
df_fusion2$Cluster_ <- ifelse(df_fusion2$Cluster=="2",2,
                              ifelse(df_fusion2$Cluster=="1",1,3))
fmla <- as.formula(paste("Cluster_ ~ ", paste(var, collapse= "+")))
tbl1  <- df_fusion2 %>%
        gtsummary::tbl_summary(by = "Cluster_", include = var) %>%
        gtsummary::add_p(test = everything() ~ "aov")

tbl2  <- df_fusion2[df_fusion2$Cluster_==1 | df_fusion2$Cluster_==2,] %>%
  gtsummary::tbl_summary(by = "Cluster_", include = var) %>%
  gtsummary::add_p(test = everything() ~ "aov")



## Analyse de la stabilité




## Analyse de densité
df_fusion2_ <- df_fusion2
df_ <- df_fusion2_ %>% select(var)
dudahart2(df_, df_fusion2_$Cluster_ )
round(calinhara(df_, df_fusion2_$Cluster_),digits=2)


df_fusion2_ <- df_fusion2[df_fusion2$Cluster_==1 | df_fusion2$Cluster_==2,]
df_ <- df_fusion2_ %>% select(var)
dudahart2(df_, df_fusion2_$Cluster_)
round(calinhara(df_, df_fusion2_$Cluster_),digits=2)







#=> Significativité des variables personnelles
df_fusion2 <- df_fusion

# df_fusion2 <- df_fusion2[df_fusion2$Cluster %in% c("1", "2"),]
# k <- length(unique(df_fusion2$Cluster))
# df_fusion2$Cluster <- factor(as.character(df_fusion2$Cluster),levels=c(1:k),labels=paste0("Cl_", 1:k))
df_fusion2$Cluster <- plyr::mapvalues(df_fusion2$Cluster, from = c("1","2","Cl_incertains"), 
                        to = c("Cl_1","Cl_2","Cl_incertains")) 



#df_fusion2$age <- as.integer(format(Sys.Date(), "%Y")) - df_fusion2$age
df_fusion2 <- df_fusion2 %>%
  mutate_at(vars(starts_with("age")),
            list(~case_when((18 <= . & . < 25) ~ "18 et 30 ans excluss",
                           (25 <= . & . < 60)  ~ "30 et 50 ans inclus",
                           (. >=60)  ~ "Plus 50 ans")))


df_fusion2 <- df_fusion2 %>% 
  mutate_at(vars(starts_with("nb_enfants_charge")),
            list(~case_when((. == 0) ~ "Pas d'enfants",
                           (1 <= . & . <= 2)  ~ "1 et 2 enfants",
                           (. > 2)  ~ "Plus 2 enfants")))

df_fusion2 <- df_fusion2 %>%
  mutate_at(vars(starts_with("niv_etudes")),
            list(~case_when((. %in% c("BEP","Brevet","CAP")) ~ "Secondaire",
                           (. %in% c("BAC+2","BAC+3")) ~ "Intermédiaire",
                           !( . %in% c("BAC", "BAC+2","BAC+3","BEP","Brevet","CAP"))  ~ "Avancé",
                           (. == "BAC")  ~ "BAC")))

df_fusion2 <- df_fusion2 %>%
  mutate_at(vars(starts_with("tabac_nb_cig_jour")),
            list(~case_when((. == "0 (non fumeur)") ~ "Non",
                           (. != "0 (non fumeur)")  ~ "Oui")))

df_fusion2 <- df_fusion2 %>%
  mutate_at(vars(starts_with("profession")),
            list(~case_when((. %in% c("Agriculteurs exploitants","Brevet","CAP")) ~ "Secondaire",
                           (. %in% c("BAC+2","BAC+3")) ~ "Intermédiaire",
                           !( . %in% c("BAC", "BAC+2","BAC+3","BEP","Brevet","CAP"))  ~ "Avancé",
                           (. == "BAC")  ~ "BAC")))

df_fusion2 <- df_fusion2 %>%
    mutate_at(vars(starts_with("alcool_frequence")),
              list(~case_when((. == "Jamais") ~ "Non",
                             (. != "Jamais")  ~ "Oui")))
df_fusion2$alcool_nb_verres_jr <- ifelse(df_fusion2$alcool_frequence=="Jamais","Jamais",df_fusion2$alcool_nb_verres_jr)

df_fusion2 <- df_fusion2 %>%
   mutate_at(vars(starts_with("diag_connaissance")),
             list(~case_when((. == 'False') ~ "Non",
                            (. == 'True')  ~ "Oui")))

df_fusion2$genre <- ifelse(df_fusion2$genre=="Féminin",'Feminin', 
                           ifelse(df_fusion2$genre=='Masculin','Masculin', 'Autres'))

explanatory <- c('age' = 'Age',
                 'nb_enfants_charge' = 'Nbr enfants',
                 'niv_etudes' = 'Niveau Etudes',
                 'profession' = 'Profession',
                 'tabac_nb_cig_jour' = 'Fumeur',
                 'alcool_frequence' = 'Buveurs',
                 'diag_connaissance' = 'Diagnostic',
                 'duree_douleur' = 'Duree Douleur',
                 'frequence_douleur' = 'Frequence Douleur',
                 'duree_crises' = 'Duree Crises',
                 'frequence_crises' = 'Frequence Crises',
                 'reveil_nuit' = 'Reveil Nuit',
                 'empeche_dormir' = 'Empeche Dormir',
                 'situation_famille' = 'Situation Famille',
                 'genre' = 'Genre')

tbl_t_perso <- df_fusion2 %>%
              ungroup() %>%
              labelled::unlabelled() %>% 
              gtsummary::tbl_summary(by = "Cluster", include = names(explanatory), label=explanatory) %>%
              gtsummary::add_p(test.args = ~ list(simulate.p.value=TRUE)) %>% #workspace=2e8
              gtsummary::bold_labels() %>% 
              gtsummary::modify_header(label = "**Variable**")

save(tbl_t_perso, file = paste0("input/select/tbl_t_perso.Rdata"))
load("input/select/tbl_t_perso.Rdata")
tbl_t_perso


# save
write.csv(df_fusion2[,c("user_uuid", names(explanatory))], "input/db_patients_clean.csv", row.names=FALSE)
write.csv(df_fusion[,1:28], "input/db_patients_all.csv", row.names=FALSE)


#==> Significativité des variables cliniques
# Utilisation de ANOVA mixte ou  Fisher exact mixte 
# pour prendre en compte les mesures répétées au fil du temps

# Perception Douleur
# 1. catastrophisme
pcs <- read.csv("input/autoq/result-ArmelSoubeiga-quest-catastrophisme-pcs-cf.csv", encoding="UTF-8",stringsAsFactors=FALSE)
pcs <- pcs %>% select(c('uuid_patient', ends_with("result_1"))) %>%
          pivot_longer(cols = -uuid_patient, names_to = "time", values_to = "Catastrophisme",values_drop_na = T) %>% select(-time) %>%
          mutate(Catastrophisme=ifelse(Catastrophisme>30, "Catastrophisme avere", 'Catastrophisme non-avere')) %>%
          set_variable_labels(Catastrophisme='Catastrophisme')

# 2. Kinesiophobie
tsk <- read.csv("input/autoq/result-ArmelSoubeiga-quest-kinesiophobie-tsk.csv", encoding="UTF-8",stringsAsFactors=FALSE)
tsk <- tsk %>% select(c('uuid_patient', ends_with("result_1"))) %>%
        pivot_longer(cols = -uuid_patient, names_to = "time", values_to = "Kinesiophobie",values_drop_na = T) %>% select(-time) %>%
        mutate(Kinesiophobie=ifelse(Kinesiophobie>37, "Kinesiophobie avere", 'Kinesiophobie non-avere')) %>%
        set_variable_labels(Kinesiophobie='Kinésiophobie')

# 3. Croyance et perception PBPI Culpabilité
pbpi <- read.csv("input/autoq/result-ArmelSoubeiga-quest-perception-douleur-pbpi.csv", encoding="UTF-8",stringsAsFactors=FALSE)
pbpi <- pbpi %>% select(c('uuid_patient', contains("_result_"))) %>%
        tidyr::gather(key, value, -uuid_patient, na.rm = TRUE) %>%
        tidyr::separate(key, into = c("variable", "stat"), sep="_", extra = "merge") %>%
        tidyr::spread(stat, value) %>% select(-variable) %>%
        mutate(Culpabilite=ifelse(result_1>=0, "Douleur culpabilité", 'Douleur non-culpabilité'),
               Mystere=ifelse(result_2>=0, "Douleur mystère", 'Douleur non-mystère'),
               Perenite=ifelse(result_3>=0, "Douleur peréne", 'Douleur non-peréne'),
               Constance=ifelse(result_4>=0, "Douleur constant", 'Douleur non-constant')) %>% 
        select(-starts_with("result_"))%>%
        set_variable_labels(Culpabilite='Croyance et perception Culpabilite',
                            Mystere='Croyance et perception Mystere',
                            Perenite='Croyance et perception Perenite',
                            Constance='Croyance et perception Constance')




# Profil Psy
# 1. Personnalité
bfi <- read.csv("input/autoq/result-ArmelSoubeiga-quest-personnalite-bfi.csv", encoding="UTF-8",stringsAsFactors=FALSE)
bfi <- bfi %>% select(c('uuid_patient', contains("_result_"))) %>%
        tidyr::gather(key, value, -uuid_patient, na.rm = TRUE) %>%
        tidyr::separate(key, into = c("variable", "stat"), sep="_", extra = "merge") %>%
        tidyr::spread(stat, value) %>% select(-variable) %>%
        setNames(c("uuid_patient","Originalite","Nevrotique","Conscience","Agreable","Enthousiasme"))%>%
        set_variable_labels(Originalite="Personnalité Ouvert d'esprit, Originalité",
                            Nevrotique="Personnalité Névrotique, Négatif",
                            Conscience="Personnalité de nature Conscience, Contrôle, Contrainte",
                            Agreable="Personnalité de nature Agréable, Altruiste",
                            Enthousiasme="Personnalité de nature Enthousiasme, Extraverti")
  
# 2 Alexithymie
tas <- read.csv("input/autoq/result-ArmelSoubeiga-quest-alexithymie-tas20.csv", encoding="UTF-8",stringsAsFactors=FALSE)
tas <- tas %>% select(c('uuid_patient', ends_with("result_1"))) %>%
      pivot_longer(cols = -uuid_patient, names_to = "time", values_to = "Alexithymie",values_drop_na = T) %>% select(-time) %>%
      mutate(Alexithymie=ifelse(Alexithymie>61, "Alexithymie avere", 'Alexithymie non-avere'))%>%
      set_variable_labels(Alexithymie='Alexithymie')

# 3 Orientation de vie Croyance justice
lot <- read.csv("input/autoq/result-ArmelSoubeiga-quest-fonctionnement-lot-r-cmj.csv", encoding="UTF-8",stringsAsFactors=FALSE)
lot <- lot %>% select(c('uuid_patient', contains("_result_"))) %>%
      tidyr::gather(key, value, -uuid_patient, na.rm = TRUE) %>%
      tidyr::separate(key, into = c("variable", "stat"), sep="_", extra = "merge") %>%
      tidyr::spread(stat, value) %>% select(-variable) %>%
      setNames(c("uuid_patient","Orientation_vie","Croyance_justice")) %>%
      set_variable_labels(Orientation_vie='Orientation de vie : optimiste',
                          Croyance_justice='Croyance justice : sa douleur est une injustice')

# 4 Injustice
ieq <- read.csv("input/autoq/result-ArmelSoubeiga-quest-sentiment-dinjustice-ieq-cf.csv", encoding="UTF-8",stringsAsFactors=FALSE)
ieq <- ieq %>% select(c('uuid_patient', ends_with("result_3"))) %>%
      pivot_longer(cols = -uuid_patient, names_to = "time", values_to = "Injustice",values_drop_na = T) %>% select(-time) %>%
      set_variable_labels(Injustice='Injustice : sa douleur est une injustice')

# Comorbidités
# 1 Anxiété & Dépression
had <- read.csv("input/autoq/result-ArmelSoubeiga-quest-anxiete-depression-had.csv", encoding="UTF-8",stringsAsFactors=FALSE)
had <- had %>% select(c('uuid_patient', contains("_result_"))) %>%
      tidyr::gather(key, value, -uuid_patient, na.rm = TRUE) %>%
      tidyr::separate(key, into = c("variable", "stat"), sep="_", extra = "merge") %>%
      tidyr::spread(stat, value) %>% select(-variable) %>%
      mutate(Depression=ifelse(result_1>=11, "Dépression avérée", 'Dépression non-avérée'),
             Anxiete=ifelse(result_2>=11, "Anxiété avérée", 'Anxiété non-avérée')) %>%   select(-starts_with("result_")) %>%
     set_variable_labels(Depression='Dépression',Anxiete='Anxiété')

# 2 Troubles cognitifs 
qpc <- read.csv("input/autoq/result-ArmelSoubeiga-quest-fonctions-cognitives-qpc.csv", encoding="UTF-8",stringsAsFactors=FALSE)
qpc <- qpc %>% select(c('uuid_patient', ends_with("result_1"))) %>%
  pivot_longer(cols = -uuid_patient, names_to = "time", values_to = "Troubles_cognitifs",values_drop_na = T) %>% select(-time) %>%
  mutate(Troubles_cognitifs=ifelse(Troubles_cognitifs>3, "Troubles probables", 'Troubles non-probables'))%>%
  set_variable_labels(Troubles_cognitifs='Troubles cognitifs')

# 3 Troubles sommeil
mos <- read.csv("input/autoq/result-ArmelSoubeiga-quest-sommeil-mos-ss.csv", encoding="UTF-8",stringsAsFactors=FALSE)
mos <- mos %>% select(c('uuid_patient', ends_with("result_2"))) %>%
  pivot_longer(cols = -uuid_patient, names_to = "time", values_to = "Troubles_sommeil",values_drop_na = T) %>% select(-time)%>%
  set_variable_labels(Troubles_sommeil='Troubles sommeil')



# Qualité de vie
# 1. Qualité de vie
eq <- read.csv("input/autoq/result-ArmelSoubeiga-quest-qualite-de-vie-eq-5d-3l.csv", encoding="UTF-8",stringsAsFactors=FALSE)
eq <- eq %>% select(c('uuid_patient', contains("_result_"))) %>%
      tidyr::gather(key, value, -uuid_patient, na.rm = TRUE) %>%
      tidyr::separate(key, into = c("variable", "stat"), sep="_", extra = "merge") %>%
      tidyr::spread(stat, value) %>% select(-variable) %>%
      setNames(c('uuid_patient','EQ_Etat_sante','EQ_Anxiete','EQ_Douleurs', 'EQ_Activites', 'EQ_Autonomie', 'EQ_mobilite', 'EQ_Total'))%>%
     set_variable_labels(EQ_Etat_sante='Qualité de vie : bonne santé', EQ_Anxiete="Qualité de vie : problèmes d'anxiété",
                         EQ_Douleurs="Qualité de vie :  problèmes de douleur",  EQ_Activites="Qualité de vie : problèmes d'activité",
                         EQ_Autonomie="Qualité de vie : problèmes d'autonomie", EQ_mobilite="Qualité de vie : problèmes de mobilité",
                         EQ_Total='Qualité de vie')

# 2 Impact douleur sur vie 
fabq <- read.csv("input/autoq/result-ArmelSoubeiga-quest-douleur-activite-fabq.csv", encoding="UTF-8",stringsAsFactors=FALSE)
fabq <- fabq %>% select(c('uuid_patient', contains("_result_"))) %>%
        tidyr::gather(key, value, -uuid_patient, na.rm = TRUE) %>%
        tidyr::separate(key, into = c("variable", "stat"), sep="_", extra = "merge") %>%
        tidyr::spread(stat, value) %>% select(-variable) %>%
        setNames(c('uuid_patient','Impact_douleur_Travail','Impact_douleur_Physique'))%>%
        set_variable_labels(Impact_douleur_Travail='Impact douleur sur le travail',
                            Impact_douleur_Physique="Impact douleur sur le physique")

# 3 Satisfaction de vie
swls <- read.csv("input/autoq/result-ArmelSoubeiga-quest-satisfaction-de-vie-swls.csv", encoding="UTF-8",stringsAsFactors=FALSE)
swls <- swls %>% select(c('uuid_patient', contains("_result_"))) %>%
  pivot_longer(cols = -uuid_patient, names_to = "time", values_to = "Satisfaction_vie",values_drop_na = T) %>% select(-time)%>%
  set_variable_labels(Satisfaction_vie='Satisfaction de vie')


# Quest. Spécifiques
# 1. Fibromyalgie
fiq <- read.csv("input/autoq/result-ArmelSoubeiga-quest-fibromyalgie-qif.csv", encoding="UTF-8",stringsAsFactors=FALSE)
fiq <- fiq %>% select(c('uuid_patient', ends_with("result_1"))) %>%
  pivot_longer(cols = -uuid_patient, names_to = "time", values_to = "Fibromyalgie",values_drop_na = T) %>% select(-time)%>%
  set_variable_labels(Fibromyalgie='Fibromyalgie')

# 2 Neuropathie
npsi <- read.csv("input/autoq/result-ArmelSoubeiga-quest-douleurs-neuropathiques-qedn.csv", encoding="UTF-8",stringsAsFactors=FALSE)
npsi <- npsi %>% select(c('uuid_patient', ends_with("result_1"))) %>%
  pivot_longer(cols = -uuid_patient, names_to = "time", values_to = "Neuropathie",values_drop_na = T) %>% select(-time)%>%
  set_variable_labels(Neuropathie='Neuropathie')

# 3 Intestin irritable
ibs <- read.csv("input/autoq/result-ArmelSoubeiga-quest-intestin-irritable-ibs-sss.csv", encoding="UTF-8",stringsAsFactors=FALSE)
ibs <- ibs %>% select(c('uuid_patient', ends_with("result_1"))) %>%
  pivot_longer(cols = -uuid_patient, names_to = "time", values_to = "Intestin_irritable",values_drop_na = T) %>% select(-time)%>%
  set_variable_labels(Intestin_irritable='Intestin irritable')


# 4 Impact douleur sur travail
mbi <- read.csv("input/autoq/result-ArmelSoubeiga-quest-perception-du-travail-mbi.csv", encoding="UTF-8",stringsAsFactors=FALSE)
mbi <- mbi %>% select(c('uuid_patient', contains("_result_"))) %>%
        tidyr::gather(key, value, -uuid_patient, na.rm = TRUE) %>%
        tidyr::separate(key, into = c("variable", "stat"), sep="_", extra = "merge") %>%
        tidyr::spread(stat, value) %>% select(-variable) %>%
        mutate(Accomplissement=ifelse(result_1>=33, "Burn-out élevé", 'Burn-out non-élevé'),
               Dpersonnalisation=ifelse(result_2>=12, "Burn-out élevé", 'Burn-out non-élevé'),
               Epuisement=ifelse(result_3>=30, "Burn-out élevé", 'Burn-out non-élevé')) %>% 
        select(-starts_with("result_"))
  
# 5 Stress post-traumatique 
pcls <- read.csv("input/autoq/result-ArmelSoubeiga-quest-stress-post-traumatique-pcls.csv", encoding="UTF-8",stringsAsFactors=FALSE)
pcls <- pcls %>% select(c('uuid_patient', ends_with("result_1"))) %>%
  pivot_longer(cols = -uuid_patient, names_to = "time", values_to = "Stress_traumatique",values_drop_na = T) %>% select(-time) %>%
  mutate(Stress_traumatique=ifelse(Stress_traumatique>=44, "Stress post-traumatique suspecté", 'Stress post-traumatique non-suspecté'))

# 6 Polyarthrite rhumatoide
raid <- read.csv("input/autoq/result-ArmelSoubeiga-quest-polyarthrite-rhumatoide-raid.csv", encoding="UTF-8",stringsAsFactors=FALSE)
raid <- raid %>% select(c('uuid_patient', ends_with("result_1"))) %>%
  pivot_longer(cols = -uuid_patient, names_to = "time", values_to = "Polyarthrite_rhumatoide",values_drop_na = T) %>% select(-time)

# 7 Migraine/céphalée
hit <- read.csv("input/autoq/result-ArmelSoubeiga-quest-migraine-hit.csv", encoding="UTF-8",stringsAsFactors=FALSE)
hit <- hit %>% select(c('uuid_patient', ends_with("result_1"))) %>%
  pivot_longer(cols = -uuid_patient, names_to = "time", values_to = "Migraine",values_drop_na = T) %>% select(-time) %>%
  mutate(Migraine=ifelse(Migraine>55, "Migraine majeur", 'Migraine non-majeur'))

# 8 Lombalgie
rmdq <- read.csv("input/autoq/result-ArmelSoubeiga-quest-lombalgie-rmqd.csv", encoding="UTF-8",stringsAsFactors=FALSE)
rmdq <- rmdq %>% select(c('uuid_patient', ends_with("result_1"))) %>%
  pivot_longer(cols = -uuid_patient, names_to = "time", values_to = "Lombalgie",values_drop_na = T) %>% select(-time)

# 9 Arthrose
womac <- read.csv("input/autoq/result-ArmelSoubeiga-quest-arthrose-womac.csv", encoding="UTF-8",stringsAsFactors=FALSE)
womac <- womac %>% select(c('uuid_patient', ends_with("result_1"))) %>%
  pivot_longer(cols = -uuid_patient, names_to = "time", values_to = "Arthrose",values_drop_na = T) %>% select(-time)


# Test
df_fisrt <- df_select_y[,c("user_uuid","Cluster")]
# df_fisrt <- df_fisrt[df_fisrt$Cluster %in% c("1", "2"),]
# df_fisrt$Cluster <- factor(as.character(df_fisrt$Cluster),levels=c(1:2),labels=paste0("Cl_", 1:2))

df_fisrt$Cluster <- plyr::mapvalues(df_fisrt$Cluster, from = c("1","2","Cl_incertains"), 
                                      to = c("Cl_1","Cl_2","Cl_incertains")) 

df_list <- list(pcs,tsk,pbpi, bfi, tas, lot, ieq, had, qpc, mos, eq, fabq, 
                swls, fiq, npsi, ibs, mbi, pcls, raid, hit, rmdq, womac)

tbl_list <- lapply(seq_along(df_list), function(i) {
      df_fisrt_list <- list(df_fisrt,df_list[[i]])
      df_list_renamed <- map(df_fisrt_list, ~rename_at(.x, 1, ~"user_uuid"))
      df_list_renamed[-1]  <- df_list_renamed[-1] %>% map(~ .x %>% mutate(user_uuid = gsub('-','', user_uuid)))
      df_merged <- reduce(df_list_renamed, left_join, by = "user_uuid")
      
      t <- df_merged %>%
        gtsummary::tbl_summary(by = "Cluster",missing = "no", include = -user_uuid,
                    statistic = list(all_continuous() ~ "{mean} ({sd})", all_categorical() ~ "{n} ({p}%)")) %>%
        add_n(footnote = TRUE) %>%
        gtsummary::add_p(test = list(all_categorical() ~ "fisher.test",all_continuous() ~ "kruskal.test"),
                  test.args = all_tests("fisher.test") ~ list(simulate.p.value = TRUE)) %>% 
        gtsummary::bold_labels() %>%
        gtsummary::modify_header(label = "**Variable**") %>%
        gtsummary::modify_footnote(all_stat_cols() ~ "Mean(sd) or n(%)")
      
      return(t)
})

tbl_list_auto <- gtsummary::tbl_stack(tbl_list)
save(tbl_list_auto, file = paste0("input/select/tbl_list_auto.Rdata"))
load("input/select/tbl_list_auto.Rdata")
as_gt(tbl_list_auto) %>%  gt::tab_options(table.background.color="#fffff8")            








## Régression logistique multinomiale
df_fusion_perso <- df_fusion2
# df_fusion_perso$Cluster <- plyr::mapvalues(df_fusion_perso$Cluster, from = c("1","2","Cl_incertains"), 
#                                       to = c("Cl_1","Cl_2","Cl_incertains")) 
var_select <- c('age','tabac_nb_cig_jour','alcool_frequence','frequence_douleur',
                'frequence_crises', 'reveil_nuit','empeche_dormir')
fmla <- as.formula(paste("Cluster ~ ", paste(var_select, collapse= "+")))
regm <- nnet::multinom(fmla, data = df_fusion_perso)

# Sélection de modèles: La phase des tests statistiques ont permis de selectionner les variables
# qui expliquent significativement l'appartennance à un cluster. Mais cette analyse ne prend
# pas en compte l'interraction multi-dimension. Et cette interaction peux induire une selection de modèle
# Ici on se base sur le critère AIC
#regm2 <- step(regm)
var_select <- c('age','frequence_crises', 'reveil_nuit', 'empeche_dormir')
fmla <- as.formula(paste("Cluster ~ ", paste(var_select, collapse= "+")))
regm2 <- nnet::multinom(fmla, data = df_fusion_perso)


# validation du modèle sélectionné
anova(regm, regm2, test = "Chisq")
# Il n’y a pas de différences significatives entre nos deux modèles. 
# Autrement dit, notre second modèle explique tout autant de variance que notre premier modèle, 
# tout en étant plus parcimonieux.

# Representation
regm2_plot <- ggcoef_multinom(regm2, exponentiate = TRUE)
regm2_plot

save(regm, regm2, regm2_plot, file = paste0("input/select/multinomiale_personal_data.Rdata"))
load("input/select/multinomiale_personal_data.Rdata")






## modèle mixtes - Perception Douleur
#Ce type de modèle permet de prendre en compte la structure de corrélation entre les mesures répétées d'une même variable explicative.
df_fisrt_list <- list(df_fisrt,pcs,tsk,pbpi)
df_list_renamed <- map(df_fisrt_list, ~rename_at(.x, 1, ~"user_uuid"))
df_list_renamed[-1]  <- df_list_renamed[-1] %>% map(~ .x %>% mutate(user_uuid = gsub('-','', user_uuid)))
df_merged <- reduce(df_list_renamed, left_join, by = "user_uuid")

var_select <- names(df_merged %>% select(-c(user_uuid, Cluster)))
fmla <- as.formula(paste("Cluster ~ ", paste(var_select, collapse= "+")))
regmm <- nnet::multinom(fmla, data = df_merged)
#regmm2 <- step(regmm)
regmm_plot <- ggcoef_multinom(regmm, exponentiate = TRUE)
save(regmm, regmm_plot, file = paste0("input/select/multinomiale_perception_data.Rdata"))




## modèle mixtes - Profil Psy
df_fisrt_list <- list(df_fisrt,bfi,tas,lot,ieq)
df_list_renamed <- map(df_fisrt_list, ~rename_at(.x, 1, ~"user_uuid"))
df_list_renamed[-1]  <- df_list_renamed[-1] %>% map(~ .x %>% mutate(user_uuid = gsub('-','', user_uuid)))
df_merged <- reduce(df_list_renamed, left_join, by = "user_uuid")

var_select <- names(df_merged %>% select(-c(user_uuid, Cluster)))
fmla <- as.formula(paste("Cluster ~ ", paste(var_select, collapse= "+")))
regmm <- nnet::multinom(fmla, data = df_merged)
#regmm2 <- step(regmm)
regmm_plot <- ggcoef_multinom(regmm, exponentiate = TRUE)
save(regmm, regmm_plot, file = paste0("input/select/multinomiale_ProfilPsy_data.Rdata"))







## modèle mixtes - Comorbidités
df_fisrt_list <- list(df_fisrt,had,qpc,mos)
df_list_renamed <- map(df_fisrt_list, ~rename_at(.x, 1, ~"user_uuid"))
df_list_renamed[-1]  <- df_list_renamed[-1] %>% map(~ .x %>% mutate(user_uuid = gsub('-','', user_uuid)))
df_merged <- reduce(df_list_renamed, left_join, by = "user_uuid")

var_select <- names(df_merged %>% select(-c(user_uuid, Cluster)))
fmla <- as.formula(paste("Cluster ~ ", paste(var_select, collapse= "+")))
regmm <- nnet::multinom(fmla, data = df_merged)
#regmm2 <- step(regmm)
regmm_plot <- ggcoef_multinom(regmm, exponentiate = TRUE)
save(regmm, regmm_plot, file = paste0("input/select/multinomiale_Comorbidites_data.Rdata"))









## modèle mixtes - Qualité de vie
df_fisrt_list <- list(df_fisrt,eq,fabq,swls)
df_list_renamed <- map(df_fisrt_list, ~rename_at(.x, 1, ~"user_uuid"))
df_list_renamed[-1]  <- df_list_renamed[-1] %>% map(~ .x %>% mutate(user_uuid = gsub('-','', user_uuid)))
df_merged <- reduce(df_list_renamed, left_join, by = "user_uuid")

var_select <- names(df_merged %>% select(-c(user_uuid, Cluster)))
fmla <- as.formula(paste("Cluster ~ ", paste(var_select, collapse= "+")))
regmm <- nnet::multinom(fmla, data = df_merged)
regmm2 <- step(regmm)
regmm2_plot <- ggcoef_multinom(regmm2, exponentiate = TRUE)
save(regmm, regmm2, regmm2_plot, file = paste0("input/select/multinomiale_QualiteVie_data.Rdata"))






## modèle mixtes - Quest. Spécifiques ibs, pcls, raid, hit, rmdq, womac
df_fisrt_list <- list(df_fisrt,fiq, npsi, mbi)
df_list_renamed <- map(df_fisrt_list, ~rename_at(.x, 1, ~"user_uuid"))
df_list_renamed[-1]  <- df_list_renamed[-1] %>% map(~ .x %>% mutate(user_uuid = gsub('-','', user_uuid)))
df_merged <- reduce(df_list_renamed, left_join, by = "user_uuid")

var_select <- names(df_merged %>% select(-c(user_uuid, Cluster)))
fmla <- as.formula(paste("Cluster ~ ", paste(var_select, collapse= "+")))
regmm <- nnet::multinom(fmla, data = df_merged)
#regmm2 <- step(regmm)
regmm_plot <- ggcoef_multinom(regmm, exponentiate = TRUE)
save(regmm,  regmm_plot, file = paste0("input/select/multinomiale_QuestSpecifiques_data.Rdata"))

