#  File tests/target_offset.R in package ergm, part of the Statnet suite
#  of packages for network analysis, https://statnet.org .
#
#  This software is distributed under the GPL-3 license.  It is free,
#  open source, and has the attribution requirements (GPL Section 7) at
#  https://statnet.org/attribution
#
#  Copyright 2003-2020 Statnet Commons
#######################################################################
library(ergm)

data(florentine)
warnf <- function(w) NULL
library(statnet.common)
opttest({
  warnf <- function(w) stop('unexpected warning in target + offset test', w)
})
out <- tryCatch(ergm(flomarriage~offset(edges)+edges+degree(1)+offset(degree(0)),target.stats=summary(flomarriage~edges+degree(1)),
              offset.coef=c(0,-0.25),control=control.ergm(init=c(0,-1.47,0.462,-0.25))) ,
         error=function(e) stop('error in target + offset test', e), 
         warning=warnf)

if(!is.null(out)){
  summary(out)
  mcmc.diagnostics(out)
}

set.seed(1)

out <- tryCatch(ergm(flomarriage~offset(edges)+edges+gwdegree(0, fix=FALSE)+degree(0)+offset(degree(1)),target.stats=summary(flomarriage~edges+gwdegree(0, fix=FALSE)+degree(0)),
              offset.coef=c(0,-0.25)),
         error=function(e) stop('error in target + offset test', e), 
         warning=warnf)

if(!is.null(out)){
  summary(out)
  mcmc.diagnostics(out)
}
