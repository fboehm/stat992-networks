## ---- eval=FALSE---------------------------------------------------------
## devtools::install_github("rstudio/leaflet")
## devtools::install_github("SMAPPNYU/smappR")
## devtools::install_github("pablobarbera/streamR/streamR")

## ------------------------------------------------------------------------
library(smappR)
library(streamR)
library(knitr)
opts_chunk$set(cache=TRUE, cache.extra = list(R.version, sessionInfo(), format(Sys.Date(), '%Y-%m')))

## ----seed-fol-fr, cache=TRUE---------------------------------------------
fr1 <- getFriends(screen_name = "WaleedGaj2002", oauth_folder = "~/Dropbox/credentials", sleep=60)

## ------------------------------------------------------------------------
out <- list()
for (i in 1:length(fr1)){
    out[[i]]<- getFriends(user_id = fr1[i], oauth_folder = "~/Dropbox/credentials/", sleep = 60, verbose=TRUE)
}
save.image("tmp_RData/fr-of-fr-of-wg2002.RData")

