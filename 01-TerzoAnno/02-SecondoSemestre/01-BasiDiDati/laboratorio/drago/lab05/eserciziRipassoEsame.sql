/*
Esercitazione 05 – 9 Aprile 2026

Esercizio 1
Visualizzare in nomi dei corsi di studio che finiscono con la stringa ’informatica’ senza
considerare maiuscole/minuscole.
*/

CREATE INDEX nome_index ON corsostudi(nome);
ANALYZE corsostudi;

EXPLAIN ANALYZE
SELECT cs.nome
FROM corsostudi cs
WHERE cs.nome ilike '%informatica'
-- .576
-- in questo caso l'indice creato non è stato utilizzato perchè la tabella era troppo piccola


/*
Esercizio 2
Visualizzare in nomi degli insegnamenti che iniziano per ’Teoria...’
*/
CREATE INDEX idx_nomeins ON insegn(nomeins);
ANALYZE insegn;

EXPLAIN ANALYZE
SELECT i.nomeins
FROM insegn i 
WHERE i.nomeins like 'Teoria%'
-- BASE: ex 3, planning 0.3
-- CON INDICE: ex .8 planning .2

DROP INDEX idx_annoaccademico


/*
Esercizio 3
Trovare, per ogni insegnamento erogato dell’a.a. 2013/2014, il suo nome e id della facoltà che lo
gestisce usando la relazione assorbita con facoltà
*/
CREATE INDEX idx_ins_annoaccademico ON inserogato(annoaccademico);
ANALYZE inserogato;
ANALYZE insegn;

EXPLAIN ANALYZE
SELECT i.nomeins, ins.id_facolta
FROM inserogato ins
	JOIN insegn i ON i.id = ins.id_insegn
WHERE ins.annoaccademico = '2013/2014'
-- ex 22.7, 6.6

/*
Esercizio 4
Visualizzare il codice, il nome e l’abbreviazione di tutti corsi di studio che nel nome contengono la
sottostringa ’lingue’ (eseguire un test case-insensitive: usare ILIKE invece di LIKE).
*/
CREATE INDEX idx_
ANALYZE corsostudi;

EXPLAIN ANALYZE
SELECT cs.codice, cs.nome, cs.abbreviazione
FROM corsostudi cs
WHERE cs.nome ilike '%lingue%'
-- Ex 1.3