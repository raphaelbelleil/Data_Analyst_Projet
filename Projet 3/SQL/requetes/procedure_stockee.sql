-- procedure stockee

CREATE PROCEDURE transformation_maison_and_size (idbien_a_transformer bigint)
language plpgsql  
as $$

begin

	update bien 
	set type_local='Maison'
	where id_bien=idbien_a_transformer;

	update bien
	set surface_reelle_bati=surface_reelle_bati*10
	where id_bien=idbien_a_transformer;

	commit;
	
end; $$


call transformation_maison_and_size(34147)



