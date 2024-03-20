library(pastecs)
library(glmmTMB); 
library(performance)

data <- read.csv("filtered_data.csv")
#creating is_popular field
data$is_outlier = data$shares>30000

model = glm(is_outlier ~ kw_min_avg + kw_avg_avg + kw_max_avg, data = data, family = binomial)
check_collinearity(model)

data$is_popular = data$is_outlier
summary(model)
data
stat.desc(data$kw_avg_avg)

data$kw_best_avg = data$kw_avg_max
data$kw_worst_avg = data$kw_avg_min
data$kw_avg_avg = data$kw_avg_avg
stat.desc(data$kw_avg_max)
stat.desc(data$kw_avg_min)
stat.desc(data$kw_avg_avg)
stat.desc(data$num_keywords)
min(data$num_keywords)
max(data$num_keywords)
mean(data$num_keywords)
sd(data$num_keywords)
summary(data[c("kw_best_avg", "kw_worst_avg", "kw_avg_avg")])
data[data$is_popular == 1,]

# Setting up the layout
par( mfcol= c(2,2)) 
# Load required libraries
library(ggplot2)
library(dplyr)

# Assuming your data frame is named 'data' and contains columns:
# kw_avg_avg, kw_avg_max, kw_avg_min, num_keywords, is_popular

# Create a new data frame to store mean values for each group
mean_data <- data %>%
  group_by(is_popular) %>%
  summarise(mean_kw_avg_avg = mean(kw_avg_avg),
            mean_kw_avg_max = mean(kw_avg_max),
            mean_kw_avg_min = mean(kw_avg_min),
            mean_num_keywords = mean(num_keywords))

# Function to remove outliers from a vector
remove_outliers <- function(x) {
  qnt <- quantile(x, probs=c(.25, .75), na.rm = TRUE)
  H <- 1.5 * IQR(x, na.rm = TRUE)
  x[x < (qnt[1] - H)] <- NA
  x[x > (qnt[2] + H)] <- NA
  return(x)
}

# Remove outliers from the data
data_cleaned <- data %>%
  mutate(across(c(kw_avg_avg, kw_avg_max, kw_avg_min, num_keywords), remove_outliers))

# Plot boxplots
boxplot_kwa <- ggplot(data_cleaned, aes(x = factor(is_popular), y = kw_avg_avg)) +
  geom_boxplot() +
  geom_point(data = mean_data, aes(x = factor(is_popular), y = mean_kw_avg_avg), color = "red", size = 3) +
  labs(x = "is_popular", y = "kw_avg_avg") 

boxplot_kwm <- ggplot(data_cleaned, aes(x = factor(is_popular), y = kw_avg_max)) +
  geom_boxplot() +
  geom_point(data = mean_data, aes(x = factor(is_popular), y = mean_kw_avg_max), color = "red", size = 3) +
  labs(x = "is_popular", y = "kw_best_avg") 

boxplot_kwn <- ggplot(data_cleaned, aes(x = factor(is_popular), y = kw_avg_min)) +
  geom_boxplot() +
  geom_point(data = mean_data, aes(x = factor(is_popular), y = mean_kw_avg_min), color = "red", size = 3) +
  labs(x = "is_popular", y = "kw_worst_avg") 

boxplot_num_keywords <- ggplot(data_cleaned, aes(x = factor(is_popular), y = num_keywords)) +
  geom_boxplot() +
  geom_point(data = mean_data, aes(x = factor(is_popular), y = mean_num_keywords), color = "red", size = 3) +
  labs(x = "is_popular", y = "num_keywords") 

require(gridExtra)
plot1 <- qplot(1)
plot2 <- qplot(1)
grid.arrange(boxplot_kwa, boxplot_kwm, boxplot_kwn, boxplot_num_keywords,ncol=2)

#model 1 and model 2 logistic regression
model = glm(is_popular ~ kw_avg_avg + kw_best_avg + kw_worst_avg + num_keywords, data = data, family = binomial)
model_interact = glm(is_popular ~ kw_worst_avg*kw_best_avg*kw_avg_avg + num_keywords, data = data, family = binomial)

summary(model)
summary(model_interact)
exp(confint.default(model))
exp(model$coefficients) 
cat("AIC of interaction Model:",AIC(model_interact),"\n")
cat("AIC of non-interaction Model:",AIC(model),"\n")
cat("BIC of interaction Model:",BIC(model_interact),"\n")
cat("BIC of non-interaction Model:",BIC(model),"\n")
cat("Residual deviance of interaction model: ",model_interact$deviance,"\n")
cat("Residual deviance of non-interaction model: ",model$deviance,"\n")
cat("Confidence intervals for log odds of interaction model is:","\n")
exp(confint.default(model_interact))
cat("Confidence intervals for log odds of interaction model is:","\n")
exp(confint.default(model))

#LRT test
full_model <- glm(data$is_popular ~ data$num_keyword + data$kw_avg_avg*data$kw_best_avg*data$kw_worst_avg, data = data, family = 'binomial')
reduced_model <- glm(data$is_popular ~ data$num_keyword + data$kw_avg_avg + data$kw_best_avg + data$kw_worst_avg, data = data, family = 'binomial')
anova_res <- anova(reduced_model, full_model, test='LRT')
print(anova_res)