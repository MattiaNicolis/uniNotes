#Import
import csv
import re

#Classi o funzioni di servizio
pattern = re.compile(r"^\d{2}/\d{2}/\d{4}$")

def creaDict(data, voce, importo):
    if not isinstance(data, str) or not pattern.match(data):
        print()
        exit()
    return{'data': data , 'voce': voce, 'importo': float(importo)}

#Creazione della tabella + aggiunta dei dati
tabella = list()
tabella.append(creaDict("24/02/2016", "Stipendio", 0.1))
tabella.append(creaDict("24/02/2016", 'Stipendio "Bis"', 0.1))
tabella.append(creaDict("24/02/2016", 'Stipendio "Tris"', -0.3))

#Stampa della tabella dalla memoria
print('=' * 50)
print("| {:10s} | {:<20s} | {:>10s} | ".format("Data", "Voce", "Importo"))
print('=' * 50)
for riga in tabella:
    print("| {:10s} | {:<20s} | {:>10.2f} | ".format(riga['data'], riga['voce'], riga['importo']))
    print('=' * 50)

#Calcolo del ttoale degli importi
tot = 0.0
for riga in tabella:
    tot += riga['importo']
print("La somma è {:.20f}".format(tot))

#Salvataggio della tabella in un file formato CSV
nomeFile = 'tabellaSpesa.csv'
with open(nomeFile, mode='w', encoding='utf-8') as csvFile:
    nomeCampi = ['data', 'voce', 'importo']
    writer = csv.DictWriter(csvFile, fieldnames=nomeCampi)
    writer.writeheader()
    for riga in tabella:
        writer.writerow(riga)

#Lettura della tabella dal file e la pongo in una nuova variabile
tab1 = list()
with open(nomeFile, mode='r', encoding='utf-8') as csvFile:
    reader = csv.DictReader(csvFile)
    for row in reader:
        tab1.append(creaDict(row['data'], row['voce'], row['importo']))

#Calcolo del totale sulla nuova tabella
tot1 = 0
for riga in tab1:
    tot1 += riga['importo']
if tot == tot1:
    print("I due totali sono uguali")
else:
    print("Ops...la tabella letta non ha gli stessi dati!")
if tot == 0:
    print("Eureka!")
else:
    print("Ops...il totale non è corretto perchè non è 0!")