#ESERCIZIO 1
#In una scatola ci sono 5 palline rosse e 3 palline blu. Qual è la probabilità di estrarre una pallina rossa?''
p_a = 5/8
p_b = 3/8

#ESERCIZIO 2
#Si lancia un dado equilibrato a 8 facce numerate da 1 a 8. Qual è la probabilità che esca un numero divisibile per 4?

#Numeri divisivili per 4 = 4,8
p_a = 2/8


#ESERCIZIO 3
#Se X è una variabile aleatoria di Bernoulli con P(X=1)=0.3, quanto vale E(X?
1*0.3


#ESERICIZIO 4
#Se X ∼ B(20, 0.1), quanto vale Var(X)?
20*0.1*(1-0.1)


#ESERCIZIO 5
#Uno studio intende verificare se un nuovo programma alimentare sia in grado di ridurre in modo significativo il livello di colesterolo LDL (misurato in mg/dL). Si estrae un campione casuale semplice di 10 soggetti a cui viene misurato il valore dell’indicatore prima e dopo l’intervento. I valori prima e dopo sono riportati nella tabella seguente:

prima = c(190, 202, 195, 185, 208, 200, 192, 204, 212, 188)
dopo = c(182, 206, 183, 183, 209, 191, 192, 199, 209, 181)

differenza = prima - dopo
var(differenza)
varianzaNoquadrato = sqrt(var(differenza))

media = mean(differenza)

denominatore = (varianzaNoquadrato) / sqrt(10)

t = (media - 0) / denominatore
2.593644 >  1.833 #per t_n-1 = 9

#p value stima
0.025

#IC
piccolo = media - (2.262 * varianzaNoquadrato / sqrt(10))
grande = media + (2.262 * varianzaNoquadrato / sqrt(10))


#ESERCIZIO 6
#Un’azienda riceve l’80% dei pezzi dal fornitore e il 20% dal fornitore . Il 2% dei pezzi di e il 5% dei pezzi di sono difettosi. Se un pezzo è difettoso, qual è la probabilità che provenga da ?
a = 8/10 * 2/100
b = 20/100 * 5 /100
den = a+b
num = 5/100 * 20/100
ris = num / den


#ESERCIZIO 7
#In una scuola, il 40% degli studenti pratica sport e il 30% suona uno strumento musicale. Il 12% degli studenti pratica sport E suona uno strumento musicale. Gli eventi sono:
p_A = 40/100
p_B = 30/100
pAintersecatoB = 12/100

#per essere indipendenti pAintersecatoB = p_A*p_B
check = p_A*p_B


#ESERCIZIO 8
#Due eventi A e B sono indipendenti. Se P(A) = 0.25 e P(B) = 0.8, quanto vale P(A ∩ B)?
0.8*0.25


#ESERCIZIO 9
#Due eventi A e B sono tali che P(A) = 0.4 P(B|A) = 0.7. Quanto vale P(A ∩ B)?
0.4*0.7


#ESERCIZIO 10
#Una fabbrica ha due macchine, e . La macchina produce il 60% degli articoli e la macchina il 40%. Il 5% degli articoli di sono difettosi, il 3% di sono difettosi. Qual è la probabilità che un articolo scelto a caso sia difettoso?
a1 = 6/10 * 5/100
b1 = 4/10 * 3/100
ris = a1 + b1


#ESERCIZIO 11
#Si lancia un dado a 6 facce. Sia l’evento “esce un multiplo di 3” e l’evento “esce un numero pari”. Qual è P(A|B)?
p_A = 2/6
p_B = 3/6
risultato = p_A * p_B / p_B


#ESERCIZIO 12
#Un ricercatore vuole studiare la relazione tra il numero di ore di formazione sulla sicurezza e il punteggio ottenuto in un test finale per un piccolo campione di lavoratori. I dati raccolti sono i seguenti:
ore_formazione = c(3,5,7,9,11,13)
punteggio = c(52,60,63,71,73,81)

modello = lm(punteggio ~ ore_formazione)
summary(modello)


