-- requete 1
-- 1. Nombre total d’appartements vendus au 1er semestre 2020
select distinct(count(v.id_bien)) as nombre_appartement_1er_semestre_2020
from
	vente v 
	inner join bien b
	on v.id_bien=b.id_bien
where type_local='Appartement' and date_vente between '2020-01-01' and '2020-06-30';


-- requete 2
-- 2. Le nombre de ventes d’appartement par région pour le 1er semestre 2020
select 
	nom_region, count(id_vente) as nb_vente_par_region
from 
	vente v 
	inner join bien b
	on v.id_bien=b.id_bien
	inner join commune com
	on b.id_commune=com.id_commune
	inner join departement d
	on com.id_departement=d.id_departement
	inner join region r
	on d.id_region=r.id_region
where date_vente between '2020-01-01' and '2020-06-30'
group by nom_region
order by nb_vente_par_region desc;


-- requete 3
-- 3. Proportion des ventes d’appartements par le nombre de pièces.
select nombre_piece, count(id_vente) as nombre_vente, 
round((100.00*count(id_vente)/(select count(id_vente) 
	from vente v 
	inner join bien b
	on v.id_bien=b.id_bien where type_local = 'Appartement' ))::numeric,2) as proportion_vente
from 
	vente v 
	inner join bien b
	on v.id_bien=b.id_bien
where type_local = 'Appartement'
group by nombre_piece
order by nombre_piece;

select count(id_vente) from vente
-- requete 4
-- 4. Liste des 10 départements où le prix du mètre carré est le plus élevé.
select 
	nom_departement,
	round(avg(valeur_fonciere/surface_carrez)::numeric,2) as moyenne_prix_m2
from 
	vente v 
	inner join bien b
	on v.id_bien=b.id_bien
	inner join commune com
	on b.id_commune=com.id_commune
	inner join departement d
	on com.id_departement=d.id_departement
group by nom_departement
order by moyenne_prix_m2 desc
limit 10;


-- requete 5
-- 5. Prix moyen du mètre carré d’une maison en Île-de-France.
select 
	nom_region, type_local, 
	round(avg(valeur_fonciere/surface_carrez)::numeric,2) as moyenne_prix_m2
from 
	vente v 
	inner join bien b
	on v.id_bien=b.id_bien
	inner join commune com
	on b.id_commune=com.id_commune
	inner join departement d
	on com.id_departement=d.id_departement
	inner join region r
	on d.id_region=r.id_region
where nom_region='ILE-DE-FRANCE' and type_local='Maison'
group by nom_region, type_local;


-- requete 6
-- 6. Liste des 10 appartements les plus chers avec la région et le nombre 
-- de mètres carrés.
select 
	concat(no_voie,' ', type_voie,' ', indice_repetition,' ', voie,' ',nom_commune) as adresse,
	nom_region, type_local, surface_carrez, cast(valeur_fonciere as bigint)
from 
	vente v 
	inner join bien b
	on v.id_bien=b.id_bien
	inner join commune com
	on b.id_commune=com.id_commune
	inner join departement d
	on com.id_departement=d.id_departement
	inner join region r
	on d.id_region=r.id_region
where 
	type_local='Appartement' and valeur_fonciere is not null
order by valeur_fonciere desc
limit 10;


-- requete 7
-- 7. Taux d’évolution du nombre de ventes entre le premier et le second trimestre de 2020.
select 
	cast(count(vente_2e_trimestre.id_vente) as numeric) as nb_vente_2e_trimestre,
	cast(count(vente_1er_trimestre.id_vente) as numeric) as nb_vente_1er_trimestre,
	round((100.0*count(vente_2e_trimestre.id_vente)/count(vente_1er_trimestre.id_vente))-100::numeric,2) as taux_evolution
from 
	(select * from vente
	where date_vente<'2020-04-01') as vente_1er_trimestre
