options(warn = -1)
options(scipen = 10000)

# Análisis de Correspondencia para Datos de Ocupación Laboral en la Industria TI

library(tidyverse)
library(scales)
library(RColorBrewer)
library(ggthemes)
library(ca)
library(devtools)
library(factoextra)
library(viridis)
library(ggrepel)
library(ggalluvial)
annotate <- ggplot2::annotate


data <- read.csv("kaggle_survey_2020_responses.csv")
data <- data[complete.cases(data$Q4),]
data <- data[2:nrow(data),]
data <- data[data$Q4!=" ",]
data <- data[data$Q4!="I prefer not to answer",]

data <- data %>%
  mutate(Edu = case_when(Q4 == "Bachelor’s degree" ~ "Bachelor",
                         Q4 == "Master’s degree" ~ "Master",
                         Q4 %in% c("Doctoral degree","Professional degree") ~ "Higher than Master",
                         Q4 %in% c("Some college/university study without earning a bachelor’s degree","No formal education past high school") ~ "Lower than Bachelor"))

data <- data %>%
  mutate(Continent = case_when(Q3 %in% c("Austria", "Belgium", "Bulgaria", "Croatia", "Czech Republic",
                                         "Denmark", "Estonia", "Finland", "France", "Germany", "Greece",
                                         "Hungary", "Ireland", "Italy", "Lativia", "Lithuania", 
                                         "Netherlands", "Poland", "Portugal", "Romania", "Slovakia",
                                         "United Kingdom of Great Britain and Northern Ireland",
                                         "Slovenia","Spain", "Sweden", "Russia", "Switzerland",
                                         "Ukraine", "Belarus", "Norway") ~ "Europe",
                               Q3 %in% c("Canada", "United States of America", "Mexico") ~ "North America",
                               Q3 %in% c("India", "China", "Japan", "Turkey", "South Korea", "Isreal", "Indonesia", "Hong Kong (S.A.R.) ",
                                         "Singapore", "Viet Nam", "Pakistan", "Malaysia", "Bangladesh", "Philippines", "Sri Lanka", 
                                         "Thailand", "Republic of Korea", "Saudi Arabia", "Taiwan", "Nepal", "United Arab Emirates") ~ "Asia",
                               Q3 %in% c("Argentina", "Brazil", "Chile", "Colombia", "Peru", "Venezuela") ~ "South America",
                               Q3 %in% c("Egypt", "Nigeria", "Kenya", "South Africa", "Morocco", "Algeria", "Ghana", "Tunisia") ~ "Africa",
                               Q3 %in% c("Australia", "New Zealand") ~ "Australia"))

data <- data %>%
  mutate(Q1a = case_when(Q1 == "18-21" ~ "18-21",
                         Q1 == "22-24" ~ "22-24",
                         Q1 == "25-29" ~ "25-29",
                         Q1  %in% c("30-34", "35-39") ~ "30-39",
                         Q1 %in% c("40-44", "45-49", "50-54","55-59", "60-69", "70+") ~ "40+"))

data <- data %>%
  mutate(Q1b = case_when(Q1 == "18-21" ~ "18-21",
                         Q1 == "22-24" ~ "22-24",
                         Q1 == "25-29" ~ "25-29",
                         Q1 == "30-34" ~ "30-34",
                         Q1 == "35-39" ~ "35-39",                      
                         Q1  %in% c("40-44", "45-49") ~ "40-49",
                         Q1 %in% c("50-54","55-59", "60-69", "70+") ~ "50+"))

data <- data %>%
  mutate(Continent2 = case_when(Continent == "Asia" ~ "Asia",
                                Continent %in% c("Europe", "North America") ~ "Europe + North America",
                                Continent %in% c("Australia", "South America", "Africa") ~ "Rest of the world"))


# Análisis Exploratorio

education_df <- as.data.frame(table(data$Edu))
paises_df <- as.data.frame(table(data$Q3))
edades_df <- as.data.frame(table(data$Q1a))
continentes_df <- as.data.frame(table(data$Continent))

# Nivel de Educación por Continente
options(repr.plot.width=11, repr.plot.height=7)
data %>%
  filter(Continent!="") %>%
  filter(Continent!="0") %>%
  filter(Q4!="0") %>%
  filter(Q4!="") %>%
  filter(Q2 %in% c("Woman", "Man")) %>%
  ggplot(., aes(Q4, Continent, col = Q4))+
  geom_count()+
  scale_size_area(max_size = 25)+
  geom_point(stroke = 1)+
  labs(title = "Nivel de Eduación", y = "Continente", 
       x = NULL, color = "Education level")+
  guides(color = guide_legend(title.position = "top", order = 1), size = guide_legend(title.position = "top")) +
  facet_wrap(~ Q2, ncol = 1)

