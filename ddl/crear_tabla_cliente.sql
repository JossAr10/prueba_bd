CREATE TABLE public.clientes (
	id_cliente int8 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL, -- Identificador del cliente
	nombre varchar(30) NOT NULL, -- Nombre del cliente
	documento int4 NOT NULL, -- Número de identificación del cliente
	direccion text NOT NULL, -- Dirección del cliente
	telefono varchar(10) NOT NULL, -- Número de contacto del cliente
	CONSTRAINT check_rango_telefono CHECK (((length((telefono)::text) >= 7) AND (length((telefono)::text) <= 10))),
	CONSTRAINT clientes_documento_unique UNIQUE (documento),
	CONSTRAINT clientes_pkey PRIMARY KEY (id_cliente)
);
COMMENT ON TABLE public.clientes IS 'Almacena los clientes de la empresa';

-- Column comments

COMMENT ON COLUMN public.clientes.id_cliente IS 'Identificador del cliente';
COMMENT ON COLUMN public.clientes.nombre IS 'Nombre del cliente';
COMMENT ON COLUMN public.clientes.documento IS 'Número de identificación del cliente';
COMMENT ON COLUMN public.clientes.direccion IS 'Dirección del cliente';
COMMENT ON COLUMN public.clientes.telefono IS 'Número de contacto del cliente';