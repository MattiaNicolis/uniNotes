/* 
Esercitazione 2 – 12 Marzo 2026

Esercizio 1
Visualizzare tutti i musei della città di Verona con il loro giorno di chiusura.
*/

SELECT nome, citta, giornochiusura
FROM Museo
WHERE citta ilike '%verona%'

/*
Esercizio 2

Visualizzare per ogni mostra che inizia con la lettera ’R’, una stringa composta dal titolo 
e dalla città in cui si svolge.
*/

SELECT titolo || '-' || citta AS titolo_citta
FROM Mostra
WHERE titolo LIKE 'R%'

SELECT * FROM mostra

/*
Esercizio 3

Visualizzare il titolo di ogni mostra ancora in corso e quanti giorni rimane ancora aperta 
a partire dalla data corrente. Usare la costante CURRENT_DATE per avere la data corrente.
*/

SELECT * FROM mostra

SELECT titolo, fine - CURRENT_DATE as giorni_ancora_aperto
FROM mostra
WHERE CURRENT_DATE > inizio and CURRENT_DATE < fine

/*
Esercizio 4

Visualizzare per ogni museo l’orario di apertura e chiusura il martedì. 
Se per un museo il martedì è giorno di chiusura, non mostrare nulla.
*/

-- popolare orario 
INSERT INTO Orario (progressivo, museo, citta, giorno, orarioApertura, orarioChiusura)
VALUES 
(1, 'CastelVecchio', 'Verona', 'LUN', '09:00:00+01', '19:00:00+01'),
(2, 'Arena', 'Verona', 'MAR', '09:00:00+01', '19:00:00+01'),
(3, 'Arena', 'Verona', 'MER', '09:00:00+01', '19:00:00+01');
INSERT INTO Orario (progressivo, giorno, orarioApertura, orarioChiusura)
VALUES (4, 'GIO', '09:00:00+01', '19:00:00+01');

SELECT museo, orarioapertura, orariochiusura 
FROM orario
WHERE giorno ilike 'mar%'

/*
Esercizio 5

Assicurarsi che almeno una mostra abbia il prezzo ridotto non valorizzato (NULL) usando 
eventualmente il comando UPDATE per modificare almeno una riga.
Visualizzare tutte le mostre che hanno prezzo ridotto non valorizzato usando prima l’espressione
ERRATA ’prezzoRidotto = NULL’ e poi l’espressione corretta prezzoRidotto IS NULL.
*/

SELECT * 
FROM Mostra
WHERE prezzoIntero is null

UPDATE mostra 
SET prezzointero = null
WHERE titolo ilike '%rinascimento veneto'


/*
Esercizio 6
Visualizzare tutte le mostre non terminate in ordine di data inizio e, 
in caso di pari data inizio, data fine.
*/

SELECT *
FROM mostra
WHERE CURRENT_DATE < fine
ORDER BY inizio, fine

/*
Esercizio 7
Visualizzare il numero totale di giorni di apertura del museo ’Arena’ di ’Verona’.
*/

SELECT COUNT(*) as giorniapertura
FROM orario
WHERE museo || ' ' || citta ilike 'arena verona'

/*
Esercizio 8
Visualizzare le ore medie di apertura del museo ’Arena’ di ’Verona’.
Suggerimento: convertire orarioapertura e orariochiusura usando ’::time’.
*/

SELECT AVG(orarioapertura::time) as ore_medie_apertura
FROM orario
WHERE museo || ' ' || citta ilike 'arena verona'

/*
Esercizio 9
Indicare il numero di autori distinti presenti in tutti i musei.
*/

SELECT DISTINCT nomeautore, cognomeautore
FROM opera