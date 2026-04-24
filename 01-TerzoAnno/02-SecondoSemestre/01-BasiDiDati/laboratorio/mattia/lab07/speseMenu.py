#Import
from datetime import date
from decimal import Decimal
import psycopg2
import os

#Stampa a video del menù di scelta
def main():
    while True:
        print()
        print("=== GESTIONE DEL DATABASE PGADMIN ===")
        print("1. Inserimento (INSERT)")
        print("2. Selezione (SELECT)")
        print("3. Eliminazione (DELETE)")
        print("4. Pulizia terminale (CLEAR)")

        #Salvataggio della scelta
        try:
            scelta = int(input("\nSelzionare una voce del menù: "))

            match scelta:
                case 1:
                    print("Eseguo comando: INSERT INTO...")
                    MyInsertInto()
                case 2:
                    print("Eseguo comando: SELECT * FROM...")
                    MySelect()
                case 3:
                    print("Eseguo comando: DELETE FROM...")
                    MyDelete()
                case 4:
                    print("Eseguo comando: CLEAR...")
                    MyClear()
                case 0:
                    print("Uscita...")
                    break
                case _:
                    print("Opzione non valida! Riprova")
        except ValueError:
            print("Errore! Inserire un numero valido!")

#Connessione al server
def MyConnection():
    try:
        connection = psycopg2.connect(
            host="dbserver.scienze.univr.it",
            database="id090rvi",
            user="id090rvi",
            password="pwd"
        )
        return connection
    except Exception as e:
        print(f"Errore di connessione: {e}")
        return None

#Definizione delle funzioni di ciascuna azione
def MyInsertInto():
    conn = MyConnection()
    if conn:
        try:
            with conn:
                with conn.cursor() as cursore:
                    voce = input("Cosa hai comprato? ")
                    importo = float(input("Quanto hai speso? "))
                    data = date.today()
                    cursore.execute(
                        "INSERT INTO Spese (data, voce, importo) " \
                        "VALUES (%s, %s, %s)", (data, voce, importo)
                    )
        except Exception as e:
            print(f"Errore durante l'operazione SQL: {e}")
        finally:
            conn.close()

def MySelect():
    conn = MyConnection()

    if conn:
        try:
            with conn:
                with conn.cursor() as cursore:
                    cursore.execute(
                        """SELECT *
                        FROM Spese
                        """
                    )
                    rows = cursore.fetchall()
                    for row in rows:
                        print(f"{row[0]} | {row[1]} | {row[2]} | {row[3]}")
        except Exception as e:
            print(f"Errore durante l'operazione SQL: {e}")
        finally:
            conn.close()

def MyDelete():
    conn = MyConnection()

    if conn:
        try:
            with conn:
                with conn.cursor() as cursore:
                    id = input("Inserisci l'indice della spesa da eliminare: ")
                    cursore.execute(
                        "DELETE FROM Spese WHERE id = %s", (id)
                    )
        except Exception as e:
            print(f"Errore durante l'operazione SQL: {e}")
        finally:
            conn.close()

def MyClear():
    os.system("clear")

#Chiamata del main del programma
if __name__ == "__main__":
    main()