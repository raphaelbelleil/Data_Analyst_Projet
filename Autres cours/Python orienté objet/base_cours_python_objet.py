# Partie Rectangle

class Rectangle:
    lenght = 3
    height = 2

    def __init__(self, height, lenght, color='red'):
        self.height=height
        self.lenght=lenght
        self.color=color

    def calculate_area(self):
        return self.lenght * self.height

rect = Rectangle(4,5)
rect2 = Rectangle(2,6,'blue')

rect2.color = 'yellow'

area = rect2.calculate_area()

print(area)

print(rect.height)
print(rect2.color)


# Partie Cake


class Cake:

    def __init__(self, flavor):
        self.flavor = flavor

    def cut_in_part(self):
        print('Le gâteau est coupé en 4 parts !')


cake = Cake('chocolate')

print(cake.flavor)
cake.cut_in_part()


# Partie Bird

class Bird:
    """Un oiseau. 🐦"""

    # ici on utilise deux attributs de classe.
    names = ("mouette", "pigeon", "moineau", "hirrondelle")
    positions = {}

    def __init__(self, name):
        """Les attributs définis ici sont des attributs d'instance."""
        self.position = 1, 2
        self.name = name
        
        # On accède à l'attribut de classe "positions" avec self (c'est possible).
        self.positions[self.position] = self.name

    @classmethod
    def find_bird(cls, position):
        """Retrouve un oiseau selon la position donnée."""
        if position in cls.positions:
            return f"On a trouvé un {cls.positions[position]} !"

        return "On a rien trouvé..."


# On peut accéder aux variables de classe sans instanciation.
Bird.names
Bird.positions
print(Bird.find_bird((2, 5)))

# On instancie un oiseau
bird = Bird("mouette")

# On le retrouve avec la méthode find_bird.
print(Bird.find_bird((1, 2)))

oiseau= Bird('perroquet')
oiseau2= Bird('goeland')



print(Bird.positions)
print(Bird.names)