# Puesto de Trabajo por Continente
options(repr.plot.width=11, repr.plot.height=7)
data %>%
  filter(Continent != "") %>%
  filter(Continent != "0") %>%
  filter(Q4 != "0") %>%
  filter(Q4 != "") %>%
  filter(Q2 %in% c("Woman", "Man")) %>%
  filter(Q5 != "") %>%   # Filtra valores de Q5 que no sean vacíos
  ggplot(., aes(Q5, Continent, col = Q5)) +
  geom_count() +
  scale_size_area(max_size = 25) +
  geom_point(stroke = 1) +
  labs(title = "Puestos de Trabajo por Continente y Género", y = "Continente", 
       x = NULL, color = "Puesto de Trabajo") +
  guides(color = guide_legend(title.position = "top", order = 1), size = guide_legend(title.position = "top")) +
  facet_wrap(~ Q2, ncol = 1) +
  theme(axis.text.x = element_blank())

# Histograma de los puestos de trabajo en la encuesta
trabajos_df <- as.data.frame(table(data$Q5))
trabajos_df <- slice(trabajos_df, -1)
trabajos_df <- slice(trabajos_df, -13)

options(repr.plot.width=11, repr.plot.height=7)
ggplot(trabajos_df, aes(reorder(Var1, +Freq), Freq))+
  geom_bar(col = "gray10", stat = "identity", width = 0.75, fill = "cyan3")+
  coord_flip()+
  scale_x_discrete(limits = c("Business Analyst","Currently not employed", "Data Analyst", "Data Engineer", "Data Scientist", "DBA/Database Engineer", "Machine Learning Engineer", 
                              "Other", "Product/Project Manager", "Research Scientist", "Software Engineer", "Statistician"))+
  labs(title = "Puestos de Trabajo considerados en la encuesta", y = "Número", 
       x = "Puesto de Trabajo")


# Análisis de Correspondencia

# Correspondencia entre Nivel de Educación y Puestos de Trabajo

Edu_Q5_df <- as.data.frame.matrix(table(data$Edu, data$Q5))
Edu_Q5_df <- Edu_Q5_df[, -1]

ac <- ca(Edu_Q5_df, nd=2)
contribuciones <- ac$sv^2 / sum(ac$sv^2)
contribuciones
col_scores <- ac$colcoord
ss_scores <- colSums(col_scores^2)
variable_contributions <- t(t(col_scores^2) / ss_scores)
variable_contributions
cr <- ac$rowcoord
cc <- ac$colcoord
cr_df <- data.frame(x = cr[, 1], y = cr[, 2], label = rownames(Edu_Q5_df))
cc_df <- data.frame(x = cc[, 1], y = cc[, 2], label = colnames(Edu_Q5_df))



p <- ggplot(cr_df, aes(x = x, y = y, label = label)) +
  geom_point(color = "blue3", size = 3) +
  geom_text(color = "blue3", size = 3, nudge_x = 0.1, nudge_y = 0.1) +  # Ajusta la posición de los textos
  xlim(range(cr[, 1]-0.1, cc[, 1])+0.1) +
  ylim(range(cr[, 2]-0.8, cc[, 2])+0.1) +
  xlab("Coordenada 1") +
  ylab("Coordenada 2") +
  geom_hline(yintercept = 0, linetype = "dashed") +
  geom_vline(xintercept = 0, linetype = "dashed") +
  ggtitle("Análisis de Correspondencia entre  Nivel de Estudios y Puesto de Trabajo")

p <- p +
  geom_point(data = cc_df, aes(x = x, y = y), color = "darkorange2", size = 3) +
  geom_text(data = cc_df, aes(x = x, y = y, label = label), color = "black", size = 3, nudge_x = 0.05, nudge_y = 0.1)  # Ajusta la posición de los textos
print(p)



# Correspondencia entre Lenguajes de Programacion y Puestos de Trabajo

newnames_Q7 <- c("Python", "R", "SQL", "C", "C++", "Java", "Javascript", "Julia","Swift", "Bash", 
                 "MATLAB", "None")

oldnames_Q7 <- c("Q7_Part_1", "Q7_Part_2", "Q7_Part_3", "Q7_Part_4", "Q7_Part_5", "Q7_Part_6", 
                 "Q7_Part_6", "Q7_Part_7", "Q7_Part_8", "Q7_Part_9", "Q7_Part_10", "Q7_Part_11", "Q7_Part_12")

