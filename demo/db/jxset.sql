-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.5.16 - MySQL Community Server (GPL)
-- Server OS:                    Win32
-- HeidiSQL version:             7.0.0.4156
-- Date/time:                    2013-05-15 01:33:07
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;


-- Dumping structure for function jxset.f_date_unformat
DROP FUNCTION IF EXISTS `f_date_unformat`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `f_date_unformat`(vvalue varchar(20)) RETURNS date
BEGIN
  declare dpos, dpos_next tinyint;
  declare dyeari smallint;
  declare dday, dmonth, dyear char(4);

  if vvalue is null then
    return null;
  end if;

  set dpos = (SELECT LOCATE('/', vvalue));
  set dday = substr(vvalue, 1, dpos -1);
  set dpos_next = dpos + 1;
  set dpos = (SELECT LOCATE('/', vvalue, dpos_next));
  set dmonth = substr(vvalue, dpos_next, dpos - dpos_next);
  set dpos_next = dpos + 1;
  set dyear = substr(vvalue, dpos_next);
  if length(dyear) = 2 then
    set dyeari = cast(dyear as unsigned) + 2000;
    if dyeari > 2030 then
      set dyeari = dyeari - 100;
    end if;
    set dyear = cast(dyeari as char(4));
  end if;

  return cast(concat(dyear, '-', dmonth, '-', dday) as date);

END//
DELIMITER ;


-- Dumping structure for function jxset.f_insert_jset_atom
DROP FUNCTION IF EXISTS `f_insert_jset_atom`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `f_insert_jset_atom`(vkind tinyint, vweb_user varchar(45), vip varchar(45)) RETURNS bigint(20)
BEGIN
  DECLARE did BIGINT DEFAULT UUID_SHORT();

  INSERT INTO jset_atom (id, stamp, user, kind, web_user, ip)
    VALUES (did, NOW(), USER(), vkind, vweb_user, vip);

  RETURN did;
END//
DELIMITER ;


-- Dumping structure for function jxset.f_insert_jset_atom_no_uuid
DROP FUNCTION IF EXISTS `f_insert_jset_atom_no_uuid`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `f_insert_jset_atom_no_uuid`(vkind tinyint, vweb_user varchar(45), vip varchar(45)) RETURNS bigint(20)
BEGIN
  INSERT INTO jset_atom (id, stamp, user, kind, web_user, ip)
    VALUES (null, NOW(), USER(), vkind, vweb_user, vip);

  RETURN (SELECT LAST_INSERT_ID());
END//
DELIMITER ;


-- Dumping structure for function jxset.f_numeric_only
DROP FUNCTION IF EXISTS `f_numeric_only`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `f_numeric_only`(`str` VARCHAR(1000)) RETURNS varchar(1000) CHARSET utf8
    DETERMINISTIC
BEGIN
  DECLARE counter INT DEFAULT 0;
  DECLARE strLength INT DEFAULT 0;
  DECLARE strChar VARCHAR(1000) DEFAULT '' ;
  DECLARE retVal VARCHAR(1000) DEFAULT '';

  SET strLength = LENGTH(str);

  WHILE strLength > 0 DO
    SET counter = counter+1;
    SET strChar = SUBSTRING(str,counter,1);
    IF strChar REGEXP('[0-9]+') = 1
      THEN SET retVal = CONCAT(retVal,strChar);
    END IF;
    SET strLength = strLength -1;
    SET strChar = NULL;
  END WHILE;
RETURN if(retVal = '', null, retVal) ;
END//
DELIMITER ;


-- Dumping structure for function jxset.f_sql
DROP FUNCTION IF EXISTS `f_sql`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `f_sql`() RETURNS varchar(8000) CHARSET utf8
BEGIN
return 'select * from test';

END//
DELIMITER ;

