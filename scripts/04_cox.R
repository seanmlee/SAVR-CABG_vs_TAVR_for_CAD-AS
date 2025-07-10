

# libraries --------------------------------------------------------------------
library(tidyverse)
library(survival)
library(ggsurvfit)
library(sjPlot)


# split ------------------------------------------------------------------------
m.data.split <- survSplit(
  
  Surv(time, status) ~ .,
  data = m.data, 
  cut = c(30, 180, 730),
  episode = "tgroup", 
  id = "id"
  
)


# switch levels (because time-varying cox reverses levels) ---------------------
m.data.split <- m.data.split %>% mutate(Interv_num = factor(Interv_num, levels = c("TAVRONLY", "SAVRCABG")))


# fit cox ----------------------------------------------------------------------
mod_cox <- coxph(
  Surv(
    time,
    status
  ) ~ 
    Interv_num:strata(tgroup) +
    AGE:strata(tgroup) +
    PRIORHS
  ,
  data = m.data.split
)

summary(mod_cox)
tab_model(mod_cox)
