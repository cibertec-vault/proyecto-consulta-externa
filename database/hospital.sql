USE hospital;

DROP DATABASE IF EXISTS hospital;
CREATE DATABASE hospital;
USE hospital;

CREATE TABLE tipo_usuario (
    id_tipo_usuario                 INT                 NOT NULL PRIMARY KEY,
    descripcion                     VARCHAR(15)         NULL
);

CREATE TABLE usuario (
    id_usuario                      INT                 NOT NULL    AUTO_INCREMENT      PRIMARY KEY,
    usuario                         VARCHAR(5)          NULL,
    contrasena_usuario              VARCHAR(100)        NULL,
    id_tipo_usuario                 INT                 NULL,
    FOREIGN KEY(id_tipo_usuario)        REFERENCES tipo_usuario(id_tipo_usuario)
);

CREATE TABLE diagnostico(
    id_diagnostico                  CHAR(5)             NOT NULL    PRIMARY KEY,
    nombre_diagnostico              VARCHAR(80)         NULL,
    descripcion_diagnostico         VARCHAR(80)         NULL
);

CREATE TABLE distrito(
    id_distrito                     INT                 NOT NULL    PRIMARY KEY,
    iso_distrito                    VARCHAR(3)          NULL,
    descripcion_distrito            VARCHAR(80)         NULL
);

CREATE TABLE estado_cita (
    id_estado_cita                  CHAR(5)             NOT NULL    PRIMARY KEY,
    descripcion_estado_cita         VARCHAR(80)         NULL
);

CREATE TABLE tipo_cita (
    id_tipo_cita                    CHAR(5)             NOT NULL    PRIMARY KEY,
    descripcion_tipo_cita           VARCHAR(80)         NULL
);

CREATE TABLE estado_consultorio (
    id_estado_consultorio           CHAR(5)             NOT NULL    PRIMARY KEY,
    descripcion_estado_consultorio  VARCHAR(80)         NULL
);

CREATE TABLE consultorio (
    id_consultorio                  CHAR(5)             NOT NULL    PRIMARY KEY,
    descripcion_consultorio         VARCHAR(80)         NULL,
    id_estado_consultorio           CHAR(5)             NULL,
    FOREIGN KEY(id_estado_consultorio)  REFERENCES estado_consultorio(id_estado_consultorio)
);

CREATE TABLE especialidad (
    id_especialidad                 CHAR(5)             NOT NULL    PRIMARY KEY,
    descripcion_especialidad        VARCHAR(80)         NULL
);

CREATE TABLE estado_personal (
    id_estado_personal              INT		            NOT NULL    PRIMARY KEY,
    descripcion_estado_personal     VARCHAR(80)         NULL
);

CREATE TABLE personal (
    id_personal                     CHAR(5)             NOT NULL    PRIMARY KEY,
    nombre_personal                 VARCHAR(80)         NULL,
    telefono_personal               VARCHAR(20)         NULL,
    direccion_personal              VARCHAR(80)         NULL,
    email_personal                  VARCHAR(80)         NULL,
    telefono_emergencia             VARCHAR(20)         NULL,
    fecha_nacimiento                DATE                NULL,
    id_usuario                      INT                 NULL,
    id_especialidad                 CHAR(5)             NULL,
    id_estado_personal              INT		            NULL,
    FOREIGN KEY (id_especialidad)       REFERENCES especialidad (id_especialidad),
    FOREIGN KEY (id_estado_personal)    REFERENCES estado_personal (id_estado_personal),
    FOREIGN KEY (id_usuario)            REFERENCES usuario (id_usuario)
);

CREATE TABLE paciente (
    id_paciente                     CHAR(5)             NOT NULL    PRIMARY KEY,
    nombre_paciente                 VARCHAR(80)         NULL,
    apellidos_paciente              VARCHAR(80)         NULL,
    direccion_paciente              VARCHAR(80)         NULL,
    fecha_cumpleanos                DATE                NULL,
    fecha_muerte                    DATE                NULL        DEFAULT NULL,
    telefono_paciente               VARCHAR(20)         NULL,
    sexo_paciente                   VARCHAR(20)         NULL,
    talla_paciente                  FLOAT               NULL,
    peso_paciente                   FLOAT               NULL,
    clave_paciente                  VARCHAR(100)        NULL,
    id_distrito                     INT                 NULL,
    FOREIGN KEY (id_distrito)           REFERENCES distrito (id_distrito)
);

