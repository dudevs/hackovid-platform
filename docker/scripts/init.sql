
\connect dudevs


--create schema
CREATE SCHEMA supermarket;


--create tables
CREATE TABLE supermarket.group_types(
    name VARCHAR(250) primary key,
    description VARCHAR(250)
);

CREATE TABLE supermarket.shop(
    id VARCHAR(40) primary key,
    nom VARCHAR(250),
    address VARCHAR(250),
    city VARCHAR(250),
    latitude double precision,
    longitude double precision
);

CREATE TABLE supermarket.infoshop(
    idshop VARCHAR(250),
    groupname VARCHAR(250), 
    unixtime NUMERIC(10),
    positives NUMERIC(4) default 0,
    negatives NUMERIC(4) default 0,
    primary key(idshop, groupname, unixtime)
);

ALTER TABLE supermarket.infoshop
    ADD CONSTRAINT idshop_shop foreign key (idshop)
    REFERENCES supermarket.shop (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE supermarket.infoshop
    ADD CONSTRAINT groupname_group_types foreign key (groupname)
    REFERENCES supermarket.group_types (name) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

--create views
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
    OWNER TO dudevs;

--create  sequences
CREATE SEQUENCE supermarket.api_calls
    INCREMENT 1
    START 0
    MINVALUE 0
    MAXVALUE 4000
    CACHE 1;

ALTER SEQUENCE supermarket.api_calls
    OWNER TO dudevs;

COMMENT ON SEQUENCE supermarket.api_calls
    IS 'The number of the API is called. Max -> 4000';

--create functions
CREATE OR REPLACE FUNCTION supermarket."getNearbyShops"(
    double precision,
    double precision,
    integer)
    RETURNS TABLE(id character varying) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
BEGIN
    RETURN QUERY SELECT sh.id
                 FROM supermarket.shop sh
                 WHERE supermarket.st_distancesphere(supermarket.ST_MakePoint($1,$2),
                                                      supermarket.ST_MakePoint(sh.latitude,sh.longitude)
                                                     )<=$3;
                 END; $BODY$;

ALTER FUNCTION supermarket."getNearbyShops"(double precision, double precision, integer)
    OWNER TO dudevs;

CREATE OR REPLACE FUNCTION supermarket.vote(
    text,
    text,
    boolean)
    RETURNS integer
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
DECLARE 
    curs1 CURSOR
    FOR SELECT i.idshop, i.groupname
        FROM supermarket.infoshop i
        WHERE i.idshop = $1 and i.groupname = $2
        and i.unixtime = (select CAST(floor(date_part('epoch'::text, now())) AS integer)-CAST(floor(date_part('epoch'::text, now())) AS integer)%300);
    p_idshop text;
    p_groupname text;
    p_unix integer;

BEGIN
    SELECT CAST(floor(date_part('epoch'::text, now())) AS integer)-CAST(floor(date_part('epoch'::text, now())) AS integer)%300
    INTO p_unix;
    
    OPEN curs1;
    
    FETCH curs1 INTO p_idshop, p_groupname;
    --Si tenim resultats fem update als vots positius o negatius i retornem un 1
    IF (p_groupname IS NOT NULL AND p_idshop IS NOT NULL) THEN
        IF ($3) THEN
            UPDATE supermarket.infoshop
            SET positives=positives+1
            WHERE idshop= $1
            and groupname= $2
            and unixtime=p_unix;
            return 1;
        ELSE
            UPDATE supermarket.infoshop
            SET negatives=negatives+1
            WHERE idshop= $1
            and groupname= $2
            and unixtime=p_unix;
            return 1;
        END IF;
    ELSE
        --Si no tenim resultats fem insert amb 1 en el vot que toqui i retornem 1
        IF ($3) THEN
            INSERT INTO supermarket.infoshop(
            idshop, groupname, unixtime, positives, negatives)
            VALUES ($1, $2, p_unix, 1, 0);
            RETURN 2;
        ELSE
            INSERT INTO supermarket.infoshop(
            idshop, groupname, unixtime, positives, negatives)
            VALUES ($1, $2, p_unix, 0, 1);
            RETURN 2;
        END IF;
    END IF;
END; $BODY$;

ALTER FUNCTION supermarket.vote(text, text, boolean)
    OWNER TO dudevs;

