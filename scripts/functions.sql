-- FUNCTION: supermarket."getNearbyShops"(double precision, double precision, integer)

-- DROP FUNCTION supermarket."getNearbyShops"(double precision, double precision, integer);

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


-- FUNCTION: supermarket.vote(text, text, boolean)

-- DROP FUNCTION supermarket.vote(text, text, boolean);

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
