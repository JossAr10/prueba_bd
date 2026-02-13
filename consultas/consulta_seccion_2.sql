-- saldos pendientes 
SELECT c.id_credito, c.monto - COALESCE(s.total_pagado,0) AS saldo
    FROM creditos c
    LEFT JOIN saldo_credito s
       ON s.id_credito = c.id_credito
WHERE c.monto > COALESCE(s.total_pagado,0);


-- cuotas atrasadas
SELECT  c.id_cliente, COUNT(*) AS cuotas_atrasadas
    FROM creditos c
    LEFT JOIN saldo_credito s
           ON s.id_credito = c.id_credito
    WHERE c.estado = true
        AND c.fecha_inicio <= CURRENT_DATE - INTERVAL '30 days'
        AND c.monto > COALESCE(s.total_pagado, 0)
        AND NOT EXISTS (
            SELECT 1
                FROM pagos p
            WHERE p.id_credito = c.id_credito
                AND p.fecha_pago >= CURRENT_DATE - INTERVAL '30 days'
    )
GROUP BY c.id_cliente
HAVING COUNT(*) > 3;


-- recaudación mensual
WITH pagos_mes AS (
    SELECT id_credito, SUM(valor_pago) total_mes
        FROM pagos
    WHERE fecha_pago >= date_trunc('month', CURRENT_DATE) - INTERVAL '1 month'
        AND fecha_pago <  date_trunc('month', CURRENT_DATE)
    GROUP BY id_credito
)
SELECT co.id_cobrador, SUM(p.total_mes) AS total_recaudado
    FROM pagos_mes p
    JOIN creditos c      
        ON c.id_credito = p.id_credito
    JOIN clientes cl      
        ON cl.id_cliente = c.id_cliente
    JOIN ruta_cliente rc  
        ON rc.id_cliente = cl.id_cliente
    JOIN rutas r          
        ON r.id_ruta = rc.id_ruta
    JOIN cobradores co    
        ON co.id_cobrador = r.id_cobrador
GROUP BY co.id_cobrador
ORDER BY total_recaudado DESC;

-- top deudores
WITH pagos_totales AS (
    SELECT  id_credito, SUM(valor_pago) AS total_pagado
        FROM pagos
    GROUP BY id_credito
)
SELECT cl.id_cliente, cl.nombre, SUM(c.monto - COALESCE(pt.total_pagado,0)) AS deuda_total
    FROM creditos c
    JOIN clientes cl       
        ON cl.id_cliente = c.id_cliente
    LEFT JOIN pagos_totales pt 
        ON pt.id_credito = c.id_credito
    WHERE c.estado = true
GROUP BY cl.id_cliente, cl.nombre
HAVING SUM(c.monto - COALESCE(pt.total_pagado,0)) > 0
ORDER BY deuda_total DESC
LIMIT 5;


-- tipos de JOIN 
INNER JOIN: devuelve los registros que coinciden en ambas tablas.
LEFT JOIN: devuelos los registros de la tabla de la izquierda, a pesar que no existan registros que coincidan en la tabla de la derecha.
EXISTS: verifica que exista al menos un registro en la consulta realizada.
IN: compara un valor contra un listado o una subconsulta.
