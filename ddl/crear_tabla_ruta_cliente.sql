CREATE TABLE public.ruta_cliente (
	id_ruta int8 NOT NULL, -- Identificador de la ruta
	id_cliente int8 NOT NULL, -- Identificador del cliente
	CONSTRAINT ruta_cliente_unique UNIQUE (id_ruta, id_cliente),
	CONSTRAINT ruta_cliente_clientes_fk FOREIGN KEY (id_cliente) REFERENCES public.clientes(id_cliente),
	CONSTRAINT ruta_cliente_rutas_fk FOREIGN KEY (id_ruta) REFERENCES public.rutas(id_ruta)
);
COMMENT ON TABLE public.ruta_cliente IS 'Almacena la ruta asociada al cliente';

-- Column comments

COMMENT ON COLUMN public.ruta_cliente.id_ruta IS 'Identificador de la ruta';
COMMENT ON COLUMN public.ruta_cliente.id_cliente IS 'Identificador del cliente';