#ESERCIZIO 13
#Una variabile aleatoria discreta può assumere i valori 0, 1, 2 con le seguenti probabilità: P(X = 0) = 0.2, P(X = 1) = 0.5, P(X = 2) = 0.3. Calcola il valore atteso E(X).
0.2*0 + 1*0.5 + 2*0.3


#ESERCIZIO 14
#Una variabile aleatoria assume i valori -2, 1, 3 con probabilità 0.25, 0.50, 0.25. Quanto vale E(Y )?
-2*0.25 + 1*0.5 + 3*0.25


#ESERCIZIO 15
data(mtcars)
View(mtcars)

#Qual è il numero di valori distinti assunti dalla variabile am?
unique(mtcars$am)
nrow(mtcars)
ncol(mtcars)


#Considera solo le automobili con numero di cilindri maggiore o uguale a 6, potenza del motore maggiore di 110 e peso del veicolo inferiore a 3.5. Per questo sottoinsieme, calcola i seguenti valori per il consumo di carburante (mpg). Scrivi tutte le risposte arrotondate a 2 cifre decimali.

mtcars_filtrato = filter(mtcars, cyl>=6, hp>110, wt<3.5)
View(mtcars_filtrato)

mean(mtcars_filtrato$mpg)
median(mtcars_filtrato$mpg)
var(mtcars_filtrato$mpg)
quantile(mtcars_filtrato$mpg)


#ESERCIZIO 17
#Completa il codice per ottenere il grafico in 1.
library(ggplot2)
ggplot(mtcars, aes(
x = factor(cyl),
y = mpg,
fill = factor(cyl)
)) +
geom_boxplot () +
facet_wrap(~ factor( am, labels = c("Automatic", "Manual"))) +
theme_minimal() +
theme(legend.position = 'bottom') +
labs(
x = "Number of cylinders",
y = "Miles per gallon",
fill = "Cylinders",
title = "Fuel efficiency by cylinders and transmission type"
)

#ESERCIZIO 18
#Cosa si può osservare dal grafico?
#La distribuzione dei consumi (mpg) in base al numero di cilindri, separata per tipo di trasmissione (automatica/manuale).


#ESERCIZIO 19
#Si consideri il vettore mpg_am1, che contiene i valori di consumo di carburante (mpg) per le auto con trasmissione manuale (am = 1) nel dataset mtcars.
mpg_am1 <- c(21.0, 21.0, 22.8, 32.4, 30.4, 33.9, 27.3, 26.0, 30.4, 15.8, 19.7, 15.0, 21.4)

mean(mpg_am1) + c(-1, 1)*qt(1-0.01/2, df =12) * sqrt(var(mpg_am1)) / sqrt(13)

#Soluzione proposta
24.39231 + c(-1,1) * qt(1 - 0.01 /2, df = 12 ) * 6.16650 / sqrt( 13 )


#ESERCIZIO 20
#Assumendo che i valori di consumo di carburante (mpg) siano normalmente distribuiti all’interno dei gruppi di auto con trasmissione automatica e manuale, quale test statistico è più appropriato per verificare se la media di mpg è diversa tra i due gruppi?
#Test t per campioni indipendenti


#ESERCIZIO 21
cors <- cor(mtcars)
cors

#wt


#ESERCIZIO 22
#Cosa indica il segno negativo del coefficiente associato alla variabile wt
model <- lm(mpg ~ wt, data = mtcars)
summary(model)

#guardando wt notiamo che è negativo. Ciò significa che all'aumentare di wt, mpg diminuisce


#ESERCIZIO 23
#Quale interpretazione è corretta per il valore dell’intercetta nel modello di regressione?
#Quando wt = 0, il valore atteso di mpg è circa 37.29.


#ESERCIZIO 24
#Durante l’analisi diagnostica di un modello di regressione, si osserva che il grafico dei residui rispetto ai valori predetti mostra una netta forma a imbuto. Quale problema fondamentale indica questo pattern?
#Italiano: Violazione dell’assunzione di varianza costante dei residui.