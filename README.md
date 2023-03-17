# FlutterEcommerceApp

The application MIAGED is an ecommerce application, where there is many product up for sale, the user can add and remove the products to his cart, change his profil informations and save everything to the firebase database.


![alt text](https://i.imgur.com/07bjhGF.png)

![alt text](https://i.imgur.com/VI19656.png)

![alt text](https://i.imgur.com/KHsluer.png)

![alt text](https://i.imgur.com/rRcw3XY.png)

![alt text](https://i.imgur.com/wlUYYl3.png)

![alt text](https://i.imgur.com/KBVunoL.png)



## Utilisateur de test
- login: Max
- Mot de passe: 123456



## MVP of the application

### US#1:[MVP] Interface de login
- [x] Interface de login composée d’un headerBar qui contient le nom de l’application, de deux champs et d’un bout
- [x] Les deux champs de saisie sont : Login et Password
- [x] Le champ de saisie du password est obfusqué
- [x] Le label du bouton est : Se connecter
- [x] Au clic sur le bouton « Se connecter », une vérification en base est réalisée. Si l’utilisateur existe, celui-ci est redirigé sur la page suivante
- [x] Au clic sur le bouton « Se connecter » avec les deux champs vides, l’application doit rester fonctionnelle

### US#2:[MVP] Liste de vêtements
- [x] l’utilisateur arrive sur cette page composée du contenu principal et d’une BottomNavigationBar composée de trois entrées et leurs icones correspondantes
- [x] La page actuelle est la page Acheter. Son icone et son texte sont d’une couleur différente des autres entrées
- [x] Une liste déroulante de tous les vêtements m’est proposé à l’écran
- [x] Chaque vêtement affiche les informations suivantes: Une image (ne pas gérer les images dans l’application, seulement insérer des liens vers des images d’internet), un titre , la taille, le prix.
- [x] Au clic sur une entrée de la liste, le détail est affiché.
- [x] Cette liste de vêtements est récupérée de la base de données.

### US#3:[MVP] Détail d’un vêtement 
- [x] La page de détail est composée des informations suivantes: une image, un titre, la taille, la marque, le prix.
- [x] La page est également composée d’un bouton « Retour ».

### US#4:[MVP] Le panier
- [x] Au clic sur le bouton « Panier », la liste des vêtements du panier de l’utilisateur est affichée avec les informations suivantes: Une. image (ne pas gérer les images dans l’application, seulement insérer des liens vers des images d’internet), un titre, la taille, le prix.
- [x]  Un total général est affiché à l’utilisateur (somme de tous les vêtements du panier)
- [x]  A droite de chaque vetement, une croix permet à l’utilisateur de retirer un produit. Au clic sur celle-ci, le produit est retiré de la liste et le total général mis à jour
- [x]  Aucun autre bouton d’action n’est présent sur la page (pas de paiement pour le moment)

### US#5: [MVP]Profil utilisateur
- [x] Au clic sur le bouton « Profil », les informations de l’utilisateur s’affichent.
- [x] Les informations sont : Le login (readonly), Le password , (offusqué) , L’anniversaire , L’adresse , Le code postal (affiche le clavier numérique et n’accepte que les chiffres) , La ville.
- [x] Un bouton « Valider » permet de sauvegarder les données (en base de données)
- [x] Un bouton « Se déconnecter » permet de revenir à la page de login


### US#6: Filtrer sur la liste des vêtements

- [ ] Sur la page « Acheter », une TabBar est présente, listant les différentes catégories de vêtements. 
- [ ] Par défaut, l’entrée « Tous » est sélectionnée et tous les vêtements sont affichés.
- [ ] Au clic sur une des entrées, la liste est filtrée pour afficher seulement les vêtements correspondants à la catégorie sélectionnée


### US#7 : Additional Function

- [x] possibilité d'ajout de description des produits.
- [x] l'utilisateur pourra utiliser une image de son téléphone/ordinateur pour l'uploader comme image du produit.

