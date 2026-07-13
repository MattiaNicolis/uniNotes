

rm(list = ls())


data(mtcars)
library(dplyr)
length(unique(mtcars$am))
ncol(mtcars)



mtcarsfiltrato = filter(mtcars, cyl >=6 & hp> 110 & wt < 3.5) 



View(mtcarsfiltrato)

#conti per mpg

mean(mtcarsfiltrato$mpg)
median(mtcarsfiltrato$mpg)
var(mtcarsfiltrato$mpg)
quantile(mtcarsfiltrato$mpg)



library(ggplot2) 
ggplot(mtcars, aes(  x = factor(cyl),  y = mpg,  fill = factor(cyl) )) + geom_boxplot() +  facet_wrap(~ factor( am, labels = c("Automatic", "Manual"))) +  theme_minimal() +  theme(legend.position = "bottom") +  labs(    x = "Number of cylinders",    y = "Miles per gallon",    fill = "Cylinders",    title = "Fuel efficiency by cylinders and transmission type" )



mpg_am1 <- c(21.0, 21.0, 22.8, 32.4, 30.4, 33.9, 27.3, 26.0, 30.4, 15.8, 19.7, 15.0, 21.4)





#t.test(mpg_am1, conf.level = 0.99)$conf.int

media = mean(mpg_am1)
n = length(mpg_am1)
s = sd(mpg_am1)

# Valore critico t per un livello di confidenza del 99% (alfa = 0.01)
# Si inserisce 0.995 perché l'intervallo è a due code: 1 - (0.01 / 2)
t_critico <- qt(0.995, df = n - 1)
margine_errore <- t_critico * (s / sqrt(n))

limite_inferiore <- media - margine_errore
limite_superiore <- media + margine_errore

limite_inferiore
limite_superiore



media + c(-1, 1) * qt(1-0.01 / 2, df = n-1) * s / sqrt(n)


cors <- cor(mtcars) 
cors



model <- lm(mpg ~ wt, data = mtcars) 
summary(model)



library(ggplot2)
ggplot(ToothGrowth, aes(x = supp, y = len)) +
    geom_boxplot(aes(color = as.factor(dose)))


doses <- c(0.5, 1, 2)
supps <- c("VC", "OJ")

par(mfrow = c(2,3))
for(dos in doses){
    for(sup in supps){
        group <- ToothGrowth[ToothGrowth$dose == dos & ToothGrowth$supp == sup, "len"] 
        qqnorm(group, 
               main = paste0("Supp: ", sup, " - Dose: ", dos))
        qqline(group, col = "red")
    }
}


View(ToothGrowth)
nrow(ToothGrowth)
ncol(ToothGrowth)




var(x) = e(x^2) - e(x)^2
30 - 5

p1 = 0 * 0.2
p2 = 1 * 0.5
p3 = 2 * 0.3

ptot = p1 + p2 + p3


pa = 0.60
pb = 0.40

pda = 0.05
pdb = 0.03

ptotale = pa*pda + pb*pdb 
ptotale

pa = 0.70
pab = 0.5

pba = pab / pa
pba

a = 0.7*0.4
a
3/4
10*0.6
