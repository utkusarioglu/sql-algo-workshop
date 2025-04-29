DROP FUNCTION IF EXISTS fibonacci;

CREATE TYPE fib_return AS (
  "order" BIGINT,
  "value" INT
);

CREATE FUNCTION fibonacci(count INT DEFAULT 5, memo INT[] DEFAULT ARRAY[0, 1])
  RETURNS SETOF fib_return
  LANGUAGE plpgsql
  AS $$
BEGIN
  FOR i IN 1..array_length(memo, 1) LOOP
    RETURN NEXT ROW(i, memo[i])::fib_return;
  END LOOP;

  FOR i IN array_length(memo, 1)..(count - 1) LOOP
    memo = memo || memo[i] + memo[i - 1];
    RETURN NEXT ROW(i + 1, memo[i + 1])::fib_return;
  END LOOP;
END;
$$;

SELECT * FROM fibonacci(%s, %s);
