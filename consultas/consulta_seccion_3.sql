SELECT * 
    FROM pagos 
    WHERE fecha_pago BETWEEN '2025-01-01' AND '2025-12-31';

La consulta duro:
200 row(s) fetched - 0,002s, on 2026-02-12 at 21:20:32
Esto se logro realizando particiones para las tablas transaccionales con altos volumen de registros, separandola por meses.
Se crearon los indices correspondientes para la consultas de estas tablas aprticionadas.

Responder:
¿Qué podría estar ocurriendo?
Mal indexado de las tablas, uso incorrecto de los indices dentro de la consulta.

¿Qué índices crearías?
Indices conpuestos, en esta consulta puntal un indice para la fecha de pago.
CREATE INDEX idx_pagos_fecha_credito ON ONLY public.pagos USING btree (fecha_pago, id_credito);

¿Qué tipo de índice usarías?
Indice compuesto e indice b-tree

¿Cómo validarías la mejora?
Ejecutar un plan de ejecucción a la consulta antes y despues del cambio para medir los tiempos de respuesta.



