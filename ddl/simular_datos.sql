SET synchronous_commit = off;
SET synchronous_commit = on;
ANALYZE public.clientes;

-- generar clientes
INSERT INTO public.clientes
(nombre, documento, direccion, telefono)
SELECT
    'Cliente ' || gs,
    10000000 + gs, -- documento único
    'Calle ' || (random()*100)::int || ' # ' || (random()*100)::int,
    lpad((floor(random()*9999999999))::text, 10, '0')
FROM generate_series(1, 100000) gs;

SELECT count(*) FROM public.clientes;


-- generar cobradores
INSERT INTO public.cobradores (nombre)
SELECT
    'Cobrador ' || gs
FROM generate_series(1, 500) gs;


-- generar rutas
INSERT INTO public.rutas
(id_cobrador, zona)
SELECT
    (random()*499 + 1)::int,              -- cobrador aleatorio (1-500)
    'Zona ' || (random()*9 + 1)::int     -- Zona 1 a Zona 10
FROM generate_series(1, 200) gs;


-- generar rutas del cliente
INSERT INTO public.ruta_cliente (id_cliente, id_ruta)
SELECT
    id_cliente,
    (random()*199 + 1)::int
FROM public.clientes;


-- generar creditos
SET synchronous_commit = off;
SET synchronous_commit = on;
ANALYZE public.creditos;

INSERT INTO public.creditos
(id_cliente, monto, fecha_inicio, estado)
SELECT
    (random()*99999 + 1)::int,
    (random()*5000000 + 500000)::numeric(12,2),
    date '2025-01-01' + (random()*424)::int,
    true
FROM generate_series(1, 5000000);


-- generar pagos
SET synchronous_commit = off;
SET synchronous_commit = on;
ANALYZE public.pagos;

INSERT INTO public.pagos
(id_credito, fecha_pago, valor_pago)
SELECT
    (random()*4999999 + 1)::int, -- crédito aleatorio existente
    date '2025-01-01' + (random()*424)::int,
    (random()*300000 + 50000)::numeric(10,2)
FROM generate_series(1, 5000000);


-- actualziar pagos para que existan creditos pagados en su totalidad
WITH creditos_random AS (
    SELECT id_credito
        FROM creditos
    ORDER BY random()
    LIMIT 500000
)
UPDATE pagos p
        SET valor_pago = c.monto
    FROM creditos c
    JOIN creditos_random cr 
         ON cr.id_credito = c.id_credito
    WHERE p.id_credito = c.id_credito;


-- actualizar pagos para que exista pagos parciales
WITH creditos_random AS (
    SELECT id_credito
    FROM creditos
    ORDER BY random()
    LIMIT 1000000
)
UPDATE pagos p
        SET valor_pago = c.monto * 0.5
    FROM creditos c
    JOIN creditos_random cr
         ON cr.id_credito = c.id_credito
    WHERE p.id_credito = c.id_credito
        AND p.fecha_pago >= '2025-01-01'
        AND p.fecha_pago <  '2026-03-01';


-- borrar para crear morosos
WITH creditos_random AS (
    SELECT id_credito
        FROM creditos
    ORDER BY random()
    LIMIT 800000
)
DELETE FROM pagos p
    USING creditos_random cr
    WHERE p.id_credito = cr.id_credito
        AND p.fecha_pago >= CURRENT_DATE - INTERVAL '60 days';


-- marcar creditos inactivos
WITH creditos_random AS (
    SELECT id_credito
        FROM creditos
        WHERE fecha_inicio >= '2025-01-01'
        AND fecha_inicio <  '2026-03-01'
    ORDER BY random()
    LIMIT 300000
)
UPDATE creditos c
        SET estado = false
    FROM creditos_random cr
    WHERE c.id_credito = cr.id_credito;
