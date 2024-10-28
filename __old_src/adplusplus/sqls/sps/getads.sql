-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getads`(IN docText TEXT, IN numAds INT)
    READS SQL DATA
BEGIN

-- get all keyword/phrase matches into a temp table 
DROP TABLE IF EXISTS temptable_all_matches; 
CREATE TEMPORARY TABLE temptable_all_matches
SELECT adid, adkeyword, adlink, adlinkdesc, MATCH (adkeyword) AGAINST (docText in boolean mode) AS matchscore, adaccessdate
FROM adppdb.ads 
WHERE MATCH (adkeyword) AGAINST (docText in boolean mode) 
order by matchscore desc, adaccessdate asc;

-- check if the rowcount is < 10
IF FOUND_ROWS() < numAds THEN
    -- update the main table to reflect the last accessed date for these ads
    update adppdb.ads set adaccessdate=NOW() where adid in (select adid from temptable_all_matches);
    
    select adid, adkeyword, adlink, adlinkdesc, matchscore, adaccessdate from temptable_all_matches;
ELSE    
    -- if > 10 return only unique links
    DROP TABLE IF EXISTS temptable_top_matches; 
    CREATE TEMPORARY TABLE temptable_top_matches
    SELECT adid, adkeyword, adlink, adlinkdesc, matchscore, adaccessdate
    FROM temptable_all_matches
    group by adlink
    order by matchscore desc
    LIMIT numAds;
    
    -- update the main table to reflect the last accessed date for these ads
    update adppdb.ads set adaccessdate=NOW() where adid in (select adid from temptable_top_matches);
    
    select adid, adkeyword, adlink, adlinkdesc, matchscore, adaccessdate from temptable_top_matches;
END IF;

END
