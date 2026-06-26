/* 
ESERCIZIO 1
Scrivere il codice PostgreSQL che generi tutte le tabelle. Per gli attributi di cui non è
stato specificato il tipo, scegliere quello opportuno. Specificare tutti i vincoli possibili,
sia intra- sia inter-relazionali.

*/

CREATE DOMAIN giorniSettimana AS CHARACTER(3)
	CHECK(VALUE IN(
	'LUN',
	'MAR',
	'MER',
	'GIO',
	'VEN',
	'SAB',
	'DOM'
	));


CREATE TABLE Museo (
	nome CHARACTER VARYING(30) DEFAULT 'MuseoVeronese',
	citta CHARACTER VARYING(20) DEFAULT 'Verona',
		PRIMARY KEY(nome, citta),
	indirizzo CHARACTER VARYING(50),
	numeroTelefono CHARACTER VARYING(20),
	giornoChiusura giorniSettimana NOT NULL,
	prezzo NUMERIC NOT NULL DEFAULT 10

)

/*usato per eliminare la tabella precedente*/
DROP TABLE museo


CREATE TABLE opera(
	nome CHARACTER VARYING(30),
	cognomeAutore CHARACTER VARYING(20),
	nomeAutore CHARACTER VARYING(20),
		PRIMARY KEY(nome, cognomeAutore, nomeAutore),
	museo CHARACTER VARYING(30),
	citta CHARACTER VARYING(20),
		FOREIGN KEY(museo, citta)
		REFERENCES museo (nome, citta), --Tabella esterna di riferimento
	epoca CHARACTER VARYING(20),
	anno SMALLINT
)

DROP TABLE opera


CREATE TABLE mostra(
	titolo CHARACTER VARYING(30),
	inizio DATE,
		PRIMARY KEY(titolo, inizio),
	fine DATE NOT NULL,
	museo CHARACTER VARYING(30),
	citta CHARACTER VARYING(20),
		FOREIGN KEY(museo, citta)
		REFERENCES museo (nome, citta), --Tabella esterna di riferimento
	prezzo NUMERIC
)

DROP TABLE mostra


CREATE TABLE orario(
	progressivo INTEGER,
		PRIMARY KEY(progressivo),
	museo CHARACTER VARYING(30) NOT NULL,
	citta CHARACTER VARYING(20) NOT NULL,
		FOREIGN KEY(museo, citta)
		REFERENCES museo (nome, citta), --Tabella esterna di riferimento
	giorno giorniSettimana NOT NULL, 
	orarioApertura TIME WITH TIME ZONE DEFAULT '09:00 CET' ,
	orarioChiusura TIME WITH TIME ZONE DEFAULT '19:00 CET'
)

DROP TABLE orario



/*
ESERCIZIO 2
Inserire nell’entità Museo le seguenti tuple:
(Arena, Verona, piazza Bra, 045 8003204, martedì, 20),
(CastelVecchio, Verona, Corso Castelvecchio, 045 594734, lunedì, 15);
*/

INSERT INTO museo(nome, citta, indirizzo, numeroTelefono, giornoChiusura, prezzo)
VALUES ('Arena', 'Verona', 'piazza Bra', '045 8003204', 'MAR', 20)

INSERT INTO museo(nome, citta, indirizzo, numeroTelefono, giornoChiusura, prezzo)
VALUES ('CastelVecchio', 'Verona', 'Corso Castelvecchio', '045 594734', 'LUN', 15)

/*
Esercizio 3
Popolare le tabelle Opera e Mostra con almeno altre tre tuple ciascuna
*/

INSERT INTO opera(nome, cognomeAutore, nomeAutore, epoca, anno)
VALUES('Madonna della Quaglia', 'Pisanello', 'Antonio', 'Tardo Gotico', 1420)

INSERT INTO opera (nome, cognomeAutore, nomeAutore, museo, epoca, anno)
VALUES (
    'Sacra Famiglia con una santa', 'Mantegna', 'Andrea', 'Galleria d Arte Moderna', 'Rinascimento', 1495
);

INSERT INTO opera (nome, cognomeAutore, nomeAutore, epoca, anno)
VALUES (
    'Statua equestre di Cangrande I', 'Anonimo Veronese', 'Maestro', 'Medioevo', 1335
);

