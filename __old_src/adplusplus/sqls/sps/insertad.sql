-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertad`(IN p_adkeywords VARCHAR(256),
                                                       IN p_adlink VARCHAR(1024),
                                                       IN p_adlinkdesc VARCHAR(1024))
BEGIN

-- split the adkeywords
DECLARE cur_position INT DEFAULT 1 ;
DECLARE remainder TEXT;
DECLARE cur_string VARCHAR(1000);
DECLARE cdelimiter CHAR(1);
DECLARE delimiter_length TINYINT UNSIGNED;

SET remainder = p_adkeywords;
SET cdelimiter = ',';
SET delimiter_length = CHAR_LENGTH(cdelimiter);

-- delete already existing entires (if any) for current link
DELETE FROM adppdb.ads WHERE adlink=TRIM(p_adlink);

-- extract each keyword from , delimted p_adkeywords and insert
WHILE CHAR_LENGTH(remainder) > 0 AND cur_position > 0 DO
    SET cur_position = INSTR(remainder, cdelimiter);
    
    IF cur_position = 0 THEN
        SET cur_string = remainder;
    ELSE
        SET cur_string = LEFT(remainder, cur_position - 1);
    END IF;

    IF TRIM(cur_string) != '' THEN
        -- insert this keyword for the ad link
        INSERT INTO `adppdb`.`ads` (`adlink`, `adkeyword`, `adlinkdesc`, `adcreatedate`, `adaccessdate`)
        VALUES (p_adlink, TRIM(cur_string), p_adlinkdesc, NOW(), NOW());
    END IF;

    SET remainder = SUBSTRING(remainder, cur_position + delimiter_length);
END WHILE;

END
