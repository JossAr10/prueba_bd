CREATE TABLE public.cobradores (
	id_cobrador int8 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL, -- Identificador del cobrador
	nombre varchar(30) NOT NULL, -- Nombre del cobrador
	CONSTRAINT cobradores_pk PRIMARY KEY (id_cobrador)
);
COMMENT ON TABLE public.cobradores IS 'Almacena los cobradores de la empresa';

-- Column comments

COMMENT ON COLUMN public.cobradores.id_cobrador IS 'Identificador del cobrador';
COMMENT ON COLUMN public.cobradores.nombre IS 'Nombre del cobrador';