# Brew-Cafe-Flutter-App


### Change app launch icon:
dev_dependencies: 
  flutter_test:
    sdk: flutter

  flutter_launcher_icons: "^0.6.1"

flutter_icons:
  image_path: "icon/icon.png" 
  android: true
  ios: true
Prepare an app icon for the specified path. e.g. icon/icon.png

Execute command on the terminal to Create app icons:

$ flutter pub get

$ flutter pub pub run flutter_launcher_icons:main
