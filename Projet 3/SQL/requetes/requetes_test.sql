select * from bien;

select id_bien, surface_carrez, surface_reelle_bati, 
surface_carrez+surface_reelle_bati as somme_surface 
from bien
limit 1000;

select sum(valeur_fonciere) from vente;

select id_vente, b.id_bien, date_vente, valeur_fonciere, surface_carrez,
surface_reelle_bati, com.id_commune, nom_commune
from vente v 
inner join bien b
on v.id_bien=b.id_bien
inner join commune com
on b.id_commune=com.id_commune
order by valeur_fonciere;


select id_vente, valeur_fonciere,surface_reelle_bati, surface_carrez, type_local, nom_commune,
(valeur_fonciere/surface_reelle_bati) as prix_m2
from vente v 
inner join bien b
on v.id_bien=b.id_bien
inner join commune com
on b.id_commune=com.id_commune
inner join departement d
on com.id_departement=d.id_departement
inner join region r
on d.id_region=r.id_region
order by (valeur_fonciere/surface_reelle_bati) desc
;



select * from vente_nulle;

update vente_nulle set valeur_fonciere_nul = null
;

select 
	id_vente, valeur_fonciere, com.id_commune, nom_commune
from 
	vente v
	inner join bien b
	on v.id_bien=b.id_bien
	inner join commune com
	on b.id_commune=com.id_commune
	inner join 
	(select co.id_commune, nom_commune, avg(valeur_fonciere/surface_reelle_bati) as moyenne_prix_m2
	from vente v
	inner join bien b
	on v.id_bien=b.id_bien
	inner join commune co
	on b.id_commune=com.id_commune
	inner join departement d
	on com.id_departement=d.id_departement
	inner join region r
	on d.id_region=r.id_region
	group by com.id_commune, nom_commune
	order by moyenne_prix_m2 desc) as ville_moyenne_prix_m2
	on com.id_commune = co.id_commune