full join 
	(select * from vente
	where date_vente>='2020-04-01') as vente_2e_trimestre
on vente_1er_trimestre.id_vente= vente_2e_trimestre.id_vente;


-- requete 8
-- 8. Le classement des régions par rapport au prix au mètre carré des appartement de plus de 4 pièces.
select 
	nom_region, type_local,
	round(avg(valeur_fonciere/surface_carrez)::numeric,2) as moyenne_prix_m2
from 
	vente v 
	inner join bien b
	on v.id_bien=b.id_bien
	inner join commune com
	on b.id_commune=com.id_commune
	inner join departement d
	on com.id_departement=d.id_departement
	inner join region r
	on d.id_region=r.id_region
where 
	type_local='Appartement' and nombre_piece>4
group by 
	nom_region, type_local
order by 
	moyenne_prix_m2 desc;
	

-- requete 9
-- 9. Liste des communes ayant eu au moins 50 ventes au 1er trimestre
select 
	nom_commune, count(*) as nb_vente
from 
	vente v 
	inner join bien b
	on v.id_bien=b.id_bien
	inner join commune com
	on b.id_commune=com.id_commune
where 
	date_vente between '2020-01-01' and '2020-03-31'
group by nom_commune
having count(id_vente)>50
order by nb_vente desc;


-- Requete 10
-- 10. Différence en pourcentage du prix au mètre carré entre un appartement de 2 pièces et un appartement de 3 pièces.

select 
	round(avg(vente_2_pieces.valeur_fonciere/vente_2_pieces.surface_carrez)::numeric,2) as moyenne_prix_m2_2_pieces,
	round(avg(vente_3_pieces.valeur_fonciere/vente_3_pieces.surface_carrez)::numeric,2) as moyenne_prix_m2_3_pieces,
	round((100.0*(avg(vente_3_pieces.valeur_fonciere/vente_3_pieces.surface_carrez))/(avg(vente_2_pieces.valeur_fonciere/vente_2_pieces.surface_carrez))-100)::numeric,2) as difference_en_pourcentage_prix_3_pieces_par_rapport_2_pieces
from
	(select *
	from 
		vente v 
		inner join bien b
		on v.id_bien=b.id_bien
	where nombre_piece = 2 and type_local='Appartement') as vente_2_pieces
full join
	(select *
	from 
		vente v 
		inner join bien b
		on v.id_bien=b.id_bien
	where nombre_piece = 3 and type_local='Appartement') as vente_3_pieces
on vente_2_pieces.id_vente=vente_3_pieces.id_vente;

-- requete 11
-- 11. Les moyennes de valeurs foncières pour le top 3 des communes des départements 6, 13, 33, 59 et 69.

select * from
(
	select
		d.id_departement, nom_departement, nom_commune, round(avg(valeur_fonciere)::numeric,2) as moyenne_valeur_fonciere,
		rank()
			over(partition by nom_departement order by avg(valeur_fonciere) desc) as classement
	from 
		vente v 
		inner join bien b
		on v.id_bien=b.id_bien
		inner join commune com
		on b.id_commune=com.id_commune
		inner join departement d
		on com.id_departement=d.id_departement
	where d.id_departement in ('006','013','033','059','069')
	group by d.id_departement, nom_departement, nom_commune
	order by nom_departement) as requete_classement
	
where classement <=3;


-- requete 12
-- 12. Les 20 communes avec le plus de transactions pour 1000 habitants pour 
-- les communes qui dépassent les 10 000 habitants.
select 
	nom_commune, count(id_vente) as nb_vente, population, 
	round(1000.0*count(id_vente)/population::numeric,2) as nb_transaction_pour_1000_habitants
from 
	vente v 
	inner join bien b
	on v.id_bien=b.id_bien
	inner join commune com
	on b.id_commune=com.id_commune
where population > 10000
group by nom_commune, population
order by nb_transaction_pour_1000_habitants desc
limit 20;