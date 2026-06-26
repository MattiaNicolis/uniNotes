
-- ESERCITAZIONE 2

/*
Esercizio 1
Visualizzare tutti i musei della città di Verona con il loro giorno di chiusura.
*/
SELECT nome, citta, giornochiusura
FROM museo
WHERE citta iLIKE '%Verona%'

/*
Esercizio 2
Visualizzare per ogni mostra che inizia con la lettera ’R’, una stringa composta dal titolo e dalla 
città in cui si svolge.
*/
SELECT *
FROM mostra

SELECT titolo || '-' || citta as titoloEcitta
FROM mostra

/*
Esercizio 3
Visualizzare il titolo di ogni mostra ancora in corso e quanti giorni rimane ancora aperta a partire 
dalla data corrente. Usare la costante CURRENT_DATE per avere la data corrente
*/
SELECT titolo, inizio, fine
FROM mostra
WHERE CURRENT_DATE > inizio and CURRENT_DATE < fine -- mostra ancora in corso

/*
Esercizio 4
Visualizzare per ogni museo l’orario di apertura e chiusura il martedì. 
Se per un museo il martedì è giorno di chiusura, non mostrare nulla.
*/
SELECT o.museo, o.orarioApertura, o.orarioChiusura
FROM orario o, museo m
WHERE m.nome = o.museo and m.citta = o.citta and o.giorno = 'MAR'

/*
Esercizio 5
Assicurarsi che almeno una mostra abbia il prezzo ridotto non valorizzato (NULL) usando eventualmente 
il comando UPDATE per modificare almeno una riga.
Visualizzare tutte le mostre che hanno prezzo ridotto non valorizzato usando prima l’espressione 
ERRATA ’prezzoRidotto = NULL’ e poi l’espressione corretta prezzoRidotto IS NULL.
*/
SELECT *
FROM mostra
WHERE prezzoridotto IS NULL

UPDATE mostra 
SET prezzoridotto = NULL
WHERE titolo ilike '%rinasci%' 

/*
Esercizio 6
Visualizzare tutte le mostre non terminate in ordine di data inizio e, in caso di pari data inizio, 
data fine.
*/
SELECT titolo, inizio, fine
FROM mostra
WHERE CURRENT_DATE < fine
ORDER BY inizio, fine

/*
Esercizio 7
Visualizzare il numero totale di giorni di apertura del museo ’Arena’ di ’Verona’.
*/
SELECT COUNT(*) as giorniApertura
FROM orario 
WHERE museo iLIKE 'Arena' and citta iLIKE 'Verona'

/*
Esercizio 8
Visualizzare le ore medie di apertura del museo ’Arena’ di ’Verona’.
Suggerimento: convertire orarioapertura e orariochiusura usando ’::time’.
*/
SELECT museo, AVG(orarioapertura::time)
FROM orario
WHERE museo || ' di ' || citta ilike 'Arena di Verona'
GROUP BY museo

/*
Esercizio 9
Indicare il numero di autori distinti presenti in tutti i musei.
*/

SELECT DISTINCT nome, cognomeautore
FROM opera