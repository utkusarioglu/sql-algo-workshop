DROP PROCEDURE IF EXISTS public.prep_test;
DROP FUNCTION IF EXISTS public.basic_function;

DROP TYPE IF EXISTS public.public_hello_type;
CREATE TYPE public.public_hello_type AS (
  val INT
);

DROP PROCEDURE IF EXISTS public.cleanup_test;
CREATE OR REPLACE PROCEDURE public.cleanup_test()
  LANGUAGE plpgsql
AS $$
BEGIN
  DROP TABLE IF EXISTS hello;
END;
$$;

CREATE OR REPLACE PROCEDURE public.prep_test()
  LANGUAGE plpgsql
  AS $$
BEGIN
  CREATE TABLE hello ("numbers" INT);
END;
$$;

DROP FUNCTION IF EXISTS public.basic_function;
CREATE FUNCTION public.basic_function(
  p_mod_value INT -- public.public_hello_type.val
)
  RETURNS SETOF public_hello_type
  LANGUAGE plpgsql
  AS $$
BEGIN
  INSERT INTO hello ("numbers") VALUES (1), (2), (3), (4);

  RETURN QUERY
    SELECT * 
    FROM "hello" 
    WHERE 
      MOD("numbers", p_mod_value) = 0
  ;
END;
$$;


DROP FUNCTION IF EXISTS public.main;
CREATE FUNCTION public.main(
  p_mod_value INT
)
  RETURNS SETOF public_hello_type
  LANGUAGE plpgsql
  AS $$
DECLARE
  response public_hello_type[];
  response_row public_hello_type;
BEGIN
  CALL public.prep_test();

  response := ARRAY(
    SELECT public.basic_function(p_mod_value)
  );

  FOR response_row IN SELECT * FROM UNNEST(response) 
  LOOP
    RETURN NEXT response_row;
  END LOOP;

  CALL public.cleanup_test();
  RETURN;
END;
$$;

DROP VIEW IF EXISTS public.v_main;
CREATE VIEW public.v_main AS
  SELECT * FROM public.main(%s);
  
SELECT * from v_main;
