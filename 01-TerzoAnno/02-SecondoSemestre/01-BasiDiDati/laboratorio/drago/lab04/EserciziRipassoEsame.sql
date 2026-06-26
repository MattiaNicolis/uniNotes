/*
Esercitazione 04 – 26 Marzo 2026


Esercizio 1
Trovare identificatore, cognome e nome dei docenti che, nell’anno accademico 2010/2011, hanno tenuto
un insegnamento (l’attributo da confrontare è nomeins) che non hanno tenuto nell’anno accademico
precedente. Ordinare la soluzione per identificatore.
La soluzione ha 1031 righe. Le 5 a partire dalla XX riga sono:
*/

SELECT DISTINCT p.id, p.cognome, p.nome
FROM Persona p
    JOIN Docenza d1 ON p.id = d1.id_persona
    JOIN InsErogato ins1 ON d1.id_inserogato = ins1.id
    JOIN Insegn i1 ON ins1.id_insegn = i1.id
WHERE ins1.annoaccademico = '2010/2011'
  AND NOT EXISTS (
      -- La subquery controlla se lo STESSO docente ha tenuto lo STESSO corso l'anno prima
      SELECT 1
      FROM Docenza d2
          JOIN InsErogato ins2 ON d2.id_inserogato = ins2.id
          JOIN Insegn i2 ON ins2.id_insegn = i2.id
      WHERE d2.id_persona = p.id              -- Correlazione: stesso docente
        AND i2.nomeins = i1.nomeins           -- Correlazione: stesso nome dell'insegnamento
        AND ins2.annoaccademico = '2009/2010' -- Condizione: anno precedente
  )
ORDER BY p.id;


/*
Esercizio 2
Trovare i corsi di studio che non sono gestiti dalla facoltà di “Medicina e Chirurgia” e che hanno
insegnamenti erogati con moduli nel 2010/2011. 
Si visualizzi il nome del corso e il numero di insegnamenti erogati con
moduli nel 2010/2011.
Soluzione: ci sono 33 righe. Le prime 5 ordinate rispetto al nome sono:
nome
*/

SELECT cs.nome, COUNT(ins)
FROM inserogato ins
	JOIN corsostudi cs ON cs.id = ins.id_corsostudi
WHERE ins.annoaccademico = '2010/2011' and ins.hamoduli <> '0'
	AND cs.id NOT IN (
		
		--corsi di studio gestiti dalla facolta di medicina e chirurgia
		SELECT cs2.id
		FROM corsostudi cs2 
			 JOIN corsoinfacolta cif2 ON cif2.id_corsostudi = cs2.id
			 JOIN facolta f2 ON f2.id = cif2.id_facolta
		WHERE f2.nome like 'Medicina e Chirurgia' 
)
GROUP BY cs.nome
ORDER BY cs.nome



/*
Esercizio 3
Trovare gli insegnamenti del corso di studi con id=4 che non sono mai stati offerti al secondo
quadrimestre.
Per selezionare il secondo quadrimestre usare la condizione "abbreviazione LIKE '2%'".
La soluzione ha 14 righe.
*/

SELECT DISTINCT i.nomeins, ins.id_corsostudi
FROM inserogato ins  
	JOIN insegn i ON i.id = ins.id_insegn
WHERE ins.id_corsostudi = 4 AND i.id NOT IN ( 
		
		-- selezione degli insegnamenti offerti al secondo quadrimestre
		SELECT DISTINCT i2.id
		FROM periodolez pl2
			JOIN lezione l2 ON l2.id_periodolez = pl2.id
			JOIN inserogato ins2 ON ins2.id = l2.id_inserogato
			JOIN insegn i2 ON i2.id = ins2.id_insegn
		WHERE ins2.id_corsostudi = 4 and pl2.abbreviazione LIKE '2%'

)

/*
Esercizio 4
Trovare il nome dei corsi di studio che non hanno mai erogato insegnamenti che contengono nel nome
la stringa ’matematica’ (usare ILIKE invece di LIKE per rendere il test non sensibile alle
maiuscole/minuscole (case-insensitive)).
La soluzione ha 572 righe.

*/

SELECT cs.nome
FROM corsostudi cs
WHERE cs.id NOT IN (
		
		-- corsi studio che hanno erogato insegnamenti con nel nome la stringa 'matematica'
SELECT DISTINCT cs.id
FROM insegn i
	JOIN inserogato ins ON ins.id_insegn = i.id
	JOIN corsostudi cs ON cs.id = ins.id_corsostudi
WHERE i.nomeins ilike '%matematica%' 

)

/*
Esercizio 5
Trovare nome, cognome e telefono dei docenti che hanno tenuto nel 2009/2010 un’occorrenza di
insegnamento che non sia un’unità logistica del corso di studi con id=4 ma che non hanno mai tenuto un
modulo dell’insegnamento di ’Programmazione’ del medesimo corso di studi.

*/


SELECT DISTINCT p.nome, p.cognome, p.telefono
FROM docenza d
	JOIN inserogato ins ON ins.id = d.id_inserogato
	JOIN persona p ON p.id = d.id_persona
WHERE ins.annoaccademico = '2009/2010' and ins.id_corsostudi = 4 and ins.modulo >= 0
	and p.id NOT IN (

-- docenti che hanno tenuti insegnamenti con id = 4, con moduli nell'insegnamento di programmazione
SELECT d.id_persona
FROM docenza d 
	JOIN inserogato ins ON ins.id = d.id_inserogato
	JOIN insegn i ON i.id = ins.id_insegn
WHERE ins.id_corsostudi = 4 and ins.modulo > 0 and i.nomeins like '%Programamzione%' 
)
ORDER BY p.cognome, p.nome


/* 
Esercizio 6
Trovare, per ogni facoltà, il numero di unità logistiche erogate (modulo < 0) e il numero corrispondente di
crediti totali erogati nel 2010/2011, riportando il nome della facoltà e i conteggi richiesti. Usare pure la
relazione diretta tra InsErogato e Facolta.
La soluzione ha 8 righe. La riga relativa a ’Medicina e Chirurgia’ ha valori 253 e 979,50.
*/


