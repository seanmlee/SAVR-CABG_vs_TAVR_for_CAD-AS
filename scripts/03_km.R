

# libraries --------------------------------------------------------------------
library(tidyverse)
library(survival)
library(ggsurvfit)


# km ---------------------------------------------------------------------------
km_fit <- survfit2(Surv(time, status) ~ Interv_num, data = m.data) 
survfit2(Surv(time, status) ~ Interv_num, data = m.data) # median
str(km_fit) # info
survdiff(Surv(time, status) ~ Interv_num, data = m.data) # logrank


# plot -------------------------------------------------------------------------
km_fit %>%
  
  ggsurvfit() +
  
  labs(
    x = "",
    y = "Survival Probability"
  ) +
  
  scale_x_continuous(
    limits = c(0, 1825),
    breaks = c(0, 30, 180, 730, 1825),
    labels = c("", "1 Month", "6 Months", "2 Years", "5 Years")
  ) +
  
  scale_y_continuous(
    limits = c(0.49, 1),
    breaks = seq(0.5, 1, 0.1),
    labels = scales::percent
  ) +
  
  scale_color_discrete(
    name = "",
    labels = c("SAVR + CABG", "TAVR")
  ) +
  
  theme(
    panel.grid = element_blank(),
    axis.text.x = element_text(angle = 30, hjust = 1),
    legend.position = "right"
  ) +
  
  add_confidence_interval(
    alpha = 0.075
  ) +
  
  add_censor_mark(size = 0.5) + 
  
  guides(fill = "none") +
  
  annotate(
    "text", 
    x = 105, y = 0.90, 
    label = "HR=0.4", 
    size = 3, 
    color = "black"
  ) +

  annotate(
    "text", 
    x = 1277.5, y = 0.65, 
    label = "HR=1.7", 
    size = 3, 
    color = "black"
  ) +
  
  geom_vline(
    xintercept = c(0, 30, 180, 730, 1825),
    linetype = "dotted",
    linewidth = 0.1,
    alpha = 0.75
  )


# write ------------------------------------------------------------------------
ggsave(
  "out/km.png",
  width = 8,
  height = 4
)
