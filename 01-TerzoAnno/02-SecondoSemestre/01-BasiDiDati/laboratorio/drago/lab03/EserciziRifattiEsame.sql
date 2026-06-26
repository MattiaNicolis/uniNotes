/*
Esercitazione 03 – 19 Marzo 2026


Esercizio 1
Visualizzare il numero di corso studi presenti nella base di dati.
Soluzione: ci sono 635 corsi di studio.
*/

SELECT * 
FROM corsostudi

/*
Esercizio 2
Visualizzare il nome, il codice, l’indirizzo e l’identificatore del preside di tutte le facoltà.
Soluzione: ci sono 8 facoltà
*/

SELECT nome, codice, indirizzo, id_preside_persona
FROM facolta

/*
Esercizio 3
Trovare per ogni corso di studi che ha erogato insegnamenti nel 2010/2011 
il suo nome e il nome delle facoltà che lo gestiscono (si noti che un corso può essere gestito da più facoltà). 
Non usare la relazione diretta tra InsErogato e Facoltà. Porre i risultati in ordine di nome corso studi.
Soluzione: ci sono 211 righe. Le 5 righe dalla X posizione sono:
*/

SELECT DISTINCT cs.nome, f.nome
FROM corsostudi cs
	JOIN inserogato ins ON ins.id_corsostudi = cs.id
	JOIN corsoinfacolta cif ON cif.id_corsostudi = cs.id
	JOIN facolta f ON f.id = cif.id_facolta
WHERE ins.annoaccademico = '2010/2011'
ORDER BY cs.nome

/*
Esercizio 4
Visualizzare il nome, il codice e l’abbreviazione di tutti i corsi di studio gestiti 
dalla facoltà di Medicina e Chirurgia.
Soluzione: ci sono 236 righe.
*/

SELECT cs.nome, cs.codice, cs.abbreviazione
FROM corsostudi cs
	JOIN corsoinfacolta cif ON cif.id_corsostudi = cs.id
	JOIN facolta f ON f.id = cif.id_facolta
WHERE f.nome ilike '%Medicina e Chirurgia%'


/*
Esercizio 5
Visualizzare il codice, il nome e l’abbreviazione di tutti corsi di studio che nel nome contengono 
la sottostringa ’lingue’ (eseguire il confronto usando ILIKE invece di LIKE: 
in questo modo i caratteri maiuscolo e minuscolo non sono diversi).
Soluzione: ci sono 16 righe.
*/

SELECT cs.codice, cs.nome, cs.abbreviazione
FROM corsostudi cs 
WHERE cs.nome ilike '%lingue%'

/*
Esercizio 6
Visualizzare le sedi dei corsi di studi in un elenco senza duplicati.
Soluzione: ci sono 48 righe.
*/

SELECT DISTINCT cs.sede
FROM corsostudi cs

/*
Esercizio 7
Visualizzare solo i moduli degli insegnamenti erogati nel 2010/2011 nei corsi di studi della facoltà di 
Economia.
Si visualizzi il nome dell’insegnamento, il discriminante (attributo descrizione della tabella Discriminante),
il nome del modulo e l’attributo modulo.
Soluzione: ci sono 27 righe.
*/

SELECT i.nomeins, d.descrizione, ins.modulo, ins.nomemodulo
FROM inserogato ins
	JOIN corsostudi cs ON cs.id = ins.id_corsostudi
	JOIN corsoinfacolta cif ON cif.id_corsostudi = cs.id
	JOIN facolta f ON f.id = cif.id_facolta
	JOIN discriminante d ON d.id = ins.id_discriminante
	JOIN insegn i ON i.id = ins.id_insegn
WHERE ins.annoaccademico = '2010/2011' and f.nome ilike '%economia%' and ins.modulo > 0

