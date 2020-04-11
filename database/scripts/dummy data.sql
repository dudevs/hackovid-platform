INSERT INTO supermarket.shop(
    id, nom, adress, city, latitude, longitude)
    VALUES ('b176b97fdc860f283163cdfb8afd97a3ad2b4ee6', 'Mercadona', 'Carrer de Monturiol 136', 'Terrassa', 41.573952, 2.007533);
INSERT INTO supermarket.shop(
    id, nom, adress, city, latitude, longitude)
    VALUES ('5499750304c4b0b3e4440f4d46ed7ebb733293bd', 'Esclat', 'Avinguda de Josep Tarradellas, 2', 'Terrassa', 41.571361, 2.003143);
INSERT INTO supermarket.shop(
    id, nom, adress, city, latitude, longitude)
    VALUES ('8569b400cb87fcf87d1447c92a1abcca098da62b', 'Caprabo', 'Carrer de Sol i Padrís, 102', 'Sabadell', 41.5413275, 2.1166302);
INSERT INTO supermarket.shop(
    id, nom, adress, city, latitude, longitude)
    VALUES ('4176b97fdc8646f83163cdfb8afd97a3ad2b4ee6', 'Aldi', 'Passeig de Can Feu, 123', 'Sabadell', 41.5393673, 2.0951545);


INSERT INTO supermarket.group_types(
    name, description)
    VALUES ('RICE', 'Rice and variety');
INSERT INTO supermarket.group_types(
    name, description)
    VALUES ('PAPER', 'Paper and variety');
INSERT INTO supermarket.group_types(
    name, description)
    VALUES ('PASTA', 'Pasta and variety');
INSERT INTO supermarket.group_types(
    name, description)
    VALUES ('VEGETABLES', 'Vegetables and variety');


INSERT INTO supermarket.infoshop(
    idshop, groupname, unixtime, positives, negatives)
    VALUES ('b176b97fdc860f283163cdfb8afd97a3ad2b4ee6','VEGETABLES',1586413016, 12, 0);
INSERT INTO supermarket.infoshop(
    idshop, groupname, unixtime, positives, negatives)
    VALUES ('b176b97fdc860f283163cdfb8afd97a3ad2b4ee6','PAPER',1586512800, 1, 2);
INSERT INTO supermarket.infoshop(
    idshop, groupname, unixtime, positives, negatives)
    VALUES ('b176b97fdc860f283163cdfb8afd97a3ad2b4ee6','RICE', 1586517900, 2, 0);