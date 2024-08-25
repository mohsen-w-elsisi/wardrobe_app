# Wardrobe

An app to help you manage your wardrobe. 

## How it works

1. Click the plus icon to add your clothes into the app. Take a picture and make sure to tick all the attributes that this item matches. Select the type of item it is and give it a neet nickname. 
2. At this stage, the app might prompt you to select the from a list of other item saved to the app, the items that this new item matches. Do so! This is at the heart of the app.
3. After saving your items, you can click the hanger icon at the bottom right corner and start the guided process to constructing a fancy outfit. 
4. If you like the outfit, bookmrak it to access it later at any timeby clicking the bookmark icon on the home screen.

## Building the app

the regular `Flutter build <target>` command should work perfectly. In case of issues concerning the app icon or name run: 

- If you're building for platforms other than Android, add the name of the platform as a key and set it to `true` in the `pubspec.yaml` under the `flutter_launcher_icons` key.
- `dart run flutter_launcher_icons`
- `dart run rename_app:main all="wardrobe"`

### target platforms 

The app has been specifically built and tested only on android phones. The app is not yet responsive on large screen such as tablet or laptop screens, thus while usable on such devices, the user experience would not be optimal. Technecally, there should not be any compatibillity issues with any of flutter's build targets except for sharing outfits on linux. 