CREATE TABLE cita (
    id_cita                         CHAR(5)             NOT NULL    PRIMARY KEY,
    fecha_creacion                  DATE                NULL,
    id_paciente                     CHAR(5)             NULL,
    id_tipo_cita                    CHAR(5)             NULL,
    id_estado_cita                  CHAR(5)             NULL,
    id_consultorio                  CHAR(5)             NULL,
    id_personal                     CHAR(5)             NULL,
    FOREIGN KEY(id_paciente)            REFERENCES paciente(id_paciente),
    FOREIGN KEY(id_tipo_cita)           REFERENCES tipo_cita(id_tipo_cita),
    FOREIGN KEY(id_estado_cita)         REFERENCES estado_cita(id_estado_cita),
    FOREIGN KEY(id_consultorio)         REFERENCES consultorio(id_consultorio),
    FOREIGN KEY(id_personal)            REFERENCES personal(id_personal)
);

CREATE TABLE entrada_personal (
    id_entrada_personal             CHAR(5)             NOT NULL    PRIMARY KEY,
    hora_entrada                    VARCHAR(45)         NULL,
    fecha_entrada                   DATE                NULL,
    id_personal                     CHAR(5)             NULL,
    FOREIGN KEY(id_personal)            REFERENCES personal(id_personal)
);

CREATE TABLE estado_medicamento (
    id_estado_medicamento           CHAR(5)             NOT NULL    PRIMARY KEY,
    descripcion_estado_medicamento  VARCHAR(80)         NULL
);

CREATE TABLE excusa (
    id_excusa                       CHAR(5)             NOT NULL    PRIMARY KEY,
    descripcion_excusa              VARCHAR(80)         NULL,
    fecha_creacion                  DATE                NULL,
    id_paciente                     CHAR(5)             NULL,
    id_personal                     CHAR(5)             NULL,
    FOREIGN KEY(id_paciente)            REFERENCES paciente(id_paciente),
    FOREIGN KEY(id_personal)            REFERENCES personal(id_personal)
);

CREATE TABLE excusa_diagnostico (
    id_excusa                       CHAR(5)             NULL,
    id_diagnostico                  CHAR(5)             NULL,
    FOREIGN KEY (id_excusa)             REFERENCES excusa (id_excusa),
    FOREIGN KEY (id_diagnostico)        REFERENCES diagnostico (id_diagnostico)
);

CREATE TABLE formula (
    id_formula                      CHAR(5)             NOT NULL    PRIMARY KEY,
    id_paciente                     CHAR(5)             NULL,
    id_personal                     CHAR(5)             NULL,
    FOREIGN KEY (id_paciente)           REFERENCES paciente (id_paciente),
    FOREIGN KEY (id_personal)           REFERENCES personal (id_personal)
);

CREATE TABLE medicamento (
    id_medicamento                  CHAR(5)             NOT NULL    PRIMARY KEY,
    nombre_medicamento              VARCHAR(80)         NULL,
    marca_medicamento               VARCHAR(80)         NULL,
    id_estado_medicamento           CHAR(5)             NULL,
    FOREIGN KEY (id_estado_medicamento) REFERENCES estado_medicamento (id_estado_medicamento)
);


CREATE TABLE formula_medicamento (
    id_formula                      CHAR(5)             NULL,
    id_medicamento                  CHAR(5)             NULL,
    cantidad_medicamento_formula    INT                 NULL,
    FOREIGN KEY (id_formula)            REFERENCES formula (id_formula),
    FOREIGN KEY (id_medicamento)        REFERENCES medicamento (id_medicamento)
);

CREATE TABLE historia (
    id_historia                     CHAR(5)             NOT NULL    PRIMARY KEY,
    id_cita                         CHAR(5)             NULL,
    FOREIGN KEY (id_cita) REFERENCES cita (id_cita)
);

