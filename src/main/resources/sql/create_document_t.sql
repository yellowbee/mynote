DROP TABLE IF EXISTS `document_t`;

CREATE TABLE `document_t` (
    `id` INT NOT NULL auto_increment,
    `doc_name` VARCHAR(50),
    `parent_id` INT DEFAULT NULL ,
    PRIMARY KEY (`id`),
    CONSTRAINT `FK_DOC` FOREIGN KEY (`parent_id`) REFERENCES `document_t` (`id`)
) ENGINE=InnoDB;