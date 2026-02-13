CREATE TABLE public.pagos (
	id_pago int8 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL, -- Identificador del pago
	id_credito int8 NOT NULL, -- Identificador del credito
	fecha_pago date NOT NULL, -- Fecha del pago
	valor_pago numeric(10, 2) NOT NULL, -- Valor del pago
	CONSTRAINT pagos_pk PRIMARY KEY (id_pago),
	CONSTRAINT pagos_saldo_credito_fk FOREIGN KEY (id_credito) REFERENCES public.saldo_credito(id_credito)
)
PARTITION BY RANGE (fecha_pago);
CREATE INDEX idx_pagos_credito_fecha ON ONLY public.pagos USING btree (id_credito, fecha_pago);
CREATE INDEX idx_pagos_fecha_credito ON ONLY public.pagos USING btree (fecha_pago, id_credito);
CREATE INDEX idx_pagos_id_credito ON ONLY public.pagos USING btree (id_credito);
COMMENT ON TABLE public.pagos IS 'Almacena los pagos realizados a los creditos';

-- Column comments

COMMENT ON COLUMN public.pagos.id_pago IS 'Identificador del pago';
COMMENT ON COLUMN public.pagos.id_credito IS 'Identificador del credito';
COMMENT ON COLUMN public.pagos.fecha_pago IS 'Fecha del pago';
COMMENT ON COLUMN public.pagos.valor_pago IS 'Valor del pago';