DROP TABLE IF EXISTS `item`;
CREATE TABLE `item` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`what` SMALLINT(6) UNSIGNED NULL DEFAULT NULL,
	`name` VARCHAR(1024) NULL DEFAULT NULL,
	`text` TEXT NULL,
	`date` DATE NULL DEFAULT NULL,
	`image` VARCHAR(1024) NULL DEFAULT NULL,
	`video` VARCHAR(1024) NULL DEFAULT NULL,
	`integer` INT(11) NULL DEFAULT NULL,
	`decimal` DECIMAL(11,2) NULL DEFAULT NULL,
	`boolean` TINYINT(1) UNSIGNED NULL DEFAULT NULL,
	`link` VARCHAR(1024) NULL DEFAULT NULL,
	`html` MEDIUMTEXT NULL,
	`select` SMALLINT(6) UNSIGNED NULL DEFAULT NULL,
	`multicheckbox` VARCHAR(1024) NULL DEFAULT NULL,
	PRIMARY KEY (`id`),
	INDEX `Index_what` (`what`),
	INDEX `Index_name` (`name`),
	INDEX `Index_text` (`text`(1024)),	
	INDEX `Index_date` (`date`),
	INDEX `Index_image` (`image`),
	INDEX `Index_video` (`video`),
	INDEX `Index_integer` (`integer`),
	INDEX `Index_decimal` (`decimal`),
	INDEX `Index_boolean` (`boolean`),
	INDEX `Index_link` (`link`),
	INDEX `Index_html` (`html`(1024)),
	INDEX `Index_select` (`select`),
	INDEX `Index_multicheckbox` (`multicheckbox`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=1;

-- Dumping structure for table jxset.jset_atom
DROP TABLE IF EXISTS `jset_atom`;
CREATE TABLE IF NOT EXISTS `jset_atom` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `stamp` datetime NOT NULL,
  `user` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `kind` tinyint(3) unsigned DEFAULT NULL,
  `web_user` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `ip` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=94992943877718020 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=FIXED;

-- Dumping data for table jxset.jset_atom: ~4 rows (approximately)
DELETE FROM `jset_atom`;


-- Dumping structure for table jxset.jset_column
DROP TABLE IF EXISTS `jset_column`;
CREATE TABLE IF NOT EXISTS `jset_column` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent` int(10) unsigned NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `index` varchar(45) DEFAULT NULL,
  `title` varchar(45) DEFAULT NULL,
  `control` varchar(45) DEFAULT NULL,
  `hidden` tinyint(1) DEFAULT NULL,
  `readonly` tinyint(1) DEFAULT NULL,
  `edithidden` tinyint(1) unsigned DEFAULT NULL,
  `noedit` tinyint(1) unsigned DEFAULT NULL,
  `unsortable` tinyint(1) unsigned DEFAULT NULL,
  `position` smallint(5) DEFAULT NULL,
  `rowpos` tinyint(4) DEFAULT NULL,
  `rowlabel` varchar(200) DEFAULT NULL,
  `default_value` varchar(2000) DEFAULT NULL,
  `search_default` varchar(100) DEFAULT NULL,
  `width` varchar(20) DEFAULT NULL,
  `usize` varchar(20) DEFAULT NULL,
  `height` varchar(20) DEFAULT NULL,
  `list` varchar(4000) DEFAULT NULL,
  `src` varchar(200) DEFAULT NULL,
  `override` varchar(200) DEFAULT NULL,
  `help` varchar(2000) DEFAULT NULL,
  `validation` varchar(4000) DEFAULT NULL,
  `object` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `parent` (`parent`,`name`),
  CONSTRAINT `FK_jset_table_parent` FOREIGN KEY (`parent`) REFERENCES `jset_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=560 DEFAULT CHARSET=utf8;

-- Dumping data for table jxset.jset_column: ~71 rows (approximately)
DELETE FROM `jset_column`;
/*!40000 ALTER TABLE `jset_column` DISABLE KEYS */;
INSERT INTO `jset_column` (`id`, `parent`, `name`, `index`, `title`, `control`, `hidden`, `readonly`, `edithidden`, `noedit`, `unsortable`, `position`, `rowpos`, `rowlabel`, `default_value`, `search_default`, `width`, `usize`, `height`, `list`, `src`, `override`, `help`, `validation`, `object`) VALUES
	(17, 3, 'source', NULL, 'Source', 'textarea', 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '100', '8', 'v_source', NULL, NULL, 'The data source of this record.', NULL, NULL),
	(18, 3, 'target', NULL, 'Target', NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'v_target', NULL, NULL, 'The data target of this record.', NULL, NULL),
	(26, 4, 'parent', NULL, 'Parent', 'intexact', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(35, 3, 'help', 'help_table', 'Help', 'editor', 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Help about the jset_table grid as a whole. It is available by pressing the lamp button on the grid.', NULL, NULL),
	(36, 3, 'title', 'title_table', 'Title', NULL, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '40', NULL, NULL, NULL, NULL, 'The title of the grid using this record as it\'s source.', NULL, NULL),
	(37, 3, 'id', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(38, 3, 'name', NULL, 'Name', NULL, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '40', NULL, NULL, NULL, NULL, 'The name of this jset_table record.', NULL, NULL),
	(70, 3, 'description', NULL, 'Description', NULL, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '100', NULL, NULL, NULL, NULL, 'Description of this record, free text.', NULL, NULL),
	(128, 13, 'id', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(129, 13, 'parent', NULL, NULL, 'intexact', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(131, 13, 'help', NULL, 'Tip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(138, 13, 'field', NULL, 'Field', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(165, 19, 'id', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(166, 19, 'parent', NULL, NULL, 'intexact', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(167, 19, 'before_insert', NULL, 'Before Insert', NULL, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Php method(s) to execute before inserting a record. Methods are separated by the tilda (~) character.', NULL, NULL),
	(168, 19, 'after_insert', NULL, 'After Insert', NULL, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Php method(s) to execute after inserting a record. Methods are separated by the tilda (~) character.', NULL, NULL),
	(169, 19, 'before_select', NULL, 'Before Select', NULL, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Not in use.', NULL, NULL),
	(170, 19, 'after_select', NULL, 'After Select', NULL, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Not in use yet.', NULL, NULL),
	(171, 19, 'before_update', NULL, 'Before Update', NULL, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Php method(s) to execute before updating a record. Methods are separated by the tilda (~) character.', NULL, NULL),
	(172, 19, 'after_update', NULL, 'After Update', NULL, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Php method(s) to execute after updating a record. Methods are separated by the tilda (~) character.', NULL, NULL),
	(173, 19, 'before_delete', NULL, 'Before Delete', NULL, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Php method(s) to execute before deleting record(s). Methods are separated by the tilda (~) character.', NULL, NULL),
	(174, 19, 'after_delete', NULL, 'After Delete', NULL, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Php method(s) to execute after deleting record(s). Methods are separated by the tilda (~) character.', NULL, NULL),
	(180, 4, 'id', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(181, 4, 'name', NULL, 'Name', NULL, 0, 0, 0, 0, NULL, NULL, 10, NULL, NULL, NULL, NULL, '20', NULL, NULL, NULL, NULL, 'The name of this field. That should match the name of the field in the table or view.', NULL, NULL),
	(182, 4, 'index', NULL, 'Index', NULL, 0, 0, 0, 0, NULL, NULL, 10, NULL, NULL, NULL, NULL, '20', NULL, NULL, NULL, NULL, 'When we have more than one grid on a page and a field have the same name on different grids, use this attribute to set a different id for a field.', NULL, NULL),
	(183, 4, 'title', NULL, 'Title', NULL, 0, 0, 0, 0, NULL, NULL, 10, NULL, NULL, NULL, NULL, '20', NULL, NULL, NULL, NULL, 'The title of the field.', NULL, NULL),
	(184, 4, 'control', NULL, 'Control', NULL, 0, 0, 0, 0, NULL, NULL, 20, NULL, NULL, NULL, NULL, '20', NULL, NULL, NULL, NULL, 'The gui control for this field. The full list of available controls can be found in the file jset/jquery/js/jquery.jset.components.js.', NULL, NULL),
	(185, 4, 'hidden', NULL, 'Hidden', 'checkbox', 0, 0, 0, 0, NULL, NULL, 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Set to hide the field.', NULL, NULL),
	(186, 4, 'edithidden', NULL, 'Edit Hidden', 'checkbox', 0, 0, 0, 0, NULL, NULL, 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'In conjunction with the hidden attribute, let an hidden filed be editable in the form.', NULL, NULL),
	(187, 4, 'noedit', NULL, 'No Edit', 'checkbox', 0, 0, 0, 0, NULL, NULL, 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Set to hide the field in the form, but show the field in the grid.', NULL, NULL),
	(188, 4, 'list', NULL, 'List', 'textarea', 0, 0, 0, 0, 0, NULL, 20, NULL, NULL, NULL, NULL, '80', '4', NULL, NULL, NULL, 'For the selectbox control, specify the name of the table or view of the control items.', NULL, NULL),
	(189, 4, 'rowpos', NULL, 'Row Position', NULL, 0, 0, 0, 0, NULL, NULL, 40, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Specifying fields with the same rowpos will cause them to be displayed on the same row in the edit form.', NULL, NULL),
	(190, 4, 'rowlabel', NULL, 'Row Label', NULL, 0, 0, 0, 0, NULL, NULL, 40, NULL, NULL, NULL, NULL, '60', NULL, NULL, NULL, NULL, 'When using the rowpos attribute, this attribute sets the row lable.', NULL, NULL),
	(191, 4, 'position', NULL, 'Position', NULL, 0, 0, 0, 0, NULL, NULL, 40, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Control the order of the fields in the grid and in the form. By default fields are shown in the order of their appearance in the table/view of the source. The list is furthur ordered by the numbers in this attribute.', NULL, NULL),
	(192, 4, 'readonly', NULL, 'Read Only', 'checkbox', 0, 0, 0, 0, NULL, NULL, 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Sets a field to be readonly.', NULL, NULL),
	(193, 4, 'default_value', NULL, 'Default Value', NULL, 0, 0, 0, 0, NULL, NULL, 70, NULL, NULL, NULL, NULL, '100', NULL, NULL, NULL, NULL, 'The default value for this field when creating a new record.', NULL, NULL),
	(194, 4, 'search_default', NULL, 'Default Filter', NULL, 0, 0, 0, 0, NULL, NULL, 72, NULL, NULL, NULL, NULL, '100', NULL, NULL, NULL, NULL, 'The default filter for this field.', NULL, NULL),
	(195, 4, 'override', NULL, 'Override', NULL, 0, 0, 0, 0, 0, NULL, 75, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(196, 4, 'width', NULL, 'Column Width', NULL, 0, 0, 0, 0, NULL, NULL, 60, NULL, NULL, NULL, NULL, '10', NULL, NULL, NULL, NULL, 'The width of the field in grid view. Note that the width is relative to the other fields in the grid. The default width is 80. Specifying a number greater than 80 will increase the width and vise versa.', NULL, NULL),
	(197, 4, 'usize', NULL, 'Field Width', NULL, 0, 0, 0, 0, NULL, NULL, 60, NULL, NULL, NULL, NULL, '10', NULL, NULL, NULL, NULL, 'The width of the field in the edit form.', NULL, NULL),
	(198, 4, 'height', NULL, 'Field Height', NULL, 0, 0, 0, 0, NULL, NULL, 60, NULL, NULL, NULL, NULL, '10', NULL, NULL, NULL, NULL, 'The height of this field\'s control in the form.', NULL, NULL),
	(199, 4, 'src', NULL, 'Source Url', NULL, 0, 0, 0, 0, NULL, NULL, 20, NULL, NULL, NULL, NULL, '50', NULL, NULL, NULL, NULL, 'For the grid_frame control the url of the page to be shown.', NULL, NULL),
	(200, 4, 'help', NULL, 'Help', 'textarea', 0, 0, 0, 0, NULL, NULL, 90, NULL, NULL, NULL, NULL, '120', '4', NULL, NULL, NULL, 'The help text for this field. The text is shown in the edit and view forms when we mouse over the field\'s title.', NULL, NULL),
	(201, 4, 'validation', NULL, 'Validation', 'textarea', 0, 0, 0, 0, NULL, NULL, 80, NULL, NULL, NULL, NULL, '120', '4', NULL, NULL, NULL, 'Validation rules using the jquery validator plugin syntax.', NULL, NULL),
	(204, 20, 'active', NULL, 'Active', 'checkbox', 1, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(206, 20, 'host', NULL, 'Host', NULL, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '50', NULL, NULL, NULL, NULL, 'IP address or domain of the host.', NULL, NULL),
	(207, 20, 'id', NULL, NULL, NULL, 1, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(208, 20, 'name', NULL, 'Name', NULL, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '50', NULL, NULL, NULL, NULL, 'Name of the host, free text.', NULL, NULL),
	(209, 20, 'password', NULL, 'Password', 'password', 1, 0, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '50', NULL, NULL, NULL, NULL, 'Database user password.', NULL, NULL),
	(210, 20, 'user', NULL, 'User', NULL, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '50', NULL, NULL, NULL, NULL, 'Database user name.', NULL, NULL),
	(217, 20, 'db_name', NULL, 'Database', NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, '50', NULL, NULL, NULL, NULL, 'Database name.', NULL, NULL),
	(218, 3, 'system', NULL, 'System', 'checkbox', 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, '0', '30', NULL, NULL, NULL, NULL, NULL, 'If this is a system table, check it.', NULL, NULL),
	(227, 24, 'id', NULL, NULL, NULL, 0, 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(228, 24, 'name', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(229, 24, 'integer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(230, 24, 'boolean', NULL, 'Boolean', 'checkbox', 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(231, 24, 'text', NULL, NULL, 'textarea', 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, '50', '4', NULL, NULL, NULL, NULL, NULL, NULL),
	(232, 24, 'decimal', NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'required:true', NULL),
	(233, 24, 'picture', NULL, NULL, 'upload_image', 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(234, 24, 'select', NULL, NULL, 'selectbox', 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'v_list_control', NULL, NULL, NULL, NULL, NULL),
	(235, 24, 'video', NULL, NULL, 'upload_video', 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(236, 24, 'multiselect', NULL, NULL, 'multiselect', 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'v_list_control', NULL, NULL, NULL, NULL, NULL),
	(237, 24, 'date', NULL, NULL, 'date', 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(275, 4, 'unsortable', NULL, 'Unsortable', 'checkbox', 0, 0, 0, 0, NULL, NULL, 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Check this field if you wish this column to not be sortable.', NULL, NULL),
	(278, 4, 'object', NULL, 'Object', 'textarea', 0, 0, 0, 0, 0, NULL, 100, NULL, NULL, NULL, NULL, '120', '4', NULL, NULL, NULL, NULL, NULL, NULL),
	(279, 3, 'validation', NULL, 'Validation', 'textarea', 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, '100', '8', NULL, NULL, NULL, NULL, NULL, NULL),
	(552, 24, 'char', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(553, 24, 'image', NULL, NULL, 'upload_file', 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(554, 24, 'link', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(555, 24, 'html', NULL, NULL, 'editor', 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, '120', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(559, 24, 'multicheckbox', NULL, NULL, 'multicheckbox', 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'v_list_control', NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `jset_column` ENABLE KEYS */;


-- Dumping structure for table jxset.jset_default_column
DROP TABLE IF EXISTS `jset_default_column`;
CREATE TABLE IF NOT EXISTS `jset_default_column` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Type` varchar(100) DEFAULT NULL,
  `Collation` varchar(100) DEFAULT NULL,
  `Null` varchar(100) DEFAULT NULL,
  `Key` varchar(100) DEFAULT NULL,
  `Default` varchar(100) DEFAULT NULL,
  `Extra` varchar(100) DEFAULT NULL,
  `Privileges` varchar(100) DEFAULT NULL,
  `Comment` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Dumping data for table jxset.jset_default_column: ~1 rows (approximately)
DELETE FROM `jset_default_column`;
/*!40000 ALTER TABLE `jset_default_column` DISABLE KEYS */;
INSERT INTO `jset_default_column` (`id`, `Type`, `Collation`, `Null`, `Key`, `Default`, `Extra`, `Privileges`, `Comment`) VALUES
	(1, 'varchar', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `jset_default_column` ENABLE KEYS */;


-- Dumping structure for table jxset.jset_error
DROP TABLE IF EXISTS `jset_error`;
CREATE TABLE IF NOT EXISTS `jset_error` (
  `id` bigint(20) NOT NULL,
  `message` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `query` varchar(4000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `params` varchar(8000) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table jxset.jset_error: ~4 rows (approximately)
DELETE FROM `jset_error`;

-- Dumping structure for table jxset.jset_event
DROP TABLE IF EXISTS `jset_event`;
CREATE TABLE IF NOT EXISTS `jset_event` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent` int(10) unsigned NOT NULL,
  `before_insert` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
  `after_insert` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
  `before_select` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
  `after_select` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
  `before_update` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
  `after_update` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
  `before_delete` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
  `after_delete` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `parent` (`parent`) USING BTREE,
  CONSTRAINT `FK_jset_event_parent` FOREIGN KEY (`parent`) REFERENCES `jset_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table jxset.jset_event: ~1 rows (approximately)
DELETE FROM `jset_event`;
/*!40000 ALTER TABLE `jset_event` DISABLE KEYS */;


-- Dumping structure for table jxset.jset_host
DROP TABLE IF EXISTS `jset_host`;
CREATE TABLE IF NOT EXISTS `jset_host` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `active` tinyint(4) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `host` varchar(100) DEFAULT NULL,
  `port` varchar(50) DEFAULT NULL,
  `server` varchar(100) DEFAULT NULL,
  `db_name` varchar(45) DEFAULT NULL,
  `user` varchar(40) DEFAULT NULL,
  `password` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- Dumping data for table jxset.jset_host: ~3 rows (approximately)
DELETE FROM `jset_host`;
/*!40000 ALTER TABLE `jset_host` DISABLE KEYS */;


-- Dumping structure for table jxset.jset_layout
DROP TABLE IF EXISTS `jset_layout`;
CREATE TABLE IF NOT EXISTS `jset_layout` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent` int(10) unsigned DEFAULT NULL,
  `name` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `pos` tinyint(3) unsigned DEFAULT NULL,
  `prefix` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `suffix` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table jxset.jset_layout: ~0 rows (approximately)
DELETE FROM `jset_layout`;
/*!40000 ALTER TABLE `jset_layout` DISABLE KEYS */;
/*!40000 ALTER TABLE `jset_layout` ENABLE KEYS */;


-- Dumping structure for table jxset.jset_list
DROP TABLE IF EXISTS `jset_list`;
CREATE TABLE IF NOT EXISTS `jset_list` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tid` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(45) NOT NULL,
  `type` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Index_type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

-- Dumping data for table jxset.jset_list: ~38 rows (approximately)
DELETE FROM `jset_list`;
/*!40000 ALTER TABLE `jset_list` DISABLE KEYS */;
INSERT INTO `jset_list` (`id`, `tid`, `name`, `type`) VALUES
	(1, 1, 'select', 'control'),
	(2, 2, 'checkbox', 'control'),
	(3, 3, 'currency', 'control'),
	(4, 4, 'upload', 'control'),
	(5, 5, 'editor', 'control'),
	(6, 2000, '2000', 'xyear'),
	(7, 2001, '2001', 'xyear'),
	(8, 2002, '2002', 'xyear'),
	(9, 2003, '2003', 'xyear'),
	(10, 2004, '2004', 'xyear'),
	(11, 2005, '2005', 'xyear'),
	(12, 2006, '2006', 'xyear'),
	(13, 2007, '2007', 'xyear'),
	(14, 2008, '2008', 'xyear'),
	(15, 2009, '2009', 'xyear'),
	(16, 2010, '2010', 'xyear'),
	(17, 2011, '2011', 'xyear'),
	(18, 2012, '2012', 'xyear'),
	(19, 2013, '2013', 'xyear'),
	(20, 2014, '2014', 'xyear'),
	(21, 2015, '2015', 'xyear'),
	(22, 2016, '2016', 'xyear'),
	(23, 2017, '2017', 'xyear'),
	(24, 2018, '2018', 'xyear'),
	(25, 2019, '2019', 'xyear'),
	(26, 2020, '2020', 'xyear'),
	(27, 1, '1', 'xmonth'),
	(28, 2, '2', 'xmonth'),
	(29, 3, '3', 'xmonth'),
	(30, 4, '4', 'xmonth'),
	(31, 5, '5', 'xmonth'),
	(32, 6, '6', 'xmonth'),
	(33, 7, '7', 'xmonth'),
	(34, 8, '8', 'xmonth'),
	(35, 9, '9', 'xmonth'),
	(36, 10, '10', 'xmonth'),
	(37, 11, '11', 'xmonth'),
	(38, 12, '12', 'xmonth');
/*!40000 ALTER TABLE `jset_list` ENABLE KEYS */;


-- Dumping structure for table jxset.jset_semaphore
DROP TABLE IF EXISTS `jset_semaphore`;
CREATE TABLE IF NOT EXISTS `jset_semaphore` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `stamp_start` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `stamp_end` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table jxset.jset_semaphore: ~0 rows (approximately)
DELETE FROM `jset_semaphore`;
/*!40000 ALTER TABLE `jset_semaphore` DISABLE KEYS */;
/*!40000 ALTER TABLE `jset_semaphore` ENABLE KEYS */;


-- Dumping structure for table jxset.jset_sql
DROP TABLE IF EXISTS `jset_sql`;
CREATE TABLE IF NOT EXISTS `jset_sql` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sql` varchar(8000) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table jxset.jset_sql: ~0 rows (approximately)
DELETE FROM `jset_sql`;
/*!40000 ALTER TABLE `jset_sql` DISABLE KEYS */;
/*!40000 ALTER TABLE `jset_sql` ENABLE KEYS */;


-- Dumping structure for table jxset.jset_table
DROP TABLE IF EXISTS `jset_table`;
CREATE TABLE IF NOT EXISTS `jset_table` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `source` varchar(4000) DEFAULT NULL,
  `target` varchar(100) DEFAULT NULL,
  `help` text,
  `validation` varchar(8000) DEFAULT NULL,
  `system` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- Dumping data for table jxset.jset_table: ~6 rows (approximately)
DELETE FROM `jset_table`;
/*!40000 ALTER TABLE `jset_table` DISABLE KEYS */;
INSERT INTO `jset_table` (`id`, `name`, `description`, `title`, `source`, `target`, `help`, `validation`, `system`) VALUES
	(3, 'jset_table', 'Manage grid definition', 'Tables', 'jset_table', 'jset_table', '<div>This grid let you define data objects to be used by grids in an application.</div>', NULL, 1),
	(4, 'jset_column', NULL, 'Columns', 'jset_column', 'jset_column', 'This grid let you define attributes for each field in a grid. Help on each attribute\'s meaning is available in edit and view modes by moving the mouse over an attribute name.', NULL, 1),
	(13, 'jset_help', NULL, 'Help Tips', 'v_jset_help', 'jset_column', NULL, NULL, 1),
	(19, 'jset_event', NULL, 'Events', 'jset_event', 'jset_event', 'This grid let you define events for a grid.<br />An event is a php method that can be set to run on the following situations:<br /><br />before insert<br />after insert<br />before select<br />after select<br />before update<br />after update<br />before delete<br />after delete<br /><br />', NULL, 1),
	(20, 'jset_host', NULL, 'Hosts', 'jset_host', 'jset_host', 'This grid let you define credentials for accessing projects.', NULL, 1),
	(24, 'demo', NULL, NULL, 'demo', 'demo', '<div>&nbsp;</div>', NULL, 0);
/*!40000 ALTER TABLE `jset_table` ENABLE KEYS */;


-- Dumping structure for table jxset.jset_upload
DROP TABLE IF EXISTS `jset_upload`;
CREATE TABLE IF NOT EXISTS `jset_upload` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table jxset.jset_upload: ~0 rows (approximately)
DELETE FROM `jset_upload`;
/*!40000 ALTER TABLE `jset_upload` DISABLE KEYS */;
/*!40000 ALTER TABLE `jset_upload` ENABLE KEYS */;

-- Dumping structure for procedure jxset.p_copy_jset_columns
DROP PROCEDURE IF EXISTS `p_copy_jset_columns`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_copy_jset_columns`(vsource varchar(45), vtarget varchar(45))
BEGIN
  declare did int;

  insert into jset_table (name, source, target) values(vtarget, vtarget, vtarget);
  set did = (select LAST_INSERT_ID());

  insert into jset_column (`parent`, `name`, `index`, `title`, `control`, `hidden`, `edithidden`, `noedit`, `list`, `rowpos`, `rowlabel`, `position`, `readonly`, `default_value`, `search_default`, `override`, `width`, `usize`, `height`, `src`)
  select did, `name`, `index`, `title`, `control`, `hidden`, `edithidden`, `noedit`, `list`, `rowpos`, `rowlabel`, `position`, `readonly`, `default_value`, `search_default`, `override`, `width`, `usize`, `height`, `src`
  from jset_column where parent = (select id from jset_table where name = vsource);

  select did as id;
END//
DELIMITER ;


-- Dumping structure for procedure jxset.p_execute
DROP PROCEDURE IF EXISTS `p_execute`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_execute`(vsql varchar(8000))
BEGIN
SET @s = vsql;
PREPARE s from @s;
EXECUTE s;
DEALLOCATE PREPARE s;

END//
DELIMITER ;


-- Dumping structure for procedure jxset.p_set_jset_semaphore
DROP PROCEDURE IF EXISTS `p_set_jset_semaphore`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_set_jset_semaphore`(vname varchar(45), vvalue tinyint)
BEGIN
declare dfalg tinyint;
declare did int;
declare dend timestamp;

select id, `stamp_end` into did, dend from jset_semaphore where `name` = vname order by id desc limit 1;

IF vvalue = 1 THEN
  if dend is not null or did is null then
    insert into jset_semaphore (`name`) values (vname);
    select 1 as result;
  else
    select 0 as result;
  end if;
ELSE
  if did is not null and dend is null then
    update jset_semaphore set `stamp_end` = now() where id = did;
    select 1 as result;
  else
    select 0 as result;
  end if;
end if;

END//
DELIMITER ;


-- Dumping structure for view jxset.v_databases
DROP VIEW IF EXISTS `v_databases`;
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `v_databases` (
	`databases` VARCHAR(64) NOT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;


-- Dumping structure for view jxset.v_jset_help
DROP VIEW IF EXISTS `v_jset_help`;
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `v_jset_help` (
	`id` INT(10) UNSIGNED NOT NULL,
	`parent` INT(10) UNSIGNED NOT NULL,
	`field` VARCHAR(45) NULL COLLATE 'utf8_general_ci',
	`help` VARCHAR(2000) NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;


-- Dumping structure for view jxset.v_jset_table
DROP VIEW IF EXISTS `v_jset_table`;
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `v_jset_table` (
	`id` INT(10) UNSIGNED NOT NULL,
	`name` VARCHAR(100) NULL COLLATE 'utf8_general_ci',
	`description` VARCHAR(200) NULL COLLATE 'utf8_general_ci',
	`title` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`source` VARCHAR(4000) NULL COLLATE 'utf8_general_ci',
	`target` VARCHAR(100) NULL COLLATE 'utf8_general_ci',
	`help` TEXT NULL COLLATE 'utf8_general_ci',
	`columns` INT(10) UNSIGNED NOT NULL,
	`events` INT(10) UNSIGNED NOT NULL
) ENGINE=MyISAM;


-- Dumping structure for view jxset.v_jset_table_name
DROP VIEW IF EXISTS `v_jset_table_name`;
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `v_jset_table_name` (
	`id` INT(10) UNSIGNED NOT NULL,
	`name` VARCHAR(100) NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;


-- Dumping structure for view jxset.v_list_control
DROP VIEW IF EXISTS `v_list_control`;
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `v_list_control` (
	`id` INT(10) UNSIGNED NOT NULL,
	`name` VARCHAR(45) NOT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;


-- Dumping structure for view jxset.v_source
DROP VIEW IF EXISTS `v_source`;
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `v_source` (
	`id` VARCHAR(64) NOT NULL COLLATE 'utf8_general_ci',
	`name` VARCHAR(64) NOT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;


-- Dumping structure for view jxset.v_tables
DROP VIEW IF EXISTS `v_tables`;
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `v_tables` (
	`TABLE_NAME` VARCHAR(64) NOT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;


-- Dumping structure for view jxset.v_target
DROP VIEW IF EXISTS `v_target`;
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `v_target` (
	`id` VARCHAR(64) NOT NULL COLLATE 'utf8_general_ci',
	`name` VARCHAR(64) NOT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;


-- Dumping structure for view jxset.v_xmonth
DROP VIEW IF EXISTS `v_xmonth`;
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `v_xmonth` (
	`id` INT(10) UNSIGNED NOT NULL,
	`name` VARCHAR(45) NOT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;


-- Dumping structure for view jxset.v_xyear
DROP VIEW IF EXISTS `v_xyear`;
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `v_xyear` (
	`id` INT(10) UNSIGNED NOT NULL,
	`name` VARCHAR(45) NOT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;


-- Dumping structure for view jxset.v_databases
DROP VIEW IF EXISTS `v_databases`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_databases`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `v_databases` AS select `schemata`.`SCHEMA_NAME` AS `databases` from `information_schema`.`schemata` order by `schemata`.`SCHEMA_NAME` ;


-- Dumping structure for view jxset.v_jset_help
DROP VIEW IF EXISTS `v_jset_help`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_jset_help`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `v_jset_help` AS select `jset_column`.`id` AS `id`,`jset_column`.`parent` AS `parent`,if((`jset_column`.`title` is not null),`jset_column`.`title`,`jset_column`.`name`) AS `field`,`jset_column`.`help` AS `help` from `jset_column` where ((isnull(`jset_column`.`hidden`) and isnull(`jset_column`.`noedit`)) or `jset_column`.`edithidden`) ;


-- Dumping structure for view jxset.v_jset_table
DROP VIEW IF EXISTS `v_jset_table`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_jset_table`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `v_jset_table` AS select `jset_table`.`id` AS `id`,`jset_table`.`name` AS `name`,`jset_table`.`description` AS `description`,`jset_table`.`title` AS `title`,`jset_table`.`source` AS `source`,`jset_table`.`target` AS `target`,`jset_table`.`help` AS `help`,`jset_table`.`id` AS `columns`,`jset_table`.`id` AS `events` from `jset_table` ;


-- Dumping structure for view jxset.v_jset_table_name
DROP VIEW IF EXISTS `v_jset_table_name`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_jset_table_name`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `v_jset_table_name` AS select `jset_table`.`id` AS `id`,`jset_table`.`name` AS `name` from `jset_table` ;


-- Dumping structure for view jxset.v_list_control
DROP VIEW IF EXISTS `v_list_control`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_list_control`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `v_list_control` AS select tid as id, name from jset_list where `type` = 'control' ;


-- Dumping structure for view jxset.v_source
DROP VIEW IF EXISTS `v_source`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_source`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `v_source` AS select `tables`.`TABLE_NAME` AS `id`,`tables`.`TABLE_NAME` AS `name` from `information_schema`.`tables` where (`tables`.`TABLE_SCHEMA` = database()) ;


-- Dumping structure for view jxset.v_tables
DROP VIEW IF EXISTS `v_tables`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_tables`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `v_tables` AS select `tables`.`TABLE_NAME` AS `TABLE_NAME` from `information_schema`.`tables` where (`tables`.`TABLE_SCHEMA` = database()) ;


-- Dumping structure for view jxset.v_target
DROP VIEW IF EXISTS `v_target`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_target`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `v_target` AS select `tables`.`TABLE_NAME` AS `id`,`tables`.`TABLE_NAME` AS `name` from `information_schema`.`tables` where ((`tables`.`TABLE_SCHEMA` = database()) and (`tables`.`TABLE_TYPE` = 'BASE TABLE')) ;


-- Dumping structure for view jxset.v_xmonth
DROP VIEW IF EXISTS `v_xmonth`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_xmonth`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `v_xmonth` AS select `jset_list`.`tid` AS `id`,`jset_list`.`name` AS `name` from `jset_list` where (`jset_list`.`type` = _utf8'xmonth') order by `jset_list`.`tid` ;


-- Dumping structure for view jxset.v_xyear
DROP VIEW IF EXISTS `v_xyear`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_xyear`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `v_xyear` AS select `jset_list`.`tid` AS `id`,`jset_list`.`name` AS `name` from `jset_list` where (`jset_list`.`type` = _utf8'xyear') order by `jset_list`.`tid` ;
/*!40014 SET FOREIGN_KEY_CHECKS=1 */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