/*
Esercizio 8
Visualizzare il nome e il discriminante (attributo descrizione della tabella Discriminante)
degli insegnamenti erogati nel 2009/2010 che non sono moduli e che hanno 3, 5 o 12 crediti. 
Si ordini il risultato per discriminante.
Soluzione: ci sono 724 righe distinte. Le ultime 5 righe sono:
*/

SELECT DISTINCT i.nomeins, d.descrizione, d.id
FROM inserogato ins 
	JOIN discriminante d ON d.id = ins.id_discriminante
	JOIN insegn i ON i.id = ins.id_insegn
WHERE ins.annoaccademico = '2009/2010' and ins.modulo = 0 and (ins.crediti = 3 or ins.crediti = 5 or ins.crediti = 12) 
ORDER BY d.descrizione

/*
Esercizio 9
Visualizzare l’identificatore, il nome e il discriminante degli insegnamenti erogati
nel 2008/2009 che non sono moduli o unità logistiche e con peso maggiore di 9 crediti. Ordinare per nome.
Soluzione: ci sono 1218 righe. Le 5 righe dalla MXXIII riga sono:
*/

SELECT ins.id, i.nomeins, d.descrizione
FROM inserogato ins
	JOIN discriminante d ON d.id = ins.id_discriminante
	JOIN insegn i ON i.id = ins.id_insegn
WHERE ins.annoaccademico = '2008/2009' and ins.modulo = 0 and ins.crediti > 9
ORDER BY i.nomeins


/*
Esercizio 10
Visualizzare in ordine alfabetico di nome degli insegnamenti (esclusi i moduli e le unità logistiche) 
erogati nel 2010/2011 nel corso di studi in Informatica, riportando il nome, il discriminante, 
i crediti e gli anni di erogazione.
Soluzione: ci sono 26 righe.
*/

SELECT DISTINCT i.nomeins, d.descrizione, ins.crediti, ins.annierogazione
FROM insegn i
	JOIN inserogato ins ON i.id = ins.id_insegn
	JOIN corsostudi cs ON cs.id = ins.id_corsostudi
	JOIN discriminante d ON d.id = ins.id_discriminante
WHERE ins.annoaccademico = '2010/2011' and cs.nome like '%Informatica' and ins.modulo = 0
ORDER BY i.nomeins

SELECT *
FROM corsostudi
WHERE nome ilike '%informatica'

-- a quanto pare la stringa da ricercare deve essere nel formato inserito sopra

/*
Esercizio 11
Trovare il massimo numero di crediti associato a un insegnamento fra quelli erogati nel 2010/2011.
Soluzione: 180
*/

SELECT MAX(ins.crediti)
FROM inserogato ins 
WHERE ins.annoaccademico = '2010/2011'

/*
Esercizio 12
Trovare, per ogni anno accademico, il massimo e il minimo numero di crediti erogati tra gli 
insegnamenti dell’anno.
Soluzione: ci sono 16 righe.
*/

SELECT MAX(ins.crediti), MIN(ins.crediti), ins.annoaccademico
FROM inserogato ins
GROUP BY(ins.annoaccademico)

/*
Esercizio 13
Trovare, per ogni anno accademico e per ogni corso di studi la somma dei crediti erogati 
(esclusi i moduli e le unità logistiche: vedi nota sopra) e il massimo e minimo numero di crediti degli 
insegnamenti erogati sempre escludendo i moduli e le unità logistiche.
Soluzione: ci sono 1587 righe. Le riga relativa alla 
"Scuola di Specializzazione in Urologia (Vecchio ordinamento)" 
nell’anno 2011/2012 ha valori 52.00, 10.00 e 162.00.
*/

SELECT cs.nome, ins.annoaccademico, SUM(ins.crediti), MAX(ins.crediti), MIN(crediti)
FROM inserogato ins
	JOIN corsostudi cs ON cs.id = ins.id_corsostudi
WHERE ins.modulo = 0
GROUP BY(cs.nome, ins.annoaccademico)
ORDER BY cs.nome