CREATE TABLE historia_diagnostico (
    id_historia                     CHAR(5)             NULL,
    id_diagnostico                  CHAR(5)             NULL,
    FOREIGN KEY (id_historia)           REFERENCES historia (id_historia),
    FOREIGN KEY (id_diagnostico)        REFERENCES diagnostico (id_diagnostico)
);

CREATE TABLE historia_personal (
    id_historia                     CHAR(5)             NULL,
    id_personal                     CHAR(5)             NULL,
    FOREIGN KEY (id_historia)           REFERENCES historia (id_historia),
    FOREIGN KEY (id_personal)           REFERENCES personal (id_personal)
);

CREATE TABLE presentacion (
    id_presentacion                 CHAR(5)             NOT NULL    PRIMARY KEY,
    nombre_presentacion             VARCHAR(80)         NULL,
    cantidad_presentacion           VARCHAR(80)         NULL
);


CREATE TABLE medicamento_presentacion (
    id_medicamento                  CHAR(5)             NULL,
    id_presentacion                 CHAR(5)             NULL,
    FOREIGN KEY (id_medicamento)        REFERENCES medicamento (id_medicamento),
    FOREIGN KEY (id_presentacion)       REFERENCES presentacion (id_presentacion)
);

CREATE TABLE proveedor (
    id_proveedor                    CHAR(5)             NOT NULL    PRIMARY KEY,
    nombre_proveedor                VARCHAR(80)         NULL,
    contacto_proveedor              VARCHAR(80)         NULL,
    direccion_proveedor             VARCHAR(80)         NULL,
    telefono_proveedor              VARCHAR(20)         NULL,
    email_proveedor                 VARCHAR(80)         NULL
);

CREATE TABLE medicamento_proveedor (
    id_medicamento_proveedor        CHAR(5)             NOT NULL    PRIMARY KEY,
    cantidad_medicamento            INT                 NULL,
    lote_medicamento                VARCHAR(80)         NULL,
    fecha_vencimiento               DATE                NULL,
    id_medicamento                  CHAR(5)             NULL,
    id_proveedor                    CHAR(5)             NULL,
    FOREIGN KEY (id_medicamento)        REFERENCES medicamento (id_medicamento),
    FOREIGN KEY (id_proveedor)          REFERENCES proveedor (id_proveedor)
);

CREATE TABLE salida_personal (
    id_salida_personal              CHAR(5)             NOT NULL    PRIMARY KEY,
    hora_salida                     VARCHAR(45)         NULL,
    fecha_salida                    DATE                NULL,
    id_personal                     CHAR(5)             NULL,
    FOREIGN KEY(id_personal)            REFERENCES personal (id_personal)
);

-- INSERT DATA - distrito

INSERT INTO distrito VALUES(1,'LIM', 'Cercado de Lima');
INSERT INTO distrito VALUES(2,'ATE', 'Ate');
INSERT INTO distrito VALUES(3,'BAR', 'Barranco');
INSERT INTO distrito VALUES(4,'BRE', 'Breña');
INSERT INTO distrito VALUES(5,'COM', 'Comas');
INSERT INTO distrito VALUES(6,'CHO', 'Chorrillos');
INSERT INTO distrito VALUES(7,'AGU', 'El Agustino');
INSERT INTO distrito VALUES(8,'JMA', 'Jesús María');
INSERT INTO distrito VALUES(9,'MOL', 'La Molina');
INSERT INTO distrito VALUES(10,'VIC', 'La Victoria');
INSERT INTO distrito VALUES(11,'LIN', 'Lince');
INSERT INTO distrito VALUES(12,'MAG', 'Magdalena del Mar');
INSERT INTO distrito VALUES(13,'MIR', 'Miraflores');
INSERT INTO distrito VALUES(14,'PLI', 'Pueblo Libre');
INSERT INTO distrito VALUES(15,'PPI', 'Puente Piedra');
INSERT INTO distrito VALUES(16,'RIM', 'Rimac');
INSERT INTO distrito VALUES(17,'ISI', 'San Isidro');
INSERT INTO distrito VALUES(18,'IND', 'Independencia');
INSERT INTO distrito VALUES(19,'SJM', 'San Juan de Miraflores');
INSERT INTO distrito VALUES(20,'SLU', 'San Luis');
INSERT INTO distrito VALUES(21,'SMP', 'San Martin de Porres');
INSERT INTO distrito VALUES(22,'SMI', 'San Miguel');
INSERT INTO distrito VALUES(23,'SDS', 'Santiago de Surco');
INSERT INTO distrito VALUES(24,'SUR', 'Surquillo');
INSERT INTO distrito VALUES(25,'VMT', 'Villa María del Triunfo');
INSERT INTO distrito VALUES(26,'SJL', 'San Juan de Lurigancho');
INSERT INTO distrito VALUES(27,'SRO', 'Santa Rosa');
INSERT INTO distrito VALUES(28,'OLI', 'Los Olivos');
INSERT INTO distrito VALUES(29,'SBO', 'San Borja');
INSERT INTO distrito VALUES(30,'VES', 'Villa El Savador');
INSERT INTO distrito VALUES(31,'SAN', 'Santa Anita');