INSERT INTO mostra (titolo, inizio, fine, prezzo)
VALUES (
    'Il Rinascimento a Verona', '2026-04-01', '2026-07-31', 12.00
);

INSERT INTO mostra (titolo, inizio, fine, museo, prezzo)
VALUES (
    'Pisanello e il Gotico', '2026-09-15', '2027-01-10', 'Museo di Castelvecchio', 15.00
);

INSERT INTO mostra (titolo, inizio, fine)
VALUES (
    'Sculture Medievali Ritrovate', '2026-05-01', '2026-06-01'
);

/*
Esercizio 4
Provare ad inserire nella relazione Museo tuple che violino i vincoli specificati.
*/
INSERT INTO museo(nome, citta, indirizzo, numeroTelefono, giornoChiusura, prezzo)
VALUES ('Arena', 'Verona', 'piazza Bra', '045 8003204', 'MAR', 20)
--questo inserimento viola i vincoli per duplicazione di chiave

INSERT INTO museo(nome, citta, indirizzo, numeroTelefono, giornoChiusura, prezzo)
VALUES ('Colosseo', 'Roma', 'piazza Roma', '045 8003204', NULL, 20)
--questo viola il vincolo not null in giorno chiusura

/*
Esercizio 5
Nell’entità Museo, aggiungere l’attributo sitoInternet e inserire gli opportuni valori.
*/
ALTER TABLE museo ADD COLUMN sitoInternet CHARACTER VARYING(50) 

UPDATE museo
SET sitointernet = 'www.sitoInternet.it'
WHERE citta = 'Verona'


/*
Esercizio 6
Nell’entità Mostra modificare l’attributo prezzo in prezzoIntero ed aggiungere l’attributo
prezzoRidotto con valore di default 5. Aggiungere il vincolo (di tabella o di attributo?)
che garantisca che Mostra.prezzoRidotto sia minore di Mostra.prezzoIntero
*/
SELECT * 
FROM mostra

ALTER TABLE mostra RENAME COLUMN prezzo TO prezzo_intero
ALTER TABLE mostra ADD COLUMN prezzoRidotto NUMERIC
ALTER TABLE mostra ALTER COLUMN prezzoRidotto SET DEFAULT 5
ALTER TABLE mostra ADD CONSTRAINT check_prezzi CHECK (prezzoRidotto < prezzo_Intero);

/*
Esercizio 7
Nell’entità Museo aggiornare il prezzo aggiungendo 1 Euro alle tuple esistenti.
*/
UPDATE mostra
SET prezzo_intero = prezzo_intero +1
WHERE titolo is not null

/*
Esercizio 8
Nell’entità Mostra aggiornare il prezzoRidotto aumentandolo di 1 Euro per quelle
mostre che hanno prezzoIntero inferiore a 15 Euro.
*/

UPDATE mostra
SET prezzoridotto = 1
WHERE prezzo_intero < 15

/* 
Esercizio 9
Si assume che in ciascuna tabella della base di dati ci siano almeno 3 righe inserite.
Implementare le chiavi esportate per ciascuna delle 4 politiche di reazione presentate
nella pagina precedente (usare il comando DROP CONTRAINTS e ADD CONSTRAINTS
per effettuare il cambio di politica). Provare ad eseguire una cancellazione ed un
aggiornamento dei valori riferiti (e dei valori non riferiti) per verificare il diverso
comportamento del DBMS.
*/
ALTER TABLE opera DROP CONSTRAINT IF EXISTS opera_museo_fkey;


SELECT *
FROM orario

-- Popolare orario
INSERT INTO orario (progressivo, museo, citta, giorno)
VALUES (
    1, 
    'Arena', 
    'Verona', 
    'MAR' -- Giorno accettato dal tuo dominio
);

INSERT INTO orario (progressivo, museo, citta, giorno, orarioApertura, orarioChiusura)
VALUES (
    2, 
    'CastelVecchio', -- Attenzione alla V maiuscola!
    'Verona', 
    'MER', 
    '10:00 CET', -- Orario personalizzato
    '18:30 CET'  -- Orario personalizzato
);

INSERT INTO orario (progressivo, museo, citta, giorno)
VALUES (
    3, 
    'CastelVecchio', 
    'Verona', 
    'GIO'
);