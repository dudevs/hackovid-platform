DO $$
DECLARE hash TEXT;
DECLARE currentDate INTEGER;
DECLARE minimum INTEGER;
DECLARE maximum INTEGER;

DECLARE currentInterval INTEGER;
DECLARE numberOfIntervals INTEGER;

BEGIN
  hash := '51c8b2b1e3054286d90311fffb781193fd9a2bd9' ;
  currentDate := 1586610000;
  minimum := 0;
  maximum := 10;
  currentInterval := 0;
  numberOfIntervals := 100;
  WHILE currentInterval < numberOfIntervals LOOP
  	currentDate := currentDate + 5*60;
  	INSERT INTO supermarket.infoshop(idshop, groupname, unixtime, positives, negatives) VALUES (hash,'VEGETABLES', currentDate, random()*(maximum-minimum)+minimum, random()*(maximum-minimum)+minimum);
  	INSERT INTO supermarket.infoshop(idshop, groupname, unixtime, positives, negatives) VALUES (hash,'RICE', currentDate, random()*(maximum-minimum)+minimum, random()*(maximum-minimum)+minimum);
  	INSERT INTO supermarket.infoshop(idshop, groupname, unixtime, positives, negatives) VALUES (hash,'PAPER', currentDate, random()*(maximum-minimum)+minimum, random()*(maximum-minimum)+minimum);
  	INSERT INTO supermarket.infoshop(idshop, groupname, unixtime, positives, negatives) VALUES (hash,'PASTA', currentDate, random()*(maximum-minimum)+minimum, random()*(maximum-minimum)+minimum);
  	currentInterval := currentInterval + 1;
  END LOOP;
END $$;