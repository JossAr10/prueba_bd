DO $$
DECLARE
    v_inicio date := '2025-01-01';
    v_fin date;
    v_nombre text;
BEGIN
    WHILE v_inicio < '2026-03-01' LOOP
        
        v_fin := (v_inicio + interval '1 month')::date;
        v_nombre := 'pagos_' || to_char(v_inicio, 'YYYYMM');

        EXECUTE format(
            'CREATE TABLE IF NOT EXISTS public.%I
             PARTITION OF public.pagos
             FOR VALUES FROM (%L) TO (%L)',
             v_nombre, v_inicio, v_fin
        );

        v_inicio := v_fin;
    END LOOP;
END $$;
