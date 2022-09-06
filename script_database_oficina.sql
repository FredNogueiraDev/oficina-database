SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;
-- -----------------------------------------------------
-- Table `mydb`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cliente` (
  `cpf` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `celular` VARCHAR(45) NOT NULL,
  `endereço` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cpf`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pedido` (
  `idpedido` INT NOT NULL,
  `cliente_cpf` INT NOT NULL,
  PRIMARY KEY (`idpedido`, `cliente_cpf`),
  INDEX `fk_pedido_cliente1_idx` (`cliente_cpf` ASC) VISIBLE,
  CONSTRAINT `fk_pedido_cliente1`
    FOREIGN KEY (`cliente_cpf`)
    REFERENCES `mydb`.`cliente` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`mecanico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`mecanico` (
  `idmecanico` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `endereço` VARCHAR(45) NOT NULL,
  `especializaçao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idmecanico`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`orçamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`orçamento` (
  `pedido_aprovado` ENUM('SIM', 'NAO') NOT NULL,
  `mecanico_idmecanico` INT NOT NULL,
  `pedido_idpedido` INT NOT NULL,
  `pedido_cliente_cpf` INT NOT NULL,
  PRIMARY KEY (`mecanico_idmecanico`, `pedido_idpedido`, `pedido_cliente_cpf`),
  INDEX `fk_orçamento_pedido1_idx` (`pedido_idpedido` ASC, `pedido_cliente_cpf` ASC) VISIBLE,
  CONSTRAINT `fk_orçamento_mecanico1`
    FOREIGN KEY (`mecanico_idmecanico`)
    REFERENCES `mydb`.`mecanico` (`idmecanico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orçamento_pedido1`
    FOREIGN KEY (`pedido_idpedido` , `pedido_cliente_cpf`)
    REFERENCES `mydb`.`pedido` (`idpedido` , `cliente_cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`revisao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`revisao` (
  `idrevisao` INT NOT NULL,
  `pedido_idpedido` INT NOT NULL,
  `pedido_cliente_cpf` INT NOT NULL,
  PRIMARY KEY (`idrevisao`),
  INDEX `fk_revisao_pedido1_idx` (`pedido_idpedido` ASC, `pedido_cliente_cpf` ASC) VISIBLE,
  CONSTRAINT `fk_revisao_pedido1`
    FOREIGN KEY (`pedido_idpedido` , `pedido_cliente_cpf`)
    REFERENCES `mydb`.`pedido` (`idpedido` , `cliente_cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`ordem_de_serviço`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ordem_de_serviço` (
  `idordem_de_serviço` INT NOT NULL,
  `serviço_executado` VARCHAR(45) NOT NULL,
  `data_emissao` DATE NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `data de entrega` VARCHAR(45) NOT NULL,
  `ordem_de_serviçocol` VARCHAR(45) NOT NULL,
  `orçamento_mecanico_idmecanico` INT NOT NULL,
  `orçamento_pedido_idpedido` INT NOT NULL,
  `orçamento_pedido_cliente_cpf` INT NOT NULL,
  PRIMARY KEY (`idordem_de_serviço`),
  INDEX `fk_ordem_de_serviço_orçamento1_idx` (`orçamento_mecanico_idmecanico` ASC, `orçamento_pedido_idpedido` ASC, `orçamento_pedido_cliente_cpf` ASC) VISIBLE,
  CONSTRAINT `fk_ordem_de_serviço_orçamento1`
    FOREIGN KEY (`orçamento_mecanico_idmecanico` , `orçamento_pedido_idpedido` , `orçamento_pedido_cliente_cpf`)
    REFERENCES `mydb`.`orçamento` (`mecanico_idmecanico` , `pedido_idpedido` , `pedido_cliente_cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`veiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`veiculo` (
  `placa` INT NOT NULL,
  `observaçao` VARCHAR(45) NULL,
  `cliente_cpf` INT NOT NULL,
  PRIMARY KEY (`placa`, `cliente_cpf`),
  INDEX `fk_veiculo_cliente_idx` (`cliente_cpf` ASC) VISIBLE,
  CONSTRAINT `fk_veiculo_cliente`
    FOREIGN KEY (`cliente_cpf`)
    REFERENCES `mydb`.`cliente` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`conserto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`conserto` (
  `idconserto` INT NOT NULL,
  `peças` VARCHAR(45) NOT NULL,
  `valor_peça` VARCHAR(45) NOT NULL,
  `valor_mao_de_obra` VARCHAR(45) NOT NULL,
  `observaçao` VARCHAR(45) NULL,
  `pedido_idpedido` INT NOT NULL,
  `pedido_cliente_cpf` INT NOT NULL,
  `veiculo_placa` INT NOT NULL,
  `veiculo_cliente_cpf` INT NOT NULL,
  PRIMARY KEY (`idconserto`),
  INDEX `fk_conserto_pedido1_idx` (`pedido_idpedido` ASC, `pedido_cliente_cpf` ASC) VISIBLE,
  INDEX `fk_conserto_veiculo1_idx` (`veiculo_placa` ASC, `veiculo_cliente_cpf` ASC) VISIBLE,
  CONSTRAINT `fk_conserto_pedido1`
    FOREIGN KEY (`pedido_idpedido` , `pedido_cliente_cpf`)
    REFERENCES `mydb`.`pedido` (`idpedido` , `cliente_cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_conserto_veiculo1`
    FOREIGN KEY (`veiculo_placa` , `veiculo_cliente_cpf`)
    REFERENCES `mydb`.`veiculo` (`placa` , `cliente_cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
