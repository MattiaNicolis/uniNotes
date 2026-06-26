/***
Esercizio 1

Scrivere il codice PostgreSQL che generi tutte le tabelle. Per gli attributi di cui non è
stato specificato il tipo, scegliere quello opportuno. Specificare tutti i vincoli possibili,
sia intra- sia inter-relazionali

**/



CREATE TABLE Museo(
	nome CHARACTER VARYING(30) DEFAULT 'MuseoVeronese',
	citta CHARACTER VARYING(20) DEFAULT 'Verona',
		PRIMARY KEY(nome, citta),
	indirizzo CHARACTER VARYING(50),
	numeroTelefono CHARACTER VARYING(10),
	giornoChiusura giornoSettimana NOT NULL,
	prezzo INTEGER NOT NULL DEFAULT 10
)


DROP TABLE museo;
DROP TABLE mostra;
DROP TABLE orario;
DROP TABLE opera;

CREATE TABLE Opera(
	nome CHARACTER VARYING(30),
	cognomeAutore CHARACTER VARYING(20),
	nomeAutore CHARACTER VARYING(20),
		PRIMARY KEY(nome, cognomeAutore, nomeAutore),
	museo CHARACTER VARYING(30) DEFAULT 'MuseoVeronese',
	citta CHARACTER VARYING(20) DEFAULT 'Verona',
	FOREIGN KEY(museo, citta)
		REFERENCES Museo(nome, citta),
	epoca CHARACTER VARYING(50),
	anno SMALLINT
)	

CREATE TABLE Mostra(
	titolo CHARACTER VARYING(30),
	inizio DATE,
	PRIMARY KEY(titolo, inizio),
	fine DATE NOT NULL,
	museo CHARACTER VARYING(30) DEFAULT 'MuseoVeronese',
	citta CHARACTER VARYING(20) DEFAULT 'Verona',
	FOREIGN KEY(museo, citta)
		REFERENCES Museo(nome, citta),
	prezzo NUMERIC(10, 2)
)


CREATE TABLE Orario(
	progressivo INTEGER,
	museo CHARACTER VARYING(30) DEFAULT 'MuseoVeronese' NOT NULL,
	citta CHARACTER VARYING(20) DEFAULT 'Verona' NOT NULL,
	giorno giornoSettimana NOT NULL,  -- proporre un dominio
	orarioApertura TIME WITH TIME ZONE DEFAULT '09:00:00+01',
	orarioChiusura TIME WITH TIME ZONE DEFAULT '19:00:00+01'
)

/* Creazione del domininio*/
CREATE DOMAIN giornoSettimana as CHARACTER(3)
CHECK (VALUE IN (
	'LUN',
	'MAR',
	'MER',
	'GIO',
	'VEN',
	'SAB',
	'DOM'
));

DROP DOMAIN giornoSettimana


/* 
Esercizio 2
Inserire nell’entità Museo le seguenti tuple:
(Arena, Verona, piazza Bra, 045 8003204, martedì, 20),
(CastelVecchio, Verona, Corso Castelvecchio, 045 594734, lunedì, 15);
*/

INSERT INTO Museo(nome, citta, indirizzo, numeroTelefono, giornoChiusura, prezzo)
VALUES('Arena', 'Verona', 'piazza Bra', '0458003204', 'MAR', 20)

INSERT INTO Museo(nome, citta, indirizzo, numeroTelefono, giornoChiusura, prezzo)
VALUES('CastelVecchio', 'Verona', 'Corso Castelvecchio', '045594734', 'LUN', 15);

/*
Esercizio 3

Popolare le tabelle Opera e Mostra con almeno altre tre tuple ciascuna.
*/

INSERT INTO Opera(nome, cognomeAutore, nomeAutore, museo, citta, epoca, anno)
VALUES('La Notte Stellata', 'Van Gogh', 'Vincent', 'CastelVecchio', 'Verona', 'Post-impressionismo', 1889)
('Il Bacio', 'Klimt', 'Gustav', 'Arena', 'Verona', 'Art Nouveau', 1907)
('La Nascita di Venere', 'Botticelli', 'Sandro', 'CastelVecchio', 'Verona', 'Rinascimento', 1485)

INSERT INTO Mostra (titolo, inizio, fine, museo, citta, prezzo)
VALUES('Rinascimento Veneto', '2026-09-01', '2026-12-31', 'Arena', 'Verona', 15.50)
('Visioni Contemporanee', '2026-07-15', '2026-09-30', 'CastelVecchio', 'Verona', 12.00);


/*
Esercizio 4

Provare ad inserire nella relazione Museo tuple che violino i vincoli specificati.
*/
INSERT INTO Museo(nome, citta, indirizzo, numeroTelefono, giornoChiusura, prezzo)
VALUES('CastelVecchio', 'Verona', 'Corso Cavour', '045534734', 'GIO', 21);
-- non è soddisfatto il vincolo di unicità della chiave

/*
Esercizio 5

Nell’entità Museo, aggiungere l’attributo sitoInternet e inserire gli opportuni valori.
*/

ALTER TABLE Museo ADD COLUMN sitoInternet CHARACTER VARYING(30)

UPDATE Museo
SET sitointernet = 'wwww.arena.it'
WHERE nome = 'Arena'

UPDATE Museo
SET sitoInternet = 'wwww.castelVecchio.it'
WHERE nome = 'CastelVecchio'

/*
Esercizio 6

Nell’entità Mostra modificare l’attributo prezzo in prezzoIntero ed aggiungere l’attributo
prezzoRidotto con valore di default 5. Aggiungere il vincolo (di tabella o di attributo?)
che garantisca che Mostra.prezzoRidotto sia minore di Mostra.prezzoIntero
*/

ALTER TABLE Mostra rename prezzo to prezzoIntero
ALTER TABLE Mostra add column prezzoRidotto NUMERIC(10,2) DEFAULT 5
ALTER TABLE Mostra add constraint checkPrezzo CHECK(prezzoRidotto < PrezzoIntero)

/*
Esercizio 7

Nell’entità Museo aggiornare il prezzo aggiungendo 1 Euro alle tuple esistenti.
*/

Select * from mostra

UPDATE museo
SET prezzo = prezzo + 1

/* 
Esercizio 8

Nell’entità Mostra aggiornare il prezzoRidotto aumentandolo di 1 Euro per quelle
mostre che hanno prezzoIntero inferiore a 15 Euro.
*/

UPDATE mostra
SET prezzoRidotto = prezzoRidotto + 1
WHERE prezzointero <= 15

/*
Esercizio 9

Si assume che in ciascuna tabella della base di dati ci siano almeno 3 righe inserite.
Implementare le chiavi esportate per ciascuna delle 4 politiche di reazione presentate
nella pagina precedente (usare il comando DROP CONTRAINTS e ADD CONSTRAINTS
per effettuare il cambio di politica). Provare ad eseguire una cancellazione ed un
aggiornamento dei valori riferiti (e dei valori non riferiti) per verificare il diverso
comportamento del DBMS.
*/