Q5_Q7_df <- data %>%
  rename_at(all_of(oldnames_Q7), ~ newnames_Q7) %>%
  select(Q5, Python, R, SQL, C, `C++`, Java, Javascript, Julia, Swift, Bash, MATLAB, None) %>%
  mutate(Python = na_if(Python,"")) %>%
  mutate(R = na_if(R,"")) %>%
  mutate(SQL = na_if(SQL,"")) %>%
  mutate(C = na_if(C,"")) %>%
  mutate(`C++` = na_if(`C++`,"")) %>%
  mutate(Java = na_if(Java,"")) %>%
  mutate(Javascript = na_if(Javascript,"")) %>%
  mutate(Julia = na_if(Julia,"")) %>%
  mutate(Swift = na_if(Swift,"")) %>%
  mutate(Bash = na_if(Bash,"")) %>%
  mutate(MATLAB = na_if(MATLAB,"")) %>%
  mutate(None = na_if(None,"")) %>%
  group_by(Q5) %>%
  summarise(Python = length(which(!is.na(Python))), R = length(which(!is.na(R))), 
            SQL = length(which(!is.na(SQL))), C = length(which(!is.na(C))),
            `C++` = length(which(!is.na(`C++`))), Java = length(which(!is.na(Java))),
            Javascript = length(which(!is.na(Javascript))), Julia = length(which(!is.na(Julia))), 
            Swift = length(which(!is.na(Swift))), Bash = length(which(!is.na(Bash))), 
            MATLAB = length(which(!is.na(MATLAB))), None = length(which(!is.na(None))), .groups = 'drop')

# Acomodo la tabla
Q5_Q7_df <- slice(Q5_Q7_df, -1)
names <- Q5_Q7_df$Q5
Q5_Q7_df <- Q5_Q7_df[, -1]
rownames(Q5_Q7_df) <- names
Q5_Q7_df <- t(Q5_Q7_df)
ac <- ca(Q5_Q7_df, nd=2)
contribuciones <- ac$sv^2 / sum(ac$sv^2)
contribuciones
col_scores <- ac$colcoord
ss_scores <- colSums(col_scores^2)
variable_contributions <- t(t(col_scores^2) / ss_scores)
variable_contributions
cr <- ac$rowcoord
cc <- ac$colcoord
cr_df <- data.frame(x = cr[, 1], y = cr[, 2], label = rownames(Q5_Q7_df))
cc_df <- data.frame(x = cc[, 1], y = cc[, 2], label = colnames(Q5_Q7_df))

p <- ggplot(cr_df, aes(x = x, y = y, label = label)) +
  geom_point(color = "blue3", size = 3) +
  geom_text(color = "blue", size = 3, nudge_x = 0.08, nudge_y = 0.08) +
  xlim(range(cr[, 1]+0.3, cc[, 1])+0.1) +
  ylim(range(cr[, 2], cc[, 2]+0.3)) +
  xlab("Coordenada 1") +
  ylab("Coordenada 2") +
  geom_hline(yintercept = 0, linetype = "dashed") +
  geom_vline(xintercept = 0, linetype = "dashed") +
  ggtitle("Análisis de Correspondencia entre  Lenguaje de Programación y Puesto de Trabajo")

p <- p +
  geom_point(data = cc_df, aes(x = x, y = y), color = "darkorange2", size = 3) +
  geom_text(data = cc_df, aes(x = x, y = y, label = label), color = "black", size = 3, nudge_x = 0.05, nudge_y = 0.05)
print(p)


#  Correspondencia entre Salario y Puesto de Trabajo

Q5_Q24_df <- as.data.frame.matrix(table(data$Q24, data$Q5))
Q5_Q24_df <- Q5_Q24_df[, -1]
Q5_Q24_df <- slice(Q5_Q24_df, -1)
Q5_Q24_df <- Q5_Q24_df[, -2]
Q5_Q24_df <- Q5_Q24_df[, -12]
ac <- ca(Q5_Q24_df, nd=2)
contribuciones <- ac$sv^2 / sum(ac$sv^2)
contribuciones
col_scores <- ac$colcoord
ss_scores <- colSums(col_scores^2)
variable_contributions <- t(t(col_scores^2) / ss_scores)
variable_contributions
cr <- ac$rowcoord
cc <- ac$colcoord
cr_df <- data.frame(x = cr[, 1], y = cr[, 2], label = rownames(Q5_Q24_df))
cc_df <- data.frame(x = cc[, 1], y = cc[, 2], label = colnames(Q5_Q24_df))

p <- ggplot(cr_df, aes(x = x, y = y, label = label)) +
  geom_point(color = "blue3", size = 3) +
  geom_text(color = "blue3", size = 3, nudge_x = 0.2, nudge_y = 0.1) +
  xlim(range(cr[, 1], cc[, 1])+0.25) +
  ylim(range(cr[, 2], cc[, 2]+0.1)) +
  xlab("Coordenada 1") +
  ylab("Coordenada 2") +
  geom_hline(yintercept = 0, linetype = "dashed") +
  geom_vline(xintercept = 0, linetype = "dashed") +
  ggtitle("Análisis de Correspondencia entre  Salario y Puesto de Trabajo")

