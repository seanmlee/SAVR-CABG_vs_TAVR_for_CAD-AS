

# libraries --------------------------------------------------------------------
library(tidyverse)
library(table1)
library(kableExtra)


# pvalue function --------------------------------------------------------------
pvalue <- function(x, ...) {
  # Construct vectors of data y, and groups (strata) g
  y <- unlist(x)
  g <- factor(rep(1:length(x), times=sapply(x, length)))
  if (is.numeric(y)) {
    # For numeric variables, perform a standard 2-sample t-test
    p <- t.test(y ~ g)$p.value
    
  } else {
    # For categorical variables, perform a chi-squared test of independence
    p <- chisq.test(table(y, g))$p.value
  }
  # Format the p-value, using an HTML entity for the less-than sign.
  # The initial empty string places the output on the line below the variable label.
  c("", sub("<", "&lt;", format.pval(p, digits=3, eps=0.001)))
}


# table 1 for psm dataset ------------------------------------------------------
table1(~ AGE +
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
         CHF
       | Interv_num,
       overall = FALSE,
       extra.col = list(`p-value`= pvalue),
       data = m.data)


# stroke actual outcomes -------------------------------------------------------
table1::table1(
  ~as.factor(STROKE) + as.factor(PERIOPMI)| Interv_num,
  overall = FALSE,
  m.data
)


# survival table ---------------------------------------------------------------
survival_table <- summary(km_fit, times = c(30, 180, 730, 1825))
time_points <- survival_table$time
n_risk <- survival_table$n.risk
n_event <- survival_table$n.event
survival <- survival_table$surv
lower_ci <- survival_table$lower
upper_ci <- survival_table$upper
strata <- survival_table$strata

survival_table <- data.frame(
  Time = time_points,
  Group = strata,
  n_risk = n_risk,
  n_event = n_event,
  Survival = survival,
  Lower_CI = lower_ci,
  Upper_CI = upper_ci
)

survival_table <- fortify(survival_table)
survival_table$Group <- gsub("Interv_num=", "", survival_table$Group)
survival_table %>% kbl()


# write ------------------------------------------------------------------------
write.csv(survival_table, "out/tbl_survival.csv", row.names = FALSE)

