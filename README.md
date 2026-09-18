# Moi Église TV 📺🙏

**Moi Église TV** est une application mobile de live streaming développée avec Flutter, conçue pour offrir une expérience spirituelle immersive. Elle permet aux fidèles de suivre des cultes, des événements et des émissions en direct depuis leur smartphone.

## 🌟 Fonctionnalités Principales

- **Live Streaming HLS :** Diffusion en direct fluide et de haute qualité grâce au lecteur vidéo avancé intégré.
- **Écran de Démarrage Animé :** Une expérience utilisateur engageante dès le lancement avec des animations (Lottie).
- **Mode Éveil (Wakelock) :** L'écran de votre téléphone reste allumé de manière ininterrompue pendant que vous regardez le direct.
- **Partage Facile :** Partagez les moments forts ou l'application avec vos proches en un seul clic.
- **Interface Utilisateur Moderne :** Design soigné utilisant Material Design et des polices personnalisées (Lobster, Montserrat).
- **Accès Rapides :** Liens directs vers des ressources ou des pages externes pertinentes.

## 🛠 Technologies Utilisées

Ce projet est développé avec le SDK [Flutter](https://flutter.dev/) et utilise le langage Dart.

**Dépendances clés :**
- `video_player` & `chewie` : Gestion du lecteur vidéo et lecture du flux réseau (HLS).
- `share_plus` : Partage natif de contenus.
- `animated_splash_screen` & `lottie` : Gestion du splash screen et des animations.
- `wakelock_plus` : Empêche l'appareil de se mettre en veille pendant la lecture vidéo.
- `url_launcher` : Ouverture de liens externes depuis l'application.

## 🚀 Comment Lancer le Projet

### Prérequis
Assurez-vous d'avoir installé les outils suivants sur votre machine :
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (version >=3.0.0)
- Un émulateur (Android/iOS) ou un appareil physique configuré pour le débogage.

### Installation

1. **Cloner le dépôt :**
   ```bash
   git clone https://github.com/votre-nom-utilisateur/moi_eglise_tv.git
   cd moi_eglise_tv
   ```

2. **Installer les dépendances :**
   ```bash
   flutter pub get
   ```

3. **Lancer l'application :**
   ```bash
   flutter run
   ```

## 📱 Captures d'écran

*(Ajoutez ici quelques captures d'écran de votre application pour illustrer l'interface au grand public sur GitHub).*
<!-- Exemple : <img src="chemin/vers/image.png" width="250" /> -->

## 🤝 Contribution

Les contributions sont les bienvenues ! Pour proposer une amélioration ou corriger un bug :
1. Forkez le projet.
2. Créez votre branche de fonctionnalité (`git checkout -b feature/NouvelleFonctionnalite`).
3. Commitez vos changements (`git commit -m 'Ajout d'une nouvelle fonctionnalité'`).
4. Poussez vers la branche (`git push origin feature/NouvelleFonctionnalite`).
5. Ouvrez une Pull Request.

## 📄 Licence
 MIT License
