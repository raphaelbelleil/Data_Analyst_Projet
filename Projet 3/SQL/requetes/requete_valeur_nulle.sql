select 
	id_vente, valeur_fonciere, com.id_commune, com.nom_commune, moyenne_prix_m2
from 
	vente v
	inner join bien b
	on v.id_bien=b.id_bien
	inner join commune com
	on b.id_commune=com.id_commune
	left join 
	(select co.id_commune, nom_commune, round(avg(valeur_fonciere/surface_reelle_bati)::numeric,2) as moyenne_prix_m2
	from vente v
	inner join bien b
	on v.id_bien=b.id_bien
	inner join commune co
	on b.id_commune=co.id_commune
	inner join departement d
	on co.id_departement=d.id_departement
	inner join region r
	on d.id_region=r.id_region
	group by co.id_commune, nom_commune
	order by moyenne_prix_m2 desc) as ville_moyenne_prix_m2
	on com.id_commune = ville_moyenne_prix_m2.id_commune
where valeur_fonciere is null;


UPDATE vente
SET valeur_fonciere = moyenne_valeur_nulle.moyenne_prix_m2
FROM (
	select 
		id_vente, valeur_fonciere as prix, com.id_commune, com.nom_commune, moyenne_prix_m2
	from 
		vente v
		inner join bien b
		on v.id_bien=b.id_bien
		inner join commune com
		on b.id_commune=com.id_commune
		left join 
		(select co.id_commune, nom_commune, avg(valeur_fonciere/surface_reelle_bati) as moyenne_prix_m2
		from vente v
		inner join bien b
		on v.id_bien=b.id_bien
		inner join commune co
		on b.id_commune=co.id_commune
		inner join departement d
		on co.id_departement=d.id_departement
		inner join region r
		on d.id_region=r.id_region
		group by co.id_commune, nom_commune
		order by moyenne_prix_m2 desc) as ville_moyenne_prix_m2
		on com.id_commune = ville_moyenne_prix_m2.id_commune
	where valeur_fonciere is null
	) as moyenne_valeur_nulle
where valeur_fonciere is null 
and vente.id_bien=bien.id_bien
and bien.id_commune=commune.id_commune

select * from vente
order by date_vente desc

insert into vente (id_bien,date_vente,valeur_fonciere)
values (51,'2022-01-02',null)

select * from vente 
where valeur_fonciere is null

insert into bien 
(id_commune,no_voie,type_voie,indice_repetition,voie,nombre_piece,surface_carrez,surface_reelle_bati,type_local)
values
('35238',4,'pass','b','des carmélites',1,16,16,'Appartement')
