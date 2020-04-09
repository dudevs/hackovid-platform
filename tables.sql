CREATE TABLE supermarket.group_types(
    name VARCHAR(250) primary key,
    description VARCHAR(250)
);

CREATE TABLE supermarket.shop(
    id VARCHAR(40) primary key,
    nom VARCHAR(250),
    latitude double precision,
    longitude double precision,
    adress VARCHAR(250),
    city VARCHAR(250)
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
