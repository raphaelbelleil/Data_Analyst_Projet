from datetime import datetime as dt

class File:

    def __init__(self, name, size):
        self.name = name
        self.size = size

    def display(self):
        print(self.name)



class Image(File):
    pass



class User : 

    userpwd = {}


    def __init__(self, username, password):
        self.username = username
        self.password = password
        self.userpwd[self.username]=self.password

    def login(self, username, password):
        if (self.username, self.password) in self.userpwd.items():
            print(f'Vous êtes bien connecté en tant que {self.username}')
        else :
            print('Erreur de connexion, réessayez')
        
    def post(self, thread, content, file=None):
        if file:
            post = FilePost(self, "aujourd'hui", content, file)
        else:
            post = Post(user=self, time_posted="aujourd'hui", content=content)
        thread.add_post(post)
        return post

    def make_thread(self, title, content):
        """Créé un nouveau fil de discussion."""
        post = Post(self, "aujourd'hui", content)
        return Thread(title, "aujourd'hui", post)

    def __str__(self):
        """représentation de l'utilisateur."""
        return self.username



class Moderator(User):

    def edit(self, post, content):
        # on fait référence à l'objet de class Post et à son attribut content
        post.content = content

    def delete(self, thread, post):
        index = thread.posts.index(post)
        del thread.posts[index]       



class Post :

    def __init__(self, user, content):
        self.user = user
        self.content = content
        self.time_posted = dt.now()

    def display(self):
        print(f"Message posté par {self.user} le {self.time_posted}:")
        print(self.content)


class FilePost (Post): 

    def __init__(self, user, content, file):
        self.user = user
        self.content = content
        self.time_posted = dt.now()
        self.file = file

    def display(self):
        # super() permet d'utiliser la méthode de la classe parente
        super().display()
        # on appelle la méthode diplay () de l'objet de classe File --> voir classe File
        self.file.display()




class Thread :

    def __init__(self, title, posts):
        self.title=title
        self.posts=[posts]
        self.time_posted = dt.now()

    def display(self):
        print("----- THREAD -----")
        print(f"titre: {self.title}, date: {self.time_posted}")
        print()
        # on affiche post avec la methode display associé à la classe Post
        for post in self.posts:
            post.display()
            print()
        print("------------------")

    def add_post(self, post):
        self.posts.append(post)

