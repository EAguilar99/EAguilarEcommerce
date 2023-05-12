CREATE TABLE "Usuario"
(
	"IdUsuario" INTEGER NOT NULL,
	"UserName" CHAR(50) NOT NULL,
	"Nombre" CHAR(50) NOT NULL,
	"ApellidoPaterno" CHAR(50) NOT NULL,
	"ApellidoMaterno" CHAR(50) NOT NULL,
	"FechaNacimiento" CHAR(50) NOT NULL,
	"Password" CHAR(20)	 NOT NULL,
	PRIMARY KEY("IdUsuario" AUTOINCREMENT)
)

INSERT INTO "Usuario"(UserName,Nombre,ApellidoPaterno,ApellidoMaterno, FechaNacimiento, Password)
VALUES("Dan","Eric","Aguilar","Hernandez","02/09/1999","contraseña")

