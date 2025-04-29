CREATE FUNCTION fibonacci(count INT, memo INT[])
  RETURNS SETOF INT
  LANGUAGE plpgsql
  AS $$
BEGIN
  FOR i IN 1..array_length("memo", 1) LOOP
    RETURN NEXT memo[i];
  END LOOP;

  FOR i IN array_length("memo", 1)..(count - 1) LOOP
    memo = memo || memo[i] + memo[i - 1];
    RETURN NEXT memo[i + 1];
  END LOOP;
END;
$$;

SELECT * FROM fibonacci(5, ARRAY[0, 1]) AS "fib"
UNION ALL
SELECT * FROM fibonacci(5, ARRAY[0, 6]) AS "fib"
;
