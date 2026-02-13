-- crear particiones en tabla "creditos"
SELECT public.fn_generar_particiones_creditos('2026-01-01', '2027-02-01');

-- crear particiones en tabla "pagos"
SELECT public.fn_generar_particiones_pagos('2026-01-01', '2027-02-01');
