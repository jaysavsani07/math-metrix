

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/jaysavsani07/math-metrix">
    <img src="android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png">
  </a>

  <h3 align="center">Math Matrix : Train Your Brain, Improve Math Skill</h3>

  <p align="center">
    <a href="https://apps.apple.com/us/app/math-matrix-a-math-game/id1511125332?ls=1"><img src="https://github.com/Volorf/Badges/blob/master/App%20Store/App%20Store%20Badge.png" height="60" alt="App Store" title="Math Matrix"/></a>
    <a href="https://play.google.com/store/apps/details?id=com.nividata.mathmatrix"><img src="https://github.com/Volorf/Badges/blob/master/Google%20Play/Google%20Play%20Badge.png" height="60" alt="Google Play" title="Math Matrix"/></a>
  </p>
</p>

  <h3 align="center">Try our new Math Riddle Game</h3>
  <p align="center">
    <a href="https://github.com/nividata-consultancy/math-riddle-free"><img src="screenshots/Math-Riddle_Banner.png" height="120" alt="Github" title="Math Riddle"/></a>
  </p>
<h3 align="center">Math Matrix is a Math Game that tries to improvise your math skills in a fun way.</h3>
<br />

| <img src="screenshots/1.webp"> | <img src="screenshots/2.webp"> | <img src="screenshots/3.webp"> | <img src="screenshots/6.webp">  | <img src="screenshots/5.webp"> | <img src="screenshots/7.webp"> |
|:-------------------------------------------------------------------------------------------:|:---:|:---:|:---:|:---:|:---:|

Simple math games to learn, improve you math skills. This game is easy to play and target everyone from kids to adults. Every level is design in a way to challenge your mind at every step. 

## This game is divided in 3 main categories 

**Math Puzzle** - This category revolves around basic calculation like addition, subtraction, division and multiplication. Each game in this category includes simple calculation with different approach. So you're playing with numbers and signs while fighting with time.

**Memory Puzzle** - This category focuses on not just calculation but to memorize numbers and signs before applying calculation to them. It tries to engage you in a way to solve this calculation with recalling numbers and signs in gradual manner.

**Train Your Brain** - Train your Brain tries to enhance your logical thinking with keeping time in mind. There can single or multiple ways to reach your query but you need to find best possible ways to earn best score.

Overall all this puzzle tries to engage you in a different way to improve your memory, attention, speed, reaction, concentration, logic and more. With each level it becomes more and more complex and try to take best out of you.

### Games in Math Puzzle
**1) Calculator** : A simple calculation of addition, subtraction, division and multiplication. You'll be given an equation and you need to find correct answer in 5 seconds.<br />
**2) Guess the sign** : You need to complete equation by placing correct sign between two numbers to reach to the given answer. <br />
**3) Correct Answer** : You'll be given 4 options and one incomplete equation with answer. You need to place correct number to complete given equation.<br />
**4) Quick Calculation** : It's same like calculator where you need to perform basic equation but you're racing with time.Faster you answer, more time will be given and more equation you can solve .You need to fight with time to reach to break your own high score.

### Games in Memory Puzzle
**1) Mental Arithmetic** : Numbers and signs will be shown one by one for few seconds, you need to remember those and give correct answer. This focuses on your memory and calculation at same time.<br />
**2) Square Root** : You need to find Square root of number for given options. With each increasing level you'll be having tough equation to solve.<br />
**3) Mathematical pairs** : One card have equation while other card have correct answer, but this will be places randomly in Grid. You need to select equation and correct answer to remove it from Grid.<br />
**4) Math Grid** : You'll be given an answer and a 9x9 grid. You need to select numbers from grid one by one to reach the given number. Find the best possible way to solve max answer from 9x9 grid.<br />