-- INSERT DATA - estado_cita

INSERT INTO estado_cita VALUES(1,'creada');
INSERT INTO estado_cita VALUES(2,'confirmada');
INSERT INTO estado_cita VALUES(3,'atendida');
INSERT INTO estado_cita VALUES(5,'cancelada');
INSERT INTO estado_cita VALUES(4,'expirada');

--INSERT DATA - proveedor

INSERT INTO proveedor VALUES ('PRO01','Pepe','Medicamentos LULU','Petituars KM10.5','983123567','Pepe@gmail.com');
INSERT INTO proveedor VALUES ('PRO02','Luis','Centro de Medicina Forense',' Avenida V�ctor Andr�s Bela�nde., 147','923523522','Luis@gmail.com');
INSERT INTO proveedor VALUES ('PRO03','Jose','Alibaba','Jir�n Washington, 1080','098312312','Jose@gmail.com');
INSERT INTO proveedor VALUES ('PRO04','Ana','Medicamentos Importados SAC'     ,'psje cesar vallejo moche','984091724','Ana@gmail.com');
INSERT INTO proveedor VALUES ('PRO05','Patricio'  ,'Lulu Tons Pastillas A','Avenida Grimaldo Del Solar, 236, Tda.103','980918321','Patricio@gmail.com');
INSERT INTO proveedor VALUES ('PRO06','Maricarmen','Phone Town Past','Calle Donatello, 206','901832181','Maricarmen@gmail.com');
INSERT INTO proveedor VALUES ('PRO07','Jazmin','DirecX ','Gral. Prado N 869-873','909001293','Jazmin@gmail.com');
INSERT INTO proveedor VALUES ('PRO08','Erika','John and Jhonson','Calle Castilla La Vieja, 734, Of. 101','903812081','Erika@gmail.com');
INSERT INTO proveedor VALUES ('PRO09','Raul','Sinofarm','Avenida Intihuatana, 707','954964645','Raul@gmail.com');
INSERT INTO proveedor VALUES ('PRO10','Ubaldo','PepeCox Tomorw','Avenida Guardia Civil Sur, 1053, Edif. A Dpto.504','983012830','Ubaldo@gmail.com');












-- CREATING USER STORE PROCEDURES

CREATE PROCEDURE usp_listByPersonalState(id CHAR(5)) 
SELECT 	p.id_personal,
		p.nombre_personal,
        p.telefono_personal,
        p.direccion_personal,
        p.email_personal,
        p.telefono_emergencia,
        p.fecha_nacimiento,
        p.clave_personal,
        e.descripcion_especialidad,
        ep.descripcion_estado_personal
FROM personal p
INNER JOIN estado_personal ep
ON p.id_estado_personal = ep.id_estado_personal
INNER JOIN especialidad e
ON p.id_especialidad = e.id_especialidad
WHERE ep.id_estado_personal = id;

CREATE PROCEDURE usp_listBySpeciality(id CHAR(5)) 
SELECT 	p.id_personal,
		p.nombre_personal,
        p.telefono_personal,
        p.direccion_personal,
        p.email_personal,
        p.telefono_emergencia,
        p.fecha_nacimiento,
        p.clave_personal,
        e.descripcion_especialidad,
        ep.descripcion_estado_personal
