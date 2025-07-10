

# libraries --------------------------------------------------------------------
library(tidyverse)
library(haven)


# data -------------------------------------------------------------------------
dat <- read_sav("data/vasqip_data_file.sav") # enter your vasqip data filepath


# format -----------------------------------------------------------------------
CHF <- c("428.0", "428.1", "428.20", "428.21", "428.22", "428.23", "428.30", "428.31", "428.32", "428.33", "428.40", "428.41", "428.42", "428.43", "I50.1", "I50.2", "I50.3", "I50.4", "I50.8", "I50.9")

dat <- dat %>% 
  
  # lad
  filter(LAD >= 70) %>%

  # remove females (there are only 4)
  filter(SEX == 0, FST != 3, ASA != 5) %>%
  
  # format
  mutate(
    
    BMI = 703 * (WTLBS / (HTIN^2)),
    DIABETES = ifelse(DIABETES == 0, 0, 1),
    CSMOK = ifelse(CSMOK == 0, 0, 1)
    
  ) %>%
  
  # filter relevant icd
  rowwise() %>%
  mutate(
    CHF = ifelse(
      any(
        c_across(starts_with("ICD9")) %in% CHF
      ),
      1,
      0
    )
  ) %>%
  
  # select relevant variables
  dplyr::select(
    STROKE,
    PERIOPMI,
    Interv_num,
    AGE,
    SEX,
    ASA,
    DIABETES,
    CURDIUR,            # CurrentDiureticUse
    CVD,                # CerebralVascularDisease
    PVD,                # PeripheralVascularDisease
    COPD,
    CM,                 # Cardiomegaly
    CSMOK,              # CurrentSmoker
    FST,                # FunctionalStatus
    PRAFIB,             # PreoperativeAtrialFibrillation
    PROPIABP,           # PreoperativeUseOfIABP
    PRIORHS,            # PriorHeartSurgery
    BMI,                # 703 * (WTLBS / (HTIN^2))
    CHF,
    survival_days,
    survival_Days_withend
  )


# factor -----------------------------------------------------------------------
dat$SEX <- as.factor(dat$SEX)
dat$ASA <- as.factor(dat$ASA)
dat$DIABETES <- as.factor(dat$DIABETES)
dat$CURDIUR <- as.factor(dat$CURDIUR)
dat$CVD <- as.factor(dat$CVD)
dat$PVD <- as.factor(dat$PVD)
dat$COPD <- as.factor(dat$COPD)
dat$CM <- as.factor(dat$CM)
dat$CSMOK <- as.factor(dat$CSMOK)
dat$FST <- as.factor(dat$FST)
dat$PRAFIB <- as.factor(dat$PRAFIB)
dat$PROPIABP <- as.factor(dat$PROPIABP)
dat$PRIORHS <- as.factor(dat$PRIORHS)
dat$CHF <- as.factor(dat$CHF)


# change Interv_num from number codes to stored labels -------------------------
head(dat$Interv_num)
dat$Interv_num <- as_factor(dat$Interv_num)


# filter relevant groups -------------------------------------------------------
dat <- dat %>%
  
  filter(
    Interv_num %in% c("SAVRCABG", "TAVRONLY")
  ) %>%
  
  mutate(
    Interv_num = ifelse(Interv_num == "SAVRCABG", "SAVRCABG", "TAVRONLY"),
    Interv_num = factor(Interv_num, levels = c("SAVRCABG", "TAVRONLY"))
  ) 


# calculate survival data ------------------------------------------------------
dat <- dat %>%
  
  mutate(
    
    time = survival_Days_withend,
    
    time = if_else(
      time > 1825,
      1825,
      time
    ),
    
    status = case_when(
      survival_Days_withend > 1825 ~ 0,
      survival_Days_withend <= 1825 & survival_days <= 1825 ~ 1,
      TRUE ~ 0
    )
    
  ) %>%
  
  filter(
    time >=0
  ) %>%
  
  mutate(
    time = ifelse(time == 0, 1, time),
    time = ifelse(time == 1825, 1825.1, time)
  ) 
