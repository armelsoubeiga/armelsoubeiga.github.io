ecmm<-function(x,c,g0=NULL,type='full',pairs=NULL,Omega=TRUE,ntrials=1,alpha=1,beta=2,delta=10,
               epsi=1e-3,init="kmeans",disp=TRUE){
  
  #---------------------- initialisations --------------------------------------
  
  x<-as.matrix(x)
  n <-nrow(x)
  d <- ncol(x)
  delta2<-delta^2
  
  if((ntrials>1) & !is.null(g0)){
    print('WARNING: ntrials>1 and g0 provided. Parameter ntrials set to 1.')
    ntrials<-1
  }
  
  F<-makeF(c,type,pairs,Omega)
  f<-nrow(F)
  card<- rowSums(F[2:f,])
  
  #------------------------ iterations--------------------------------
  Jbest<-Inf
  for(itrial in 1:ntrials){
    if(is.null(g0)){
      if(init=="kmeans") g<-kmeans(x,c)$centers else g <- x[sample(1:n,c),]+0.1*rnorm(c*d,c,d)
    } else g<- g0
    pasfini<-TRUE
    Jold <- Inf
    gplus<-matrix(0,f-1,d)
    iter<-0
    while(pasfini){
      iter<-iter+1
      for(i in 2:f){
        fi <- F[i,]
        truc <- matrix(fi,c,d)
        gplus[i-1,] <- colSums(g*truc)/sum(fi)
      }
      
      # calculation of distances to centers
      D<-matrix(0,n,f-1)
      for(j in 1:(f-1)) D[,j]<- rowSums((x-matrix(gplus[j,],n,d,byrow = TRUE))^2)
      
      # Calculation of masses
      m <- matrix(0,n,f-1)
      for(i in 1:n){
        vect0 <- D[i,]
        for(j in 1:(f-1)){
          vect1 <- (rep(D[i,j],f-1)/vect0) ^(1/(beta-1))
          vect2 <-  rep(card[j]^(alpha/(beta-1)),f-1) /(card^(alpha/(beta-1)))
          vect3 <- vect1 * vect2
          m[i,j]<- 1/(  sum(vect3) + (card[j]^alpha * D[i,j]/delta2)^(1/(beta-1))  )
          if(is.nan(m[i,j])) m[i,j]<-1 # in case the initial prototypes are training vectors
        }
      }
      
      # Calculation of centers
      A <- matrix(0,c,c)
      for(k in 1:c){
        for(l in 1:c){
          truc <- rep(0,c)
          truc[c(k,l)]<-1
          t <- matrix(truc,f,c,byrow=TRUE)
          indices <- which(rowSums((F-t)-abs(F-t))==0)    # indices of all Aj including wk and wl
          indices <- indices - 1
          if(length(indices)==0) A[l,k]<-0 else{
            for(jj in 1:length(indices)){
              j <- indices[jj]
              mj <- m[,j]^beta
              A[l,k]<-A[l,k]+sum(mj)*card[j]^(alpha-2)
            }
          }
        }
      }
      
      # Construction of the B matrix
      B<-matrix(0,c,d)
      for(l in 1:c){
        truc <- rep(0,c)
        truc[l]<-1
        t <- matrix(truc,f,c,byrow=TRUE)
        indices <- which(rowSums((F-t)-abs(F-t))==0)   # indices of all Aj including wl
        indices <- indices - 1
        mi <- matrix(card[indices]^(alpha-1),n,length(indices),byrow=TRUE) * m[,indices]^beta
        s <- rowSums(mi)
        mats <- matrix(s,n,d)
        xim <- x*mats
        B[l,]<- colSums(xim)
      }
      
      g<-solve(A,B)
      
      mvide <- 1-rowSums(m)
      J <- sum((m^beta)*D*matrix(card^alpha,n,f-1,byrow=TRUE)) + delta2*sum(mvide^beta, na.rm = TRUE)
      if(disp) print(c(iter,J))
      pasfini <- (abs(J-Jold)>epsi)
      Jold <- J
      
    } # end while loop
    if(J<Jbest){
      Jbest<-J
      mbest<-m
      gbest<-g
    }
    res<-c(itrial,J,Jbest)
    names(res)<-NULL
    if (ntrials>1) print(res)
  } #end for loop iter
  
  m <- cbind(1-rowSums(mbest),mbest)
  clus<-extractMass(m,F,g=gbest,method="ecm",crit=Jbest,
                    param=list(alpha=alpha,beta=beta,delta=delta))
  return(clus)
}









