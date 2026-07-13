month <- "march"
month

nchar(month)
paste0(month, month)

months= c(month, "january", "febrauary")


l1 <- list("Everest", "Nepal", 8848, TRUE)
l2 <- list(81, 82, 90, 56)
l1[1]

#il parametro dim rappresenta la dimensione, ovvero una matrice 2 x 3, prodotto 2 volte
a1 <- array(c(1:12), dim = c(2,3,2))

df1<-data.frame(mount=c("Everest","K2","Fuji"), height=c(8848,8611,3776), todo=c(TRUE,TRUE,FALSE))
df1

f1<-marital_status<-factor(c("married","single","single", 
"divorced","married"))
f1[1] <- "hey"

levels(f1)





x <- c(1, 2, 3, 4, 5)
y <- c(2, 4, 6, 8, 10)
# Crea un scatterplot 
plot(x, y, xlab = "valori di x", ylab = "valori di y", main = "plot di x e y", col= "blue")



#funzione

my_sum <- function(x, y) { 
z <- x + y
return(z)
}

my_sum(3,4)

install.packages("dplyr")
library(dplyr) 
data(iris)
View(iris)

pianta_filtrata = filter(iris, Species == 'setosa')




#A. Carica il dataset sunspot.year dal pacchetto datasets. Usa  data("sunspot.year") e poi sunspot.year per caricarlo nello workspace.

data("sunspot.year")
sunspot.year
View(sunspot.year)
year = 1700:1988
year



#C. Crea una variabile chiamata sunspot, contenente i valori del dataset

sunspot = as.numeric(sunspot.year)
sunspot

# Unisci le variabili in un oggetto data.frame

sunspot_df = data.frame(year = year, sunspot = sunspot)

head(sunspot_df)


#E. Crea un grafico a linee (line plot) dei sunspot in funzione degli anni.

plot(sunspot_df, type = "l")
points(sunspot_df, pch = "*", col = "red")
title("Sunspots by Year")


barplot(as.vector(sunspot), main = "Barplot of Sunspots", col = "steelblue")

hist(sunspot, main = "Histogram of Sunspots", xlab = "Sunspots", col = "lightgreen")

par(mfrow = c(2, 2))





prima= c(190, 202, 195, 185, 208, 200, 192, 204, 212, 188)
dopo = c(182, 206, 183, 183, 209, 191, 192,199,209,181)

differenza = prima - dopo
mediaDifferenza = mean(differenza)

primaVarianzaQuadrato = var(differenza)
primaVarianza = sqrt(primaVarianzaQuadrato)


ore_formazione = seq(from = 3, to = 13, by = 2)
punteggio = c(52, 60, 63, 71, 73, 81)

mediaOre = mean(ore_formazione)
mediaPunti = mean(punteggio)

xxmedio = ore_formazione - mediaOre
yymedio = punteggio - mediaPunti
xx = xxmedio^2
yy = yymedio^2
xy = xxmedio*yymedio

xxsomma = sum(xx)
yysomma = sum(yy)
xysomma = sum(xy)

b1 = xysomma / xxsomma
b0 = mediaPunti - b1*mediaOre

r = (xysomma)^2 / (xxsomma * yysomma)


# 1. Creiamo il modello
mio_modello <- lm(mpg ~ wt, data = mtcars)

# 2. Chiediamo il riassunto statistico
summary(mio_modello)




ore <- c(3, 5, 7, 9, 11, 13)
punteggio <- c(52, 60, 63, 71, 73, 81)


modello_esercizio <- lm(punteggio ~ ore)
summary(modello_esercizio)

?lm




var = e(x^2) - e(x)^2
var = 30 - 5^2

0*0.2 + 1*0.5 + 2*0.3
0.6*0.05 + 0.4*0.03
0.5 / 0.7
3/4
10*0.6



prima = c(42, 47, 37, 9, 33, 70, 54, 27, 41, 18)
dopo = c(22, 29, 9, 9, 26, 36, 38, 32, 33, 14)

differenza = prima - dopo
mediaDifferenza = mean(differenza)

XmenoXmedio = differenza - mediaDifferenza
XmenoXmedioQuadrato = XmenoXmedio^2

totale = sum(XmenoXmedioQuadrato)
varianzaCalcolata = totale / 9



n = 10
mediaDifferenza = mean(differenza)
varianza = var(differenza)
varianzaRadice = sqrt(varianza)
radice = sqrt(n)

denominatore = varianzaRadice / radice

calcolo = (mediaDifferenza - 0) / denominatore



#CALCOLO QUELLI PER IL BEFORE

prima
mediaPrima = mean(prima)
primaMenoMedia = prima - mediaPrima


var(prima)
radice = sqrt(var(prima))


totalePos = mediaPrima + (2.262 *radice/sqrt(10))
totaleNeg = mediaPrima - (2.262 *radice /sqrt(10))




ore = c(5,7,9,11,12,15)
voto = c(15,17,18,24,24,30)

votoLavorato = voto - mean(voto)
oreLavorato = ore - mean(ore)

xy = oreLavorato * votoLavorato
xx = oreLavorato^2
yy = votoLavorato^2
b_1 = sum(xy) /sum(xx)

valore = lm(voto ~ ore)

mean(voto) - b_1* mean(ore)


summary(valore)

quantile(voto)
