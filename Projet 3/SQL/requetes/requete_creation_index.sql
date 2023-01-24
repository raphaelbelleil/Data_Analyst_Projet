create index idx_id_bien on vente(id_bien);

create index idx_id_commune on bien(id_commune);

create index idx_id_departement on commune(id_departement);

create idx_id_region on departement(id_region);