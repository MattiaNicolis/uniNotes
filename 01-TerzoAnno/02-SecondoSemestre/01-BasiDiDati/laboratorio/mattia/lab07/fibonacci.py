#Serie di Fibonacci
a,b = 0,1 #assegnamento in sequenza
n = int(input("Fino a quale intero calcolare la serie? "))
while b < n:
    print(b, end=' ')
    a,b = b, a+b
print()