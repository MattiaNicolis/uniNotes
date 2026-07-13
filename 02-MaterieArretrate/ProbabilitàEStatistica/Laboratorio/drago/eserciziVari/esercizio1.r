install.packages("swirl")
library(swirl)
swirl()


#Assegnazione 
A <- 1 + 1

#Per eliminare tutte le variabili salvate nell'ambiente di lavoro
rm(list =ls())

help(rm)

students <- 100
students = 102
#eliminare singolo valore
rm(students)

help(ls)

#vettore
v1 <- c(2, 5, 1)
v2 <- c(3,5)

v3 <- c(v1, v2)

x1 <- (1:10)
x2 <-(1:9)
x2

x3 <- seq(from = 4, to = 0.9, by = -0.02)
x3 <- rep(c(v1, v2), times = 3)
x3


#Funzioni utili
len = length(x3)
max(x3);  min(x2); sum(x3); mean(x3); cumsum(x3)

#come creare matrici
mat1 <- cbind(c(1,2,3), c(4,5,6))
mat2 <- rbind(c(1,2,3), c(4,5,6))
mat3 <- matrix(data = c(1,2,3,4,5,6), nrow = 3, ncol = 2)
mat3

#ottenere un elemento
mat3[1,2]

#ottenere tutta una riga o colonna
mat3[,2]
mat3[2,]

#per visualizzare matrice senza una riga o colonna usare simbolo - prima di indice
mat3[-1, ]
mat3

#matrici speciali
mat_zero <- matrix(0,3,3)
mat_ones <- matrix(1,3,3)
mat_id <- diag(3)

#operazioni con vettori e matrici
A <- matrix(data = 1:9, nrow = 3)
B <- A +1


C <- A^2
C
D <- sqrt(A)

sum(A)
mean(A)

solve(A)
dim(A)





#Esercizi proposti pdf
#A. . Crea i seguenti vettori due volte: il primo usando l’operatore due punti (colon operator)e il secondo usando il comando seq()
matrice1 = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
matrice2 = c(2,7,12)

matrice1lancio = seq(from = 1, to = 10, by = 1)
matrice2lancio = seq(from = 2, to = 12, by = 5)


# B.  Crea una matrice 4x2 di tutti zeri e memorizzala in una variabile (mymat).Poi,sostituisci la seconda riga della matrice con un vettore compostodai valori 3 e 6

mymat = matrix(0, 4,2)
mymat[2,] = c(3, 6)

#C.  Crea un vettore x costituito da 20 punti equidistantinell’intervallo da–𝛑 a +𝛑. Crea un vettorey che sia sin(x).

x = seq(from = -pi, to = pi,length.out = 20 )
y = sin(x)

#D. D. Crea una matrice 4x6 di numeri interi casuali, ciascuno nell’intervallo da -5 a 5; memorizzala in una variabile (mat). Crea un’altra matrice (mat_pos) che contenga il valore assoluto di ciascun elemento corrispondente nella matrice originale.

mat = matrix(sample(-5:5, 24, TRUE), 4, 6)
mat_pos = abs(mat)

#E. Crea una sequenza di valori uche vada da-2 a 2conincrementi di 0.1.Poicalcola il valoredi exp(u) per ciascun valore della sequenza e memorizzai risultati in una variabile v.

u = seq(from = -2, to = 2, by = 0.1)
v = exp(u)


#F. Crea un vettorez convalori che vanno da 1 a100 conincrementi di 5.Crea un vettorewche contengala radice quadrata di ciascun valore in z.

z = seq(1, 100, 5)
w = sqrt(z)