recmm<- function(D,c,type='full',pairs=NULL,Omega=TRUE,m0=NULL,ntrials=1,alpha=1,beta=1.5,
                delta=quantile(D[upper.tri(D)|lower.tri(D)],0.95),epsi=1e-4,maxit=5000,
                disp=TRUE){
  
  if((ntrials>1) & !is.null(m0)){
    print('WARNING: ntrials>1 and m0 provided. Parameter ntrials set to 1.')
    ntrials<-1
  }
  D<-as.matrix(D)
  # Scalar products computation from distances
  
  delta2<-delta^2
  names(delta2)<-NULL
  
  n<-ncol(D)
  e <- rep(1,n)
  Q <- diag(n)-e%*%t(e)/n
  XX <- -0.5 * Q %*% D %*% Q
  
  
  # Initializations
  F<-makeF(c,type,pairs,Omega)
  f<-nrow(F)
  card<- rowSums(F[2:f,])
  
  if(!is.null(m0)){
    if((nrow(m0)!= n) | (ncol(m0)!=f)){
      stop("ERROR: dimension of m0 is not compatible with specified focal sets")
    }
  }
  
  # Optimization
  
  Jbest<-Inf
  for(itrial in 1:ntrials){
    if(is.null(m0)){
      m <- matrix(runif(n*(f-1)),n,f-1)
      m <- m /rowSums(m)
    } else m<-m0[,2:f]
    
    pasfini<-TRUE
    Jold <- Inf
    Mold<- matrix(1e9,n,f)
    it <- 0
    while(pasfini & (it < maxit)){
      it <- it + 1
      # Construction of the H matrix
      H <- matrix(0,c,c)
      for(k in 1:c){
        for(l in 1:c){
          truc <- rep(0,c)
          truc[c(k,l)]<-1
          t <- matrix(truc,f,c,byrow=TRUE)
          indices <- which(rowSums((F-t)-abs(F-t))==0)    # indices of all Aj including wk and wl
          indices <- indices - 1
          if(length(indices)==0) H[l,k]<-0 else{
            for(jj in 1:length(indices)){
              j <- indices[jj]
              mj <- m[,j]^beta
              H[l,k]<-H[l,k]+sum(mj)*card[j]^(alpha-2)
            }
          }
        }
      }
      # Construction of the U matrix
      U<-matrix(0,c,n)
      for(l in 1:c){
        truc <- rep(0,c)
        truc[l]<-1
        t <- matrix(truc,f,c,byrow=TRUE)
        indices <- which(rowSums((F-t)-abs(F-t))==0)   # indices of all Aj including wl
        indices <- indices - 1
        mi <- matrix(card[indices]^(alpha-1),n,length(indices),byrow=TRUE) * m[,indices]^beta
        U[l,] <- rowSums(mi)
      }
      B <- U %*% XX
      VX<-solve(H,B)
      B <- U %*% t(VX)
      VV <- solve(H,B)
      
      # distances to focal elements
      D <- matrix(0,n,f-1)
      for(i in 1:n){
        for(j in 1:(f-1)){
          ff <- F[j+1,]
          truc <- ff %*% t(ff) # indices of pairs (wk,wl) in Aj
          indices <- which(ff==1) # indices of classes in Aj
          D[i,j]<- XX[i,i]-2*sum(VX[indices,i])/card[j]+sum(truc*VV)/(card[j]^2)
        }
      }
      # masses
      m <- matrix(0,n,f-1)
      for(i in 1:n){
        vect0 <- D[i,]
        for(j in 1:(f-1)){
          vect1 <- (rep(D[i,j],f-1)/vect0) ^(1/(beta-1))
          vect2 <-  rep(card[j]^(alpha/(beta-1)),f-1) /(card^(alpha/(beta-1)))
          vect3 <- vect1 * vect2
          m[i,j]<- 1/(  sum(vect3) + (card[j]^alpha * D[i,j]/delta2)^(1/(beta-1))  )
        }
      }
      mvide <- 1-rowSums(m)
      M <- cbind(m,mvide)
      J = sum((m^beta)*D*matrix(card^alpha,n,f-1,byrow=TRUE))+ delta2*sum(mvide^beta, na.rm = TRUE)
      DeltaM<-norm(M-Mold,type='f')/n/f
      if(disp) print(c(J,DeltaM))
      pasfini <- (DeltaM > epsi)
      Mold <- M
      Jold <- J
    } # end of 'while' loop
    if(J<Jbest){
      Jbest<-J
      mbest<-m
    }
    res<-c(itrial,J,Jbest)
    names(res)<-NULL
    if (ntrials>1) print(res)
  }
  
  
  # add mass to the empty set
  m <- cbind(1-rowSums(mbest),mbest)
  
  clus<-extractMass(m,F,method="recm",crit=Jbest)
  return(clus)
}

