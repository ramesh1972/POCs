select * from adppdb.ads where MATCH(adkeyword) AGAINST('pick up the galaxy phone and max fresh DAY' in BOOLEAN MODE);

call adppdb.insertad ('phone,call, galaxy', 'localhost5', 'ring all day');
drop table temptable1;

create TEMPORARY TABLE temptable1
SELECT adid, adlink, adkeyword, adlinkdesc, MATCH (adkeyword) AGAINST ('pick up the samsung galaxy phone and max fresh fresh DAY soap phone' in boolean mode)
AS score FROM adppdb.ads order by score desc;

select FOUND_ROWS()

select adid, adlink, adkeyword, adlinkdesc, max(score) from temptable1
group by adlink
order by score desc

delete from adppdb.ads where adid=5
select * from adppdb.ads; 

drop table if exists adppdb.temptable_top_matches;
drop table if exists adppdb.temptable_all_matches;
call getads('pick up the samsung galaxy phone and max fresh DAY ring fresh',1)