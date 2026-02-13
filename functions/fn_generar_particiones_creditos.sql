CREATE OR REPLACE FUNCTION public.fn_generar_particiones_creditos(p_fecha_inicio DATE, p_fecha_limite DATE)
RETURNS VOID AS $$
DECLARE
    v_actual DATE := p_fecha_inicio;
    v_siguiente DATE;
    v_nombre_tabla TEXT;
BEGIN
/***************************************************************************************************************************************
* AUTOR: JOSÉ ARMENTA
* FECHA ELABORACIÓN: 2026-02-12
* VERSION: fn_generar_particiones_creditos
* MODIFICACIONES: 
* DESCRIPCIÓN: 
* 		ESTA FUNCIÓN CREA LAS PARTICIONES POR MES EN LA TABLA "creditos".
***************************************************************************************************************************************/
    -- Validamos que el rango sea coherente
    IF p_fecha_inicio >= p_fecha_limite THEN
        RAISE EXCEPTION 'La fecha de inicio debe ser anterior a la fecha límite';
    END IF;

    WHILE v_actual < p_fecha_limite LOOP
        -- Calculamos el primer día del mes siguiente
        v_siguiente := (v_actual + INTERVAL '1 month')::DATE;
        
        -- Definimos el nombre (ej: creditos_202501)
        v_nombre_tabla := 'creditos_' || TO_CHAR(v_actual, 'YYYYMM');

        -- Ejecución de SQL dinámico con manejo de identificadores y literales
        EXECUTE FORMAT(
            'CREATE TABLE IF NOT EXISTS public.%I 
             PARTITION OF public.creditos 
             FOR VALUES FROM (%L) TO (%L)',
            v_nombre_tabla, v_actual, v_siguiente
        );

        RAISE NOTICE 'Partición verificada/creada: %', v_nombre_tabla;

        v_actual := v_siguiente;
    END LOOP;
END;
$$ LANGUAGE plpgsql;