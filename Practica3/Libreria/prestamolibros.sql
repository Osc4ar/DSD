

CREATE TABLE Libro (
  ISBN INT NOT NULL,
  Nombre VARCHAR(45) NULL,
  Autor VARCHAR(45) NULL,
  Editorial VARCHAR(45)  NULL,
  Precio DOUBLE NULL,
  Portada VARCHAR(45) NULL,
  PRIMARY KEY (ISBN))
;



CREATE TABLE Usuario (
  idUsuario INT NOT NULL,
  IP VARCHAR(45) NULL,
  PRIMARY KEY (idUsuario));


-- -----------------------------------------------------
-- Table `mydb`.`Sesión`
-- -----------------------------------------------------
CREATE TABLE sesion (
  idSesion INT NOT NULL,
  idUsuario INT NOT NULL,
  PRIMARY KEY (idSesion),
  FOREIGN KEY (idUsuario) REFERENCES
  Usuario (idUsuario)
  );
  

-- -----------------------------------------------------
-- Table `mydb`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE Pedido(
idPedido INT NOT NULL,
fecha DATE NOT NULL,
ISBN INT NOT NULL,
idUsuario INT NOT NULL,
idSesion INT NOT NULL,
PRIMARY KEY (IdPedido));


