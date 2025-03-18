CREATE OR REPLACE FUNCTION func_minimum(arr DOUBLE PRECISION[])
RETURNS DOUBLE PRECISION AS $$
BEGIN
	RETURN (SELECT MIN(unnested) FROM unnest(arr) AS unnest(unnested));
END;
$$ LANGUAGE plpgsql;



-- SELECT func_minimum(VARIADIC arr => ARRAY[10.0, -1.0, 5.0, 4.4]);