CREATE OR REPLACE FUNCTION fn_actualizar_saldo()
RETURNS TRIGGER AS $$
BEGIN

    -- INSERT
    IF TG_OP = 'INSERT' THEN
        
        INSERT INTO saldo_credito (id_credito, total_pagado)
        VALUES (NEW.id_credito, NEW.valor_pago)
        ON CONFLICT (id_credito)
        DO UPDATE
        SET total_pagado = saldo_credito.total_pagado + NEW.valor_pago;

        RETURN NEW;
    END IF;

    -- UPDATE
    IF TG_OP = 'UPDATE' THEN
        
        UPDATE saldo_credito
        SET total_pagado = total_pagado 
                           - OLD.valor_pago 
                           + NEW.valor_pago
        WHERE id_credito = NEW.id_credito;

        RETURN NEW;
    END IF;

    -- DELETE
    IF TG_OP = 'DELETE' THEN
        
        UPDATE saldo_credito
        SET total_pagado = total_pagado - OLD.valor_pago
        WHERE id_credito = OLD.id_credito;

        RETURN OLD;
    END IF;

END;
$$ LANGUAGE plpgsql;
