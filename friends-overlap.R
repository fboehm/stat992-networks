## ---- eval=FALSE---------------------------------------------------------
## devtools::install_github("rstudio/leaflet")
## devtools::install_github("SMAPPNYU/smappR")
## devtools::install_github("pablobarbera/streamR/streamR")

## ------------------------------------------------------------------------
library(smappR)
library(streamR)
library(knitr)
opts_chunk$set(cache.extra = list(R.version, sessionInfo(), format(Sys.Date(), '%Y-%m')))

## ----wg-followers, cache=TRUE--------------------------------------------
# fols<- getFollowers(screen_name="WaleedGaj2002", oauth_folder = "~/Dropbox/credentials", sleep=65)
#length(fols)
fr1 <- getFriends(screen_name = "WaleedGaj2002", oauth_folder = "~/Dropbox/credentials", sleep=60)
fr2 <- getFriends(screen_name = "qqqqq12345564", oauth_folder = "~/Dropbox/credentials", sleep=60)

## ------------------------------------------------------------------------

calc_jaccard_followers <- function(id1, id2, sleep = 10){
    fol1 <- NA
    fol2 <- NA
    try(fol1 <- getFollowers(user_id=id1, sleep=sleep, oauth_folder = "~/Dropbox/credentials"))
    try(fol2 <- getFollowers(user_id=id2, sleep=sleep, oauth_folder = "~/Dropbox/credentials"))
    denom <- length(union(fol1, fol2))
    num <- length(intersect(fol1, fol2))
    ratio <- num/denom
    return(list(ratio=ratio, num=num, denom=denom, n1 = length(fol1), n2=length(fol2)))
}


samp_jaccard_followers <- function(followers=fols){
    samp <- sample(followers, size = 2, replace=FALSE)
    ji<- calc_jaccard_followers(id1=samp[1], id2 = samp[2], sleep=100)
    return(c(unlist(ji), samp[1], samp[2]))
}
calc_jaccard_friends <- function(id1, id2, sleep = 10){
    fol1 <- NA
    fol2 <- NA
    try(fol1 <- getFriends(user_id=id1, sleep=sleep, oauth_folder = "~/Dropbox/credentials"))
    try(fol2 <- getFriends(user_id=id2, sleep=sleep, oauth_folder = "~/Dropbox/credentials"))
    denom <- length(union(fol1, fol2))
    num <- length(intersect(fol1, fol2))
    ratio <- num/denom
    return(list(ratio=ratio, num=num, denom=denom, n1 = length(fol1), n2=length(fol2)))
}


samp_jaccard_friends <- function(friends=frs){
    samp <- sample(friends, size = 2, replace=FALSE)
    ji<- calc_jaccard_friends(id1=samp[1], id2 = samp[2], sleep=70)
    return(c(unlist(ji), samp[1], samp[2]))
}


## ------------------------------------------------------------------------
calc_jaccard<- function(a,b){
    denom <- length(union(a, b))
    num <- length(intersect(a, b))
    ratio <- num/denom
    return(ratio)
}

wrap <- function(id1, id2, sleep = 70){
    f1 <- NA
    f2 <- NA
    try(f1 <- getFriends(user_id=id1, sleep=sleep, oauth_folder = "~/Dropbox/credentials"))
    try(f2 <- getFriends(user_id=id2, sleep=sleep, oauth_folder = "~/Dropbox/credentials"))
    ji <- calc_jaccard(f1, f2)
    return(c(ji, id1, id2))
}



## ----replicate-----------------------------------------------------------
set.seed(2015-11-22)
replicate(expr = wrap(id1 = sample(fr1, size=1), id2 = sample(fr2, size=1)), n = 100)

save.image("tmp_RData/out-22-nov.RData")


## ------------------------------------------------------------------------
devtools::session_info()

