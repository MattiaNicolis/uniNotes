from datetime import date
from decimal import Decimal
import psycopg2

#Connessione com pgAdmin
connessione = psycopg2.connect(
    host="dbserver.scienze.univr.it", 
    database="id090rvi", 
    user="id090rvi", 
    password="pwd"
)

with connessione:
    with connessione.cursor() as cursore:
        cursore.execute(
            """CREATE TABLE IF NOT EXISTS Spese (
                id SERIAL PRIMARY KEY,
                data DATE NOT NULL,
                voce VARCHAR NOT NULL,
                importo NUMERIC NOT NULL
            )"""
        )
        # Rimosso il backslash errato
        print('Esito creazione tabella: {:s}'.format(cursore.statusmessage))

        cursore.execute("""SELECT count(*) FROM Spese""")
        numeroRighe = cursore.fetchone()[0]

        if numeroRighe == 0:
            # Sistemato il nome colonna 'data' e le parentesi della VALUES
            cursore.execute("""INSERT INTO Spese(data, voce, importo) VALUES
                (%s, %s, %s),
                (%s, %s, %s),
                (%s, %s, %s),
                (%s, %s, %s)""",
                (date(2016, 2, 24), "Stipendio", Decimal("0.1"),
                 date(2016, 2, 24), "Stipendio 'Bis'", Decimal("0.1"),
                 date(2016, 2, 24), "Stipendio 'Tris'", Decimal("0.1"),
                 date(2016, 2, 27), "Affitto", Decimal("-0.3"))
            )
            print("Inserimento riuscito: {:s}".format(cursore.statusmessage))
        else:
            print("La tabella contiene già dei dati.")

    # Lettura dei dati
    with connessione.cursor() as lettore:
        # Corretto 'FROME' in 'FROM'
        lettore.execute("""SELECT id, data, voce, importo FROM Spese""")
        
        print('=' * 55)
        header = "| {:>2} | {:10} | {:<20} | {:>10} |"
        print(header.format("N", "Data", "Voce", "Importo"))
        print('=' * 55)
        
        tot = Decimal("0")
        patternRiga = "| {:>2d} | {:10} | {:<20} | {:>10.2f} |"
        for tupla in lettore:
            print(patternRiga.format(tupla[0], tupla[1].isoformat(), tupla[2], tupla[3]))
            tot += tupla[3]
        print('-' * 55)
        print("{:>40} {:10.2f}".format("Totale", tot))

connessione.close()