/*
Esercizio 14
Trovare per ogni corso di studi della facoltà di Scienze Matematiche Fisiche e Naturali 
il numero di insegnamenti (esclusi i moduli e le unità logistiche) erogati nel 2009/2010.
Soluzione: ci sono 19 righe.
*/

SELECT COUNT(ins.id_insegn), cs.nome
FROM inserogato ins
	JOIN corsostudi cs ON cs.id = ins.id_corsostudi
	JOIN corsoinfacolta cif ON cif.id_corsostudi = cs.id
	JOIN facolta f ON f.id = cif.id_facolta
WHERE ins.modulo = 0 and ins.annoaccademico = '2009/2010' and f.nome ilike '%Scienze Matematiche Fisiche e Naturali%'
GROUP BY(cs.nome)

/*
Esercizio 15
Trovare i corsi di studi che nel 2010/2011 hanno erogato insegnamenti con un numero di 
crediti pari a 4 o 6 o 8 o 10 o 12 o un numero di crediti di laboratorio tra 10 e 15 escluso, 
riportando il nome del corso di studi e la sua durata.
Si ricorda che i crediti di laboratorio sono rappresentati dall’attributo creditilab della tabella InsErogato.
Soluzione: ci sono 197 righe.
*/

SELECT DISTINCT cs.nome, cs.durataAnni
FROM inserogato ins
	JOIN corsostudi cs ON cs.id = ins.id_corsostudi
WHERE ins.annoaccademico = '2010/2011' and ins.crediti IN (4,6,8,10,12) or (ins.creditilab > 10 and ins.creditilab < 15)

/*
Esercizio 16
Trovare nome, cognome dei docenti che nell’anno accademico 2010/2011 erano docenti 
in almeno due corsi di studio (vale a dire erano docenti in almeno due insegnamenti o
moduli A e B dove A è del corso C1 e B è del corso C2 con C1 <> C2).

La soluzione ha 839 righe. Se si ordina la risposta per un opportuno attributo, 
le 5 righe a partire dalla 50-esima sono:
*/

SELECT p.nome, p.cognome 
FROM inserogato ins 
	JOIN docenza d ON d.id_inserogato = ins.id 
	JOIN persona p ON p.id = d.id_persona
WHERE ins.annoaccademico = '2010/2011'
GROUP BY p.id, p.nome, p.cognome
HAVING COUNT (DISTINCT ins.id_corsostudi) >= 2  

/*
Esercizio 17
Trovare per ogni periodo di lezione del 2010/2011 la cui descrizione inizia con ’I semestre’ 
o ’Primo semestre’ il numero di occorrenze di insegnamento allocate in quel periodo.
Si visualizzi quindi: l’abbreviazione, il discriminante, inizio, fine e il conteggio richiesto 
ordinati rispetto all’inizio e fine.
La soluzione ha 3 righe:
*/
SELECT * FROM Lezione

SELECT pl.abbreviazione, pd.discriminante, pd.inizio, pd.fine, COUNT(iip.id_inserogato)
FROM periododid pd
	JOIN periodolez pl ON pl.id = pd.id
	JOIN insinperiodo iip ON iip.id_periodolez = pl.id
WHERE pd.annoaccademico = '2010/2011' and (pd.descrizione ilike 'I semestre%' or pd.descrizione ilike 'Primo semestre%') 
GROUP BY pl.abbreviazione, pd.id
ORDER BY pd.inizio, pd.fine

/*
Esercizio 18
Trovare per ogni segreteria che serve almeno un corso di studi il numero di corsi di studi serviti, 
riportando il nome della struttura, il suo numero di fax e il conteggio richiesto.
La soluzione ha 42 righe.
*/

SELECT ss.nomestruttura, ss.fax, COUNT(cs.id)
FROM strutturaservizio ss
	JOIN corsostudi cs ON cs.id_segreteria = ss.id
WHERE cs.id_segreteria is not null
GROUP BY ss.nomestruttura, ss.fax	