1. Explicar qué es ACID, Locking y Deadlock.

-- ASCID: 

a - Atomicidad:
Si una transacción falla, se revierte completamente. 

Ejemplo:
BEGIN;
    UPDATE creditos SET estado = false WHERE id_credito = 100;
    INSERT INTO pagos (...);
COMMIT;

Si el INSERT falla, el UPDATE también se deshace, es decir realiza roolback de lo ejecutado.

b - Consistencia:
La base de datos no permite violar las reglas establecidas por los Constraints, Foreign Keys, Checks, Triggers

c - Aislamiento:
Las tranasacciones que se ejecuten al mismo tiempo no se estorban, es decir, mientras una este haciendo una conslta la otra puede estar insertado.

d - Durabilidad:
Confirmado el commit de la transacción los datos guardados permanencen en la BD.


2. Escribir un ejemplo de transacción para:
Registrar pago.
Actualizar saldo.
Confirmar o revertir en caso de error.


-- Locking:

Cuando se esta modificando datos, la BD bloquea filas o tablas para mantener la consistencia de los datos. 
Bloqueo por filas: Row-level lock ocurre cuando se hacen UPDATE.
Bloqueo por tabla: Table-level lock ocurre cuando se hacen ALTER TABLE, TRUNCATE, VACUUM FULL.


-- Deadlock

Ocurre cuando dos transacciones se bloquean mutuamente, ejemplo:

transacción 1:
BEGIN;
UPDATE creditos SET monto = 100 WHERE id_credito = 1;
-- espera...
UPDATE creditos SET monto = 200 WHERE id_credito = 2;


transacción 2:
BEGIN;
UPDATE creditos SET monto = 300 WHERE id_credito = 2;
-- espera...
UPDATE creditos SET monto = 400 WHERE id_credito = 1;
