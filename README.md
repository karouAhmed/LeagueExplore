# LeagueExplore

LeagueExplore est une application iOS permettant aux utilisateurs de rechercher des ligues sportives et d'afficher les équipes associées à chaque ligue. Les utilisateurs peuvent parcourir les différentes ligues, voir les détails des équipes et en savoir plus sur leurs stades.

## Fonctionnalités

- **Recherche de Ligues :** Les utilisateurs peuvent rechercher des ligues sportives par nom.
- **Exploration des Équipes :** Une fois une ligue sélectionnée, les utilisateurs peuvent voir la liste des équipes associées, triées par ordre anti-alphabétique, en n'affichant qu'une équipe sur 2.
- **Détails des Équipes :** En sélectionnant une équipe, les utilisateurs peuvent voir des détails tels que le nom de l'équipe, le nom du stade et une description.
- **Autocomplétion :** La barre de recherche propose des suggestions d'autocomplétion basées sur les noms de ligues disponibles.

## Technologies Utilisées

- **SwiftUI :** Utilisé pour créer l'interface utilisateur réactive.
- **Combine :** Utilisé pour gérer les données asynchrones et les appels réseau.
- **API externe :** L'application utilise l'API de The Sports DB pour récupérer les données des ligues et des équipes.

## Captures d'Écran

<p align="center">
    <img src="Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20-%201.png" width="250" alt="Capture d'écran 1">
    <img src="Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20-%202.png" width="250" alt="Capture d'écran 2">
    <img src="Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20-%203.png" width="250" alt="Capture d'écran 3">
</p>


## Installation

1. **Cloner le Référentiel :** `git clone https://github.com/karouAhmed/LeagueExplore.git`
2. **Ouvrir le Projet :** `cd LeagueExplore` puis ouvrez le fichier `LeagueExplore.xcodeproj` dans Xcode.
3. **Installer les Dépendances :** Utilisez CocoaPods ou Swift Package Manager pour installer les dépendances si nécessaire.
4. **Configurer l'API :** Assurez-vous d'avoir la clé d'API de The Sports DB et configurez-la dans le fichier approprié.

## Utilisation

1. Lancez l'application sur votre simulateur ou appareil iOS.
2. Recherchez une ligue en utilisant la barre de recherche.
3. Sélectionnez une ligue dans la liste des suggestions pour afficher les équipes associées.
4. Sélectionnez une équipe pour voir les détails.


## Licence

Ce projet est sous licence MIT - voir le fichier [LICENSE](LICENSE) pour plus de détails.
