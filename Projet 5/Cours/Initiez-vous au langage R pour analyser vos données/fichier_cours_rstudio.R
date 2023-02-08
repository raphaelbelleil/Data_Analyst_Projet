getwd()

help(mean)


x <- 2 # crée l’objet x en lui donnant la valeur 2
X = 4 # X reçoit la valeur 4
b = x # b reçoit la valeur x, soit ici 2
3 -> y # y reçoit la valeur 3


# pour charger le jeu de données iris
data("iris")

# pour voir les objets créés lors de la session
objects()

# supprimer un objet
rm(i)

# création et suppression de plusieurs objets
i=3
h=2
rm(i, h)


# type/mode d'objet
rien = NULL
temperature = 23.5
pluie = TRUE
tempete = F
station = 'Paris'
ville = "Corbeil-Essonnes"

# pour connaitre le mode de l'objet
mode(ville)

# pour tester l'appartenance à un mode
is.numeric(ville)

is.null(x)
is.logical(x)
is.numeric(x)
is.complex(x)
is.character(x)


# pour convertir un objet
as.logical(x)
as.numeric(x)
as.complex(x)
as.character(x)

# pour accéder aux attributs d'un objet
attributes(ville)

# pour savoir ou se trouve les valeurs manquantes d'un objet
is.na(ville)
