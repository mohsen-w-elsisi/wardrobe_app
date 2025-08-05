# Wardrobe

An app to help you manage your wardrobe, and put togther outfits quickly

## Features

1. saving cloth item, and matching them together
2. guided outfit creation
3. bookmarking favourite outfits
4. tagging items as sporty, on fasion, and classic, then being able to filter using tags while creating outfits.
5. attaching a season to clothes, hiding them when its too hot or cold
6. search
7. importing and exporting wardrobes
8. dynamic color theming to match system theme

## Building the app

the regular `Flutter build <target>` command should work perfectly. In case of issues concerning the app icon or name:

- If you're building for platforms other than Android, add the name of the platform as a key and set it to `true` in the `pubspec.yaml` under the `flutter_launcher_icons` key.
- run `dart run flutter_launcher_icons`
- run `dart run rename_app:main all="wardrobe"`

### target platforms

The app has been specifically built and tested only on android phones. The app is not yet responsive on large screen such as tablet or laptop screens, thus while usable on such devices, the user experience would not be optimal. Technecally, there should not be any compatibillity issues with any of flutter's build targets except for sharing outfits on linux.
