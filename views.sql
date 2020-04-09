CREATE VIEW supermarket.last_four_hours AS 
SELECT idshop, groupname, unixtime, positives, negatives
FROM supermarket.infoshop
where unixtime between floor(extract(epoch from now())-14400) and floor(extract(epoch from now()));
