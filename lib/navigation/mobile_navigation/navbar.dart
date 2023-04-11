import 'dart:collection';

import 'package:circle/resources/theme.dart';
import 'package:circle/ui/screens/create/create.dart';
import 'package:circle/ui/screens/explore/explore.dart';
import 'package:circle/ui/screens/home/home.dart';
import 'package:circle/ui/screens/notifications/notifications.dart';
import 'package:circle/ui/screens/profile/Profile.dart';
import 'package:circle/ui/ui_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// This is a the bottom navigation bar used within the app

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);
  final Map<Icon, String> _widgetOptions = {
    const Icon(Icons.home, color: CupertinoColors.white): '/',
    const Icon(Icons.explore, color: CupertinoColors.white): '/explore',
    const Icon(Icons.add, color: CupertinoColors.white): '/create',
    const Icon(Icons.notifications, color: CupertinoColors.white):
        '/notifications',
    const Icon(Icons.person, color: CupertinoColors.white): '/profile',
  };

  @override
  Widget build(BuildContext context) {
    UIManager ui = UIManager(context);
    return Container(
        height: 60,
        width: ui.getMaxWidth(),
        color: CircleTheme.primary,
        child: _navigationBar(ui)
    );
  }

    Widget _navigationBar(UIManager uiManager){
      return  Row(
          children: _widgetOptions.keys
              .map((Icon icon) => GestureDetector(
            onTap: () {
                _selectedIndex.value = _widgetOptions.keys.toList().indexOf(icon);
                if (Navigator.defaultRouteName != _widgetOptions.values.toList()[_selectedIndex.value]) {
                  context.go(
                      _widgetOptions.values.toList()[_selectedIndex.value]);
                }
            },
            child: Container(
              width: uiManager.getMaxWidth() / _widgetOptions.length,
              height: 60,
              decoration: BoxDecoration(
                color: _selectedIndex.value == _widgetOptions.keys.toList().indexOf(icon) ? CircleTheme.tertiary : CircleTheme.primary,
                border: Border(
                  top: BorderSide(
                    color: _selectedIndex.value == _widgetOptions.keys.toList().indexOf(icon) ? CircleTheme.primaryGradientColor : Colors.transparent,
                    width: 3,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Icon(
                      icon.icon,
                      color: _selectedIndex.value == _widgetOptions.keys.toList().indexOf(icon) ? CircleTheme.primaryGradientColor : Colors.white,
                    )
                ],
              ),
            ),
          ))
              .toList());
    }
  }
