CREATE TABLE public.saldo_credito (
	id_credito int8 NOT NULL, -- Identificador del credito
	total_pagado numeric DEFAULT 0 NOT NULL, -- Total apgado
	fecha_inicio date NOT NULL, -- Fecha de la solicitud del credito
	CONSTRAINT saldo_credito_pkey PRIMARY KEY (id_credito),
	CONSTRAINT saldo_credito_creditos_fk FOREIGN KEY (id_credito,fecha_inicio) REFERENCES public.creditos(id_credito,fecha_inicio)
);
COMMENT ON TABLE public.saldo_credito IS 'Almacena los saldos pagados al credito';

-- Column comments

COMMENT ON COLUMN public.saldo_credito.id_credito IS 'Identificador del credito';
COMMENT ON COLUMN public.saldo_credito.total_pagado IS 'Total apgado';
COMMENT ON COLUMN public.saldo_credito.fecha_inicio IS 'Fecha de la solicitud del credito';