

# libraries --------------------------------------------------------------------
library(tidyverse)
library(MatchIt)


# psm --------------------------------------------------------------------------
dat_match <- matchit(
  Interv_num ~
    AGE +
    ASA +
    DIABETES +
    CURDIUR +          
    CVD +              
    PVD +              
    COPD +
    CM +               
    CSMOK +            
    FST +              
    PRAFIB +           
    PROPIABP +         
    PRIORHS +          
    BMI +
    CHF,
  data = dat,
  method = "nearest",
  distance = "glm"
)

summary(dat_match)

m.data <- match.data(dat_match)