p <- p +
  geom_point(data = cc_df, aes(x = x, y = y), color = "darkorange2", size = 3) +
  geom_text(data = cc_df, aes(x = x, y = y, label = label), color = "black", size = 3, nudge_x = 0.05, nudge_y = 0.1)
print(p)


# Correspondencia entre Algoritmos de Machine Learning y Puesto de Trabajo

newnames_Q17 <- c("Linear or Logisitc Regression", "Decision Trees/Random Forests", "Gradient Boosting Machines", 
                  "Bayesian Approaches", "DNN", "CNN", "RNN","Transformer Networks","None")

oldnames_Q17 <- c("Q17_Part_1", "Q17_Part_2", "Q17_Part_3", "Q17_Part_4", "Q17_Part_6","Q17_Part_7", 
                  "Q17_Part_9","Q17_Part_10", "Q17_Part_11")

Q17_df <- data %>%
  rename_at(all_of(oldnames_Q17), ~ newnames_Q17) %>%
  select(Q5, `Linear or Logisitc Regression`, `Decision Trees/Random Forests`, `Gradient Boosting Machines`, 
         `Bayesian Approaches`, DNN, CNN, RNN, `Transformer Networks`, None) %>%
  mutate(`Linear or Logisitc Regression` = na_if(`Linear or Logisitc Regression`,"")) %>%
  mutate(`Decision Trees/Random Forests` = na_if(`Decision Trees/Random Forests`,"")) %>%
  mutate(`Gradient Boosting Machines` = na_if(`Gradient Boosting Machines`,"")) %>%
  mutate(`Bayesian Approaches` = na_if(`Bayesian Approaches`,"")) %>%
  mutate(DNN = na_if(DNN,"")) %>%
  mutate(CNN = na_if(CNN,"")) %>%
  mutate(RNN = na_if(RNN,"")) %>%
  mutate(`Transformer Networks` = na_if(`Transformer Networks`,"")) %>%
  mutate(None = na_if(None,"")) %>%
  group_by(Q5) %>%
  summarise(`Linear or Logisitc Regression` = length(which(!is.na(`Linear or Logisitc Regression`))), 
            `Decision Trees/Random Forests` = length(which(!is.na(`Decision Trees/Random Forests`))), 
            `Gradient Boosting Machines` = length(which(!is.na(`Gradient Boosting Machines`))),
            `Bayesian Approaches` = length(which(!is.na(`Bayesian Approaches`))),
            DNN = length(which(!is.na(DNN))),
            CNN = length(which(!is.na(CNN))),
            RNN = length(which(!is.na(RNN))),
            `Transformer Networks` = length(which(!is.na(`Transformer Networks`))),
            None = length(which(!is.na(None))), .groups = 'drop')

Q17_df <- slice(Q17_df, -1)
names <- Q17_df$Q5
Q17_df <- Q17_df[, -1]
Q17_df <- Q17_df[, -9]
rownames(Q17_df) <- names
Q17_df <-t(Q17_df)

ac <- ca(Q17_df, nd=2)
contribuciones <- ac$sv^2 / sum(ac$sv^2)
contribuciones
col_scores <- ac$colcoord
ss_scores <- colSums(col_scores^2)
variable_contributions <- t(t(col_scores^2) / ss_scores)
variable_contributions
cr <- ac$rowcoord
cc <- ac$colcoord
cr_df <- data.frame(x = cr[, 1], y = cr[, 2], label = rownames(Q17_df))
cc_df <- data.frame(x = cc[, 1], y = cc[, 2], label = colnames(Q17_df))

p <- ggplot(cr_df, aes(x = x, y = y, label = label)) +
  geom_point(color = "blue3", size = 3) +
  geom_text(color = "blue3", size = 3, nudge_x = 0.05, nudge_y = 0.1) +
  xlim(range(cr[, 1], cc[, 1]+0.2)) +
  ylim(range(cr[, 2], cc[, 2]+0.1)) +
  xlab("Coordenada 1") +
  ylab("Coordenada 2") +
  geom_hline(yintercept = 0, linetype = "dashed") +
  geom_vline(xintercept = 0, linetype = "dashed") +
  ggtitle("Análisis de Correspondencia entre  Algoritmos de ML y Puesto de Trabajo")

p <- p +
  geom_point(data = cc_df, aes(x = x, y = y), color = "darkorange2", size = 3) +
  geom_text(data = cc_df, aes(x = x, y = y, label = label), color = "black", size = 3, nudge_x = 0.05, nudge_y = 0.1)
print(p)







