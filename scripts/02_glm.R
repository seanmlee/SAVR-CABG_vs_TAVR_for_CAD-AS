

# libraries --------------------------------------------------------------------
library(tidyverse)
library(sjPlot)


# fit logistic model -----------------------------------------------------------
mod_STROKE <- glm(
  STROKE ~
    AGE +
    PRIORHS +
    Interv_num,
  family = "binomial",
  data = m.data
)
summary(mod_STROKE)
tab_model(mod_STROKE)


# predict ----------------------------------------------------------------------
critval <- 1.96

newdata <- expand.grid(
  Interv_num = c("SAVRCABG", "TAVRONLY"),
  AGE = seq(min(dat$AGE),max(dat$AGE), length.out = 100),
  PRIORHS = ("0")
)

preds <- predict(
  mod_STROKE, 
  newdata = newdata, 
  type = "link", 
  se.fit = TRUE
)

fit_link <-preds$fit
fit_response <- mod_STROKE$family$linkinv(fit_link)
upr_link <- preds$fit + (critval * preds$se.fit)
lwr_link <- preds$fit - (critval * preds$se.fit)
upr_response <- mod_STROKE$family$linkinv(upr_link)
lwr_response <- mod_STROKE$family$linkinv(lwr_link)

newdata <- cbind(
  newdata,
  fit_response,
  upr_response,
  lwr_response
)


# plot ------------------------------------------------------------------------
newdata %>%
  
  ggplot(
    aes(
      x = AGE, 
      y = fit_response,
      color = Interv_num
    )
  ) +
  
  geom_line(
    linewidth = 0.75
  ) +
  
  geom_ribbon(
    aes(
      ymin = lwr_response,
      ymax = upr_response,
      fill = Interv_num
    ),
    color = NA,
    alpha = 0.075
  ) +
  
  scale_y_continuous(
    labels = scales::percent,
    limits = c(0, 0.163)
  ) +
  
  scale_x_continuous(
    limits = c(65, 85)
  ) +
  
  scale_color_discrete(
    name = "",
    labels = c("SAVR + CABG", "TAVR")
  ) +
  
  ggtitle("") +
  
  xlab("Age (Years)") +
  
  ylab("Probability of Stroke") +
  
  theme_bw() +
  
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()
  ) +
  
  guides(fill = "none")


# write ------------------------------------------------------------------------
ggsave(
  "out/glm.png",
  width = 8,
  height = 4
)

