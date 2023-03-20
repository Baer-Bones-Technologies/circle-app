*Before adding to this library please consider and read the following:*

## Contents:
- [Introduction](#introduction)
  - [Getting Started](#getting-started)
  - [Codestyling](#codestyling)
  - [Folder Structure](#folder-structure)
  - [Git Workflow](#git-workflow)
  - [Link and Update in ClickUp](#link-and-update-in-clickup)

# Introduction

This is the official repository for Circle, a new social media catered to inner creators and influencer in the average person. This repository is written in primarily dart and flutter, with a few other languages sprinkled in. This repository is a work in progress, and is not yet ready for production.


## Getting Started
*This is a work in progress, and will be updated as we go along.*

## Codestyling
*This is a work in progress, and will be updated as we go along.*
 - Public functions and variables should **ALWAYS** be written in `camelCase` 
 - Public functions be notated above with a Doc comment (///) giving a short explanation of function.
 - In dart `private` variables and functions are annotated with an underscore (_) before the variable name. This is to differentiate between public and private variables. The keyword `private` does not exist in dart, and is not needed.
  
**Example:**
```dart

String _helloWorld = 'Hello World';

/// This function returns a 'Hello World' string.
String helloWorld() {
  return print(_helloWorld);
}
```



 - Before submitting a code review please run `flutter analyze` to check for any errors or warnings. If there are any errors or warnings please fix them before submitting a code review.

 - Be sure to format and optimize imports before submitting a code review. This can be done by running `flutter format .` and `flutter pub get` in the terminal.

- When writing a new widget, please use the `StatelessWidget` class instead of the `StatefulWidget` class. If you need to use the `StatefulWidget` class, please make sure to use the `ChangeNotifier` class to notify the widget of any changes.

 - When writing a new screen, add the screens folder with the screen name in snake_case. Then add a base class file as well as a mobile and web class file. The base class should use the `UIManager` class to retrieve the correct platform and return the correct widget.

**Example:**
```dart
// screens/home/home.dart

import 'package:circle/core/ui_manager.dart';
import 'package:circle/screens/home/home_mobile.dart';
import 'package:circle/screens/home/home_web.dart';
import 'package:flutter/material.dart';

/// Home screen
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //instantiate a UIManager object
    UIManager _ui = UIManager(context);

    //return the correct widget based on the platform
    return _ui.isMobile ? HomeMobile() : HomeWeb();
  }

  // Shared functions and variables should be placed here.
}
```

 - Constant variables should be instantiated as a `static const` variable. This is to make it easier to change the number in the future.

**Example:**
  - *Prompt: create 2 functions that check if a number is greater than 10 and returns false if the number is greater than 10. Then create a function that returns the number 10.* 
  
```dart
// correct example

static const double _maxCount = 10;

/// checks count
bool checkCount(int _count){
    if(_count > _maxCount){
        return false;
    }
    return true;
}

/// gets max count
int getMaxCount(){
    return _maxCount;
}

```
```dart

// incorrect example

/// checks count
bool checkCount(){
    if(_count > 10){
        return false;
    }
    return true;
}

/// gets max count
int getMaxCount(){
    return 10;
}

```

 - When writing a new widget, please use the `StatelessWidget` class instead of the `StatefulWidget` class. If you need to use the `StatefulWidget` class, please make sure to use the `ChangeNotifier` class to notify the widget of any changes.

 - When writing a new screen, add the screens folder with the screen name in snake_case. Then add a base class file as well as a mobile and web class file. The base class should use the `UIManager` class to retrieve the correct platform and return the correct widget.




## Folder Structure
*This is a work in progress, and will be updated as we go along.*

 - When creating new widgets, if the widget is only used in one screen, please add the widget to the screen folder. If the widget is used in multiple screens, please add the widget to the `libs/ui/common` folder as it's own file in order to keep widgets organized.

- Changes for navigation issues or additions should be made in the `libs/ui/navigation` folder in the appropriate file.
  - **No mobile fixes should be inside of the web folders, and vice versa**


## Git Workflow
*This is a work in progress, and will be updated as we go along.*
- Branches should be names by this structure: `feature/feature_name` or `bug/bug_name`

## Link and Update in ClickUp
*This is a work in progress, and will be updated as we go along.*
 - This team uses ClickUp for Project Management. Please link your branch to the appropriate task in ClickUp. If there is no task for the branch you are working on, please create a new task and link it to the branch.