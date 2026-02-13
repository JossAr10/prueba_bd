CREATE TABLE public.saldo_credito (
	id_credito int8 NOT NULL, -- Identificador del credito
	total_pagado numeric DEFAULT 0 NOT NULL, -- Total apgado
	CONSTRAINT saldo_credito_pkey PRIMARY KEY (id_credito)
);
COMMENT ON TABLE public.saldo_credito IS 'Almacena los saldos pagados al credito';

-- Column comments

COMMENT ON COLUMN public.saldo_credito.id_credito IS 'Identificador del credito';
COMMENT ON COLUMN public.saldo_credito.total_pagado IS 'Total apgado';