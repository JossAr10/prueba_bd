INSERT INTO saldo_credito (id_credito, total_pagado)
SELECT id_credito, SUM(valor_pago)
    FROM pagos
GROUP BY id_credito;