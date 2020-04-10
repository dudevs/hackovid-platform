-- View: supermarket.last_four_hours

-- DROP VIEW supermarket.last_four_hours;

CREATE OR REPLACE VIEW supermarket.last_four_hours
 AS
 SELECT infoshop.idshop,
    infoshop.groupname,
    infoshop.unixtime,
    infoshop.positives,
    infoshop.negatives
   FROM supermarket.infoshop
  WHERE infoshop.unixtime::double precision >= floor(date_part('epoch'::text, now()) - 14400::double precision);

ALTER TABLE supermarket.last_four_hours
    OWNER TO postgres;
