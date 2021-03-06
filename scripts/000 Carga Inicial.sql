CREATE TABLE `farmaceuticos` (
	`far_id` INT(11) NOT NULL AUTO_INCREMENT,
	`far_nome` VARCHAR(100) NOT NULL DEFAULT '0' COLLATE 'latin1_swedish_ci',
	PRIMARY KEY (`far_id`) USING BTREE
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;

CREATE TABLE `pacientes` (
	`pac_id` INT(11) NOT NULL AUTO_INCREMENT,
	`pac_nome` VARCHAR(100) NOT NULL DEFAULT '0' COLLATE 'latin1_swedish_ci',
	PRIMARY KEY (`pac_id`) USING BTREE
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;

CREATE TABLE `tipos` (
	`tip_id` INT(11) NOT NULL AUTO_INCREMENT,
	`tip_descricao` VARCHAR(50) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`tip_valor` DECIMAL(10,2) NULL DEFAULT NULL,
	PRIMARY KEY (`tip_id`) USING BTREE
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;

CREATE TABLE `servicos` (
	`ser_id` INT(11) NOT NULL AUTO_INCREMENT,
	`far_id_fk` INT(11) NULL DEFAULT NULL,
	`pac_id_fk` INT(11) NULL DEFAULT NULL,
	`ser_obs` TEXT NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`ser_valor_total` DECIMAL(10,2) NULL DEFAULT NULL,
	PRIMARY KEY (`ser_id`) USING BTREE,
	INDEX `FK_servicos_farmaceuticos` (`far_id_fk`) USING BTREE,
	INDEX `FK_servicos_pacientes` (`pac_id_fk`) USING BTREE,
	CONSTRAINT `FK_servicos_farmaceuticos` FOREIGN KEY (`far_id_fk`) REFERENCES `tools`.`farmaceuticos` (`far_id`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT `FK_servicos_pacientes` FOREIGN KEY (`pac_id_fk`) REFERENCES `tools`.`pacientes` (`pac_id`) ON UPDATE NO ACTION ON DELETE NO ACTION
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;

CREATE TABLE `servicos_itens` (
	`sit_id` INT(11) NOT NULL,
	`ser_id_fk` INT(11) NOT NULL DEFAULT '0',
	`tip_id_fk` INT(11) NOT NULL DEFAULT '0',
	`sit_valor` DECIMAL(10,2) NOT NULL DEFAULT '0.00',
	PRIMARY KEY (`sit_id`, `ser_id_fk`) USING BTREE,
	INDEX `FK_servicos_itens_servicos` (`ser_id_fk`) USING BTREE,
	INDEX `FK_servicos_itens_tipos` (`tip_id_fk`) USING BTREE,
	CONSTRAINT `FK_servicos_itens_servicos` FOREIGN KEY (`ser_id_fk`) REFERENCES `tools`.`servicos` (`ser_id`) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT `FK_servicos_itens_tipos` FOREIGN KEY (`tip_id_fk`) REFERENCES `tools`.`tipos` (`tip_id`) ON UPDATE NO ACTION ON DELETE NO ACTION
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;

INSERT INTO tipos (tip_descricao, tip_valor) VALUES ('ATEN????O FARMAC??UTICA DOMICILIAR', 5);
INSERT INTO tipos (tip_descricao, tip_valor) VALUES ('AFERI????O DE PRESS??O ARTERIAL', 0.5);
INSERT INTO tipos (tip_descricao, tip_valor) VALUES ('AFERI????O DE TEMPERATURA CORPORAL', 0.5);
INSERT INTO tipos (tip_descricao, tip_valor) VALUES ('AFERI????O DE GLICEMIA CAPILAR', .75);
INSERT INTO tipos (tip_descricao, tip_valor) VALUES ('ADMINISTRA????O DE MEDICAMENTOS - INALA????O', 1);
INSERT INTO tipos (tip_descricao, tip_valor) VALUES ('ADMINISTRA????O DE MEDICAMENTOS - INJET??VEL', 1.25);

