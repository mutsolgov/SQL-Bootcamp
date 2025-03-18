CREATE OR REPLACE FUNCTION fnc_fibonacci(pstop INTEGER DEFAULT 10)
RETURNS TABLE(fib_number INTEGER) AS $$
DECLARE
	a INTEGER := 0;
	b INTEGER := 1;
	temp INTEGER;
BEGIN
	RETURN QUERY SELECT a;
	RETURN QUERY SELECT b;

	WHILE b < pstop LOOP
		temp := a + b;
		EXIT WHEN temp >= pstop;
		RETURN QUERY SELECT temp;
		a := b;
		b := temp;
	END LOOP;
END;
$$ LANGUAGE plpgsql;


-- select * from fnc_fibonacci(100);
-- select * from fnc_fibonacci();