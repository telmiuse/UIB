Create database Cantina

create table USUARI (
	idUsuari 	int(10) AUTO_INCREMENT primary key,
	nomUsusari 	varchar(20) not null,
	textProfile	varchar(255),
	pass		varchar(6) not null,
	imgProfile	varchar(255),
	privacitat 	enum ('Privat','Public') default 'Public' 
);

create table MISSATGE(
	idMissatge 			int(10) AUTO_INCREMENT primary key,
	idUsusariEmisor 	int(10) not null,
	idUsusariReceptor 	int(10) not null,
	textMissatge 		varchar(255),
	Foreign key (idUsusariEmisor) references USUARI(idUsuari),
	Foreign key (idUsusariReceptor) references USUARI(idUsuari)
);

create table HISTORIA(
	idHistoria		int(10) AUTO_INCREMENT primary key,
	idUsuari 		int(10) not null,
	nomHistoria		varchar(255),
	Foreign key (idUsuari) references USUARI(idUsuari)
);

create table PUBLICACIO(
	idPub 			int(10) AUTO_INCREMENT primary key,
	idHistoria 		int(10) not null,
	idRevPub		int(10) not null,
	idUsuari 		int(10) not null,
	img 			varchar(255),
	textPubli		varchar(255),
	Foreign key (idHistoria) references HISTORIA(idHistoria),
	Foreign key (idRevPub) references PUBLICACIO(idPub),
	Foreign key (idUsuari) references USUARI(idUsuari)
);

create table COMENTARIO(
	idComent		int(10) AUTO_INCREMENT primary key,
	idPub 			int(10) not null,
	idUsuari        int(10) not null,
	textComent		varchar(255),
	dataComentari	Date not null,	
	Foreign key (idPub) references PUBLICACIO(idPub),
	Foreign key (idUsuari) references USUARI(idUsuari)
);

create table R_USUARI_USUARI(
	idUsuari int(10),
	idSeguidor int(10),
	primary key (idUsuari,idSeguidor),
	Foreign key (idUsuari) references USUARI(idUsuari),
	Foreign key (idSeguidor) references USUARI(idUsuari)
);