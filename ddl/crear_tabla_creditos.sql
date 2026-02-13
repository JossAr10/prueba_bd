CREATE TABLE public.creditos (
	id_credito int8 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL, -- Identificador del crédito
	id_cliente int8 NOT NULL, -- Identificador del cliente
	monto numeric(10, 2) NOT NULL, -- Monto solicitado
	fecha_inicio date NOT NULL, -- Fecha de la solicitud
	estado bool NULL, -- Estado del credito
	CONSTRAINT creditos_pkey PRIMARY KEY (id_credito, fecha_inicio),
	CONSTRAINT creditos_clientes_fk FOREIGN KEY (id_cliente) REFERENCES public.clientes(id_cliente)
)
PARTITION BY RANGE (fecha_inicio);
CREATE INDEX idx_creditos_estado ON ONLY public.creditos USING btree (estado);
CREATE INDEX idx_creditos_estado_fecha ON ONLY public.creditos USING btree (estado, fecha_inicio);
CREATE INDEX idx_creditos_id_credito ON ONLY public.creditos USING btree (id_credito);
COMMENT ON TABLE public.creditos IS 'Almacena los creditos solicitados por clientes';

-- Column comments

COMMENT ON COLUMN public.creditos.id_credito IS 'Identificador del crédito';
COMMENT ON COLUMN public.creditos.id_cliente IS 'Identificador del cliente';
COMMENT ON COLUMN public.creditos.monto IS 'Monto solicitado';
COMMENT ON COLUMN public.creditos.fecha_inicio IS 'Fecha de la solicitud';
COMMENT ON COLUMN public.creditos.estado IS 'Estado del credito';