FROM personal p
INNER JOIN estado_personal ep
ON p.id_estado_personal = ep.id_estado_personal
INNER JOIN especialidad e
ON p.id_especialidad = e.id_especialidad
WHERE ep.id_especialidad = id;

CREATE PROCEDURE usp_listPersonal() 
SELECT 	p.id_personal,
		p.nombre_personal,
        p.telefono_personal,
        p.direccion_personal,
        p.email_personal,
        p.telefono_emergencia,
        p.fecha_nacimiento,
        p.clave_personal,
        e.descripcion_especialidad,
        ep.descripcion_estado_personal
FROM personal p
INNER JOIN estado_personal ep
ON p.id_estado_personal = ep.id_estado_personal
INNER JOIN especialidad e
ON p.id_especialidad = e.id_especialidad;
-- INSERT DATA - tipo_usuario

INSERT INTO tipo_usuario VALUES(1,'Administrador');
INSERT INTO tipo_usuario VALUES(2,'Doctor/a');
INSERT INTO tipo_usuario VALUES(3,'Enfermera/o');

-- INSERT DATA - especialidad

INSERT INTO especialidad VALUES('ES001','CARDIÓLOGO');

-- INSERT DATA - estado_personal

INSERT INTO estado_personal VALUES(1,'contratado');


-- INSERT DATA - usuario

INSERT INTO usuario VALUES(1,'U0001','a4a97ffc170ec7ab32b85b2129c69c50',2);

-- INSERT DATA - personal

INSERT INTO personal VALUES('P0001', 'Dennis Villagaray','999999999', 'Av. simpre viva','demo@demo.com',null,'1999/12/12',null, 'ES001',1);
INSERT INTO personal VALUES('P0002', 'Demo ','999999999', 'Av. simpre viva','demo@demo.com',null,'1999/12/12',null, 'ES001',1);



-- --------------------- PROCEDURES --------------------- 


DELIMITER $$
CREATE PROCEDURE sp_register_usuario(userPersonal VARCHAR(5),userCode INT,newUser VARCHAR(5),newPassword VARCHAR(100), userType INT)
BEGIN
INSERT INTO usuario VALUES(userCode,newUser,newPassword,userType);
UPDATE personal
	SET
    id_usuario = userCode
    WHERE id_personal = userPersonal;    
END $$
DELIMITER ;

CREATE PROCEDURE sp_validate_usuario(user VARCHAR(5), pass VARCHAR(100))
    SELECT * FROM usuario WHERE usuario = user AND contrasena_usuario = pass;

-- END PROCEDURES



-- QUERY

SELECT SUBSTRING(MAX(usuario),2) FROM usuario;

CALL sp_validate_usuario('U0001','a4a97ffc170ec7ab32b85b2129c69c50');
select * from usuario;
select * from personal;

--PROCEDURE proveedor

drop procedure usp_listsupplier;
CREATE PROCEDURE usp_listsupplier()
select  p.id_proveedor,
p.nombre_proveedor,
p.contacto_proveedor,
p.direccion_proveedor,
p.telefono_proveedor,
p.email_proveedor
 from proveedor p;
 call usp_listsupplier();
select * from proveedor where nombre_proveedor like "%P%" ; -- EDITAR
-- INSERT DATA - proveedor
INSERT INTO proveedor VALUES ('PRO11','AAAAA','BBBBBBBBB','CCCCCCCCCCC','908109328','FFFFFFFF@gmail.com');
-- DELETE DATA - proveedor
delete from proveedor where id_proveedor= 'PRO11';
-- SEARCH DATA- proveedor
select  * from proveedor where id_proveedor = 'PRO01';
-- UPDATE DATA -proveedor
CREATE PROCEDURE usp_update(idp CHAR(5),namep VARCHAR(80),contactp VARCHAR(80),directp VARCHAR(80),phonep VARCHAR(20),emailp VARCHAR(80))
update proveedor set   nombre_proveedor= namep,contacto_proveedor=contactp,direccion_proveedor=directp,telefono_proveedor=phonep,email_proveedor=emailp
where id_proveedor= idp ;

call usp_update;