### Games in Train Your Brain
**1) Magic Triangle** : This is 3x3 and 4x4 triangle where you need to place 6 number in a way that sum of each side should be equal to given number.<br />
**2) Picture Puzzle** : Each shape represents a number. You need find number related to each shape and solve the last equation.<br />
**3) Number Pyramid** : In a number pyramid, the numbers on the lower layers determine the numbers above them. Sum of two consecutive cell would be placed on top cell.<br />

## ⚠️ Warning: This Repository is for Learning Purposes Only ⚠️
Dear users,

We would like to emphasize that this repository is intended for educational and learning purposes only. It is not meant to be directly used to create or update applications for commercial use, including publishing on app stores like the Android Play Store and/or App Store.

Please note the following:

1. **Educational Use Only**: The code and resources provided here are designed to help learners understand concepts and improve their skills.

2. **Avoid Plagiarism**: Copying and submitting code from this repository as your own for academic or professional purposes is considered plagiarism. Make sure to use the knowledge gained here to build your own unique projects.

3. **Commercial Usage Prohibited**: You are strictly prohibited from using this code to create apps for commercial purposes, including but not limited to monetization through app stores, advertisements, or any other revenue-generating means.

4. **Contribution Guidelines**: If you wish to contribute to this project, please review the guidelines provided in the repository. Contributions should align with the educational and learning focus of this project.

If you have any questions or concerns about the usage of this repository, please feel free to reach out to us via [Nividata Consultancy](https://www.nividata.com/contact/).

Thank you for your understanding and cooperation in maintaining the educational integrity of this project.


## Crashlytics and Analytics
To enable Firebase Crashlytics and Analytics, do the following:

1. Create a new project in
   [console.firebase.google.com](https://console.firebase.google.com/).
   Call the Firebase project whatever you like; just **remember the name**.
   You don't need to enable Analytics in the project if you don't want to.
2. [Install `firebase-tools`](https://firebase.google.com/docs/cli?authuser=0#setup_update_cli)
   on your machine.
3. [Install `flutterfire` CLI](https://firebase.flutter.dev/docs/cli#installation)
   on your machine.
4. In the root of this project (the directory containing `pubspec.yaml`),
   run the following:
    - `flutterfire configure`
        - This command asks you for the name of the Firebase project
          that you created earlier, and the list of target platforms you support.
          As of April 2022, only `android` and `ios` are fully
          supported by Crashlytics.
        - The command rewrites `lib/firebase_options.dart` with
          the correct code.
5. Go to `lib/main.dart` and uncomment the lines that relate to Crashlytics and Analytics.

You should now be able to see crashes, errors, and
severe log messages in
[console.firebase.google.com](https://console.firebase.google.com/).
To test, add a button to your project, and throw whatever
exception you like when the player presses it.

```dart
TextButton(
  onPressed: () => throw StateError('whoa!'),
  child: Text('Test Crashlytics'),
)
```

## Built With
This application built [Flutter](https://flutter.dev/). Flutter is cross-platform open source mobile framework built by Google. Flutter use Dart as a primary language which is highly scalable and easy codebase.
* [Getting started with Flutter](https://flutter.dev/docs).
* [Dart](https://dart.dev/)

<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/jaysavsani07/math-metrix/issues) for a list of proposed features (and known issues).


<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<!-- CONTACT -->
## Contact

[Nividata Consultancy](https://www.nividata.com/contact/)

## Developer

[Mehul Makwana](https://www.linkedin.com/in/mehul-makwana-430326b9/)

<!-- ACKNOWLEDGEMENTS -->
## This app using following awesome open source libraries

* [provider](https://pub.dev/packages/provider)
* [vsync_provider](https://pub.dev/packages/vsync_provider)
* [get_it](https://pub.dev/packages/get_it)
* [shared_preferences](https://pub.dev/packages/shared_preferences)
* [flutter_svg](https://pub.dev/packages/flutter_svg)
* [tuple](https://pub.dev/packages/tuple)
* [package_info](https://pub.dev/packages/package_info)
