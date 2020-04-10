-- SEQUENCE: supermarket.api_calls

-- DROP SEQUENCE supermarket.api_calls;

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
