-- Ce script a été généré par une version bêta de l'outil diagramme entité-association de pgAdmin 4.
-- Veuillez signaler tout problème à https://redmine.postgresql.org/projects/pgadmin4/issues/new si vous trouvez des erreurs. Préciser dans le rapport les étapes pour le reproduire.
BEGIN;


CREATE TABLE IF NOT EXISTS public.bien
(
    id_bien integer NOT NULL,
    id_commune character varying(6) COLLATE pg_catalog."default" NOT NULL,
    no_voie integer,
    type_voie character varying(4) COLLATE pg_catalog."default",
    indice_repetition character varying(5) COLLATE pg_catalog."default",
    voie character varying(50) COLLATE pg_catalog."default" NOT NULL,
    nombre_piece integer NOT NULL,
    surface_carrez real NOT NULL,
    surface_reelle_bati integer NOT NULL,
    type_local character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT bien_pkey PRIMARY KEY (id_bien)
);

CREATE TABLE IF NOT EXISTS public.commune
(
    id_commune character varying(6) COLLATE pg_catalog."default" NOT NULL,
    nom_commune character varying(50) COLLATE pg_catalog."default" NOT NULL,
    code_postal integer,
    id_departement character varying(3) COLLATE pg_catalog."default" NOT NULL,
    population integer,
    CONSTRAINT commune_pkey PRIMARY KEY (id_commune)
);

CREATE TABLE IF NOT EXISTS public.departement
(
    id_departement character varying(3) COLLATE pg_catalog."default" NOT NULL,
    nom_departement character varying(50) COLLATE pg_catalog."default" NOT NULL,
    id_region character varying(2) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT departement_pkey PRIMARY KEY (id_departement)
);

CREATE TABLE IF NOT EXISTS public.region
(
    id_region character varying(2) COLLATE pg_catalog."default" NOT NULL,
    nom_region character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT region_pkey PRIMARY KEY (id_region)
);

CREATE TABLE IF NOT EXISTS public.vente
(
    id_vente integer NOT NULL,
    id_bien integer NOT NULL,
    date_vente date NOT NULL,
    valeur_fonciere real,
    CONSTRAINT vente_pkey PRIMARY KEY (id_vente)
);

ALTER TABLE IF EXISTS public.bien
    ADD CONSTRAINT id_commune FOREIGN KEY (id_commune)
    REFERENCES public.commune (id_commune) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.commune
    ADD CONSTRAINT id_departement FOREIGN KEY (id_departement)
    REFERENCES public.departement (id_departement) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.departement
    ADD CONSTRAINT id_region FOREIGN KEY (id_region)
    REFERENCES public.region (id_region) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.vente
    ADD CONSTRAINT id_bien FOREIGN KEY (id_bien)
    REFERENCES public.bien (id_bien) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;