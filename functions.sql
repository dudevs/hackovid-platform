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
    OWNER TO postgres;
