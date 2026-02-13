La empresa detecta:

Clientes duplicados
Clientes duplicados por documento.

Créditos huérfanos
Créditos sin cliente asociado.

Pagos inválidos
Pagos sin crédito válido.


¿Cómo identificarías y solucionarías estos problemas?
Desarrolla una estrategia que incluya consultas SQL para detectar inconsistencias y un ejemplo de un procedimiento para limpiar datos duplicados.

----------------------------------------
Clientes duplicados:
----------------------------------------

-- detectar clientes duplicados
SELECT documento, COUNT(*) AS cantidad
    FROM clientes
GROUP BY documento
HAVING COUNT(*) > 1;

-- consultar el detalle de los clientes duplicados
SELECT *
    FROM clientes
    WHERE documento IN (
        SELECT documento
            FROM clientes
        GROUP BY documento
        HAVING COUNT(*) > 1
    )
ORDER BY documento;

-- identifcar el primer registro deld ato duplciado
SELECT documento, MIN(id_cliente) AS id_principal
    FROM clientes
GROUP BY documento
HAVING COUNT(*) > 1;

-- reasignar los registros al cliente correcto
UPDATE creditos c
        SET id_cliente = sub.id_principal
    FROM (
        SELECT documento, MIN(id_cliente) AS id_principal
            FROM clientes
        GROUP BY documento
        HAVING COUNT(*) > 1
    ) sub
    JOIN clientes cl 
        ON cl.documento = sub.documento
    WHERE c.id_cliente = cl.id_cliente
        AND cl.id_cliente <> sub.id_principal;

-- eliminar los duplicados
DELETE FROM clientes
    WHERE id_cliente NOT IN (
        SELECT MIN(id_cliente)
            FROM clientes
        GROUP BY documento
    );

-- crear llave unica por el documento del cliente
ALTER TABLE clientes ADD CONSTRAINT unique_documento UNIQUE (documento);


----------------------------------------
Créditos huérfanos
----------------------------------------

-- identificar los creditos huerfanos
SELECT c.*
    FROM creditos c
    LEFT JOIN clientes cl 
        ON cl.id_cliente = c.id_cliente
    WHERE cl.id_cliente IS NULL;

-- asignar aun cliente degenerico hasta poderlos dentificar o posteriormente borrar
INSERT INTO clientes (nombre, documento ,direccion ,telefono)
    VALUES ('CLIENTE DESCONOCIDO', 0, 'N/A', 1111111);

UPDATE creditos
        SET id_cliente = X -- colocar el identificador creado pro el INSERT
    WHERE id_cliente NOT IN (
        SELECT id_cliente 
            FROM clientes
    );

-- crear renstricción de cliente null y crear llave foranea contra clientes
ALTER TABLE public.creditos ADD CONSTRAINT creditos_clientes_fk FOREIGN KEY (id_cliente) REFERENCES public.clientes(id_cliente);


----------------------------------------
Pagos inválidos
----------------------------------------
