create view tableau_vente_multiple as 
(with vente_multiple_meme_bien as
	(select id_bien, count(id_bien) as nb_de_vente 
	from vente
	group by id_bien
	having count(id_bien)>1
	order by nb_de_vente desc
	), 
	
	adresse_mise_en_forme as 
	(select id_bien, concat(no_voie,' ',type_voie,' ',indice_repetition,' ',voie,', ',nom_commune,', ',nom_departement,', ',nom_region) as adresse 
	from bien b
	inner join commune co
	on b.id_commune=co.id_commune
	inner join departement d
	on co.id_departement=d.id_departement
	inner join region r
	on d.id_region=r.id_region)
	
	select vm.id_bien, adresse, nb_de_vente 
	from bien b
	inner join vente_multiple_meme_bien vm
	on b.id_bien=vm.id_bien
	inner join adresse_mise_en_forme ad
	on b.id_bien=ad.id_bien
	order by nb_de_vente desc);
	
create view tableau_vente_multiple_detail as 
select v.id_bien, adresse, valeur_fonciere, date_vente
from tableau_vente_multiple tv
right join vente v
on tv.id_bien=v.id_bien
where nb_de_vente>1
order by nb_de_vente desc;

