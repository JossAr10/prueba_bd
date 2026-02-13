CREATE OR REPLACE FUNCTION public.fn_generar_particiones_pagos(
    p_fecha_desde DATE,
    p_fecha_hasta DATE
)
RETURNS VOID AS $$
DECLARE
/***************************************************************************************************************************************
* AUTOR: JOSÉ ARMENTA
* FECHA ELABORACIÓN: 2026-02-12
* VERSION: fn_generar_particiones_pagos
* MODIFICACIONES: 
* DESCRIPCIÓN: 
* 		ESTA FUNCIÓN CREA LAS PARTICIONES POR MES EN LA TABLA "pagos".
***************************************************************************************************************************************/
    v_actual DATE := p_fecha_desde;
    v_siguiente DATE;
    v_nombre_tabla TEXT;
BEGIN
    -- Validación de seguridad
    IF p_fecha_desde >= p_fecha_hasta THEN
        RAISE EXCEPTION 'La fecha de inicio (%) debe ser menor a la fecha límite (%)', p_fecha_desde, p_fecha_hasta;
    END IF;

    WHILE v_actual < p_fecha_hasta LOOP
        -- Calculamos el rango del mes
        v_siguiente := (v_actual + INTERVAL '1 month')::DATE;
        
        -- Construimos el nombre dinámico: pagos_YYYYMM
        v_nombre_tabla := 'pagos_' || TO_CHAR(v_actual, 'YYYYMM');

        -- Ejecución segura con FORMAT
        -- %I para el nombre de la tabla (Identificador)
        -- %L para las fechas (Literales)
        EXECUTE FORMAT(
            'CREATE TABLE IF NOT EXISTS public.%I 
             PARTITION OF public.pagos 
             FOR VALUES FROM (%L) TO (%L)',
            v_nombre_tabla, v_actual, v_siguiente
        );

        RAISE NOTICE 'Procesada partición: %', v_nombre_tabla;

        -- Avanzamos al siguiente mes
        v_actual := v_siguiente;
    END LOOP;
END;
$$ LANGUAGE plpgsql;