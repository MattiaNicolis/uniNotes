#Import
import datetime
import decimal
import json
import re

#Classi o funzioni di servizio
pattern = re.compile(r"^\d{2}/\d{2}/\d{4}$")

def creaDict(data, voce, importo):
    if not isinstance(data, str) or not pattern.match(data):
        print("Data non è nel formato dd/mm/aaaa")
        exit()
    if not isinstance(importo, decimal.Decimal) and not isinstance(importo, str):
        print("Importo deve essere un Decimal o una stringa che rappresneta un importo")
        exit()
    return{'data': data, 'voce': voce, 'importo': decimal.Decimal(importo)}

class Spese:
    def makeKey(data, voce):
        return data + "_%_" + voce
    
    def __init__(self, inputTab = {}, istance = datetime.datetime.now()):
        self.tabella = dict(inputTab)
        self.ultimaModifica = istance
    
    def add(self, data, voce, importo):
        self.tabella[Spese.makeKey(data, voce)] = creaDict(data, voce, importo)
        self.ultimaModifica = datetime.datetime.now()
        return importo
    
    def remove(self, data, voce):
        del self.tabella[Spese.makeKey(data, voce)]
        self.ultimaModifica = datetime.datetime.now()

    def get(self, data, voce):
        return self.tabella[self.makeKey(data, voce)]
    
    def items(self):
        return self.tabella.items()
    
#Creazione della tabella + aggiunta dati
tab = Spese ()
tab.add("24/02/2016", " Stipendio ", "0.1")
tab.add("24/02/2016", 'Stipendio "Bis"', "0.1")
tab.add("24/02/2016", 'Stipendio "Tris"', "0.1")
tab.add("27/02/2016", " Affitto ", " -0.3")

#Stampa della tabella dalla memoria
print('=' * 50)
print("| {:10s} | {:<20s} | {:>10s} |".format("Data", "Voce", "Importo"))
print('=' * 50)
for riga in tab.tabella.values():
    print("| {:10s} | {:<20s} | {:>10.2f} |".format(riga['data'], riga['voce'], riga['importo']))
    print('=' * 50)

#Calcolo del totale degli importi
tot = decimal.Decimal(0)
for riga in tab.tabella.values():
    tot += riga['importo']
print("La somma è {:.20f}".format(tot))

#Salvataggio in un file
class MyEncoder(json.JSONEncoder):
    def default(self, o):
        if isinstance(o, decimal.Decimal):
            return float(o)
        if isinstance(o, datetime.datetime):
            return o.isoformat()
        if isinstance(o, Spese):
            return{"tabella":o.tabella, "ultimaModifica":o.ultimaModifica}
        return json.JSONEncoder.default(self, o)
    
#Salvataggio della tabella in un file
nomeFile = 'database.json'
with open(nomeFile, mode='w', encoding='utf-8') as file:
    json.dump(tab, file, cls=MyEncoder, indent=4)
def myDecoder(jsonObj):
    if 'tabella' in jsonObj:
        tab = jsonObj['tabella']
        istante = datetime.datetime.strptime(jsonObj['ultimaModifica'], "%Y-%m-%dT%H:%M:%S.%f")
        return Spese(tab, istante)
    else:
        return jsonObj

#Lettura della tabella dal file e la pongo in una nuova variabile
with open(nomeFile, mode='r', encoding='utf-8') as file:
    tab1 = json.load(file, object_hook=myDecoder, parse_float=decimal.Decimal)

#Calcolo del totale sulla nuova tabella
tot1 = decimal.Decimal(0)
for riga in tab1.tabella.values():
    tot1 += riga['importo']
if tot == tot1:
    print("I due totali sono uguali!")
if tot == 0:
    print("Eureka!")
else:
    print("Ops...il toale non è corretto!")