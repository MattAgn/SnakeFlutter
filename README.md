# snake_game

A mobile and web snake game built with Flutter

## Deployment

### Web

To deploy on the web, you need the [firebase cli](https://firebaseopensource.com/projects/firebase/firebase-tools/) and be logged in to firebase account.

To build and deploy the flutter web app, run:

```bash
flutter build web && firebase deploy
```

### Android

Run at the root of the project:
```bash
cd android
bundle exec fastlane android_beta_app
```


### iOS

Not working yet because we need provisionning profiles