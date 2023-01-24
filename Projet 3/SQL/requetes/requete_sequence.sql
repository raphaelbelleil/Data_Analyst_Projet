insert into bien (id_commune,no_voie,type_voie,indice_repetition,voie,nombre_piece,surface_carrez,surface_reelle_bati,type_local)
values ('38169',15,'RTE','de','kerivin',4,100,100,'Maison')


select * from bien
ORDER BY id_bien desc

CREATE SEQUENCE IF NOT EXISTS public.bien_id_bien
    INCREMENT 1
    START 34146
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
	
	
CREATE SEQUENCE IF NOT EXISTS public.vente_id_vente
    INCREMENT 1
    START 34170
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
	
alter table vente 
alter column id_vente
type bigint

alter table vente 
alter column id_vente bigint
set default nextval('vente.id_vente')

alter table bien 
alter column id_bien
type bigint

alter table bien
alter column id_bien bigint
set default nextval('bien_id_bien')