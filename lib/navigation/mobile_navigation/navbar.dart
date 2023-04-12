import 'package:circle/navigation/router.dart';
import 'package:circle/resources/theme.dart';
import 'package:circle/ui/ui_manager.dart';
import 'package:circle/utility/auth_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  User? user = AuthenticationHandler().user;

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
        child: _navigationBar(ui).value);
  }

  ValueNotifier<Widget> _navigationBar(UIManager uiManager) {
    _widgetOptions.values.elementAt(4).replaceRange(
        0,
        _widgetOptions.values.elementAt(4).length - 1,
        '/profile/${user?.uid}'); // Profile link
    return ValueNotifier(Row(
        children: _widgetOptions.keys
            .map((Icon icon) => GestureDetector(
                  onTap: () {
                    selectedIndex.value =
                        _widgetOptions.keys.toList().indexOf(icon);
                    context.go(selectedIndex.value ==
                            _widgetOptions.values.toList().indexOf('/profile')
                        ? "${_widgetOptions.values.toList()[selectedIndex.value]}/${user?.uid}"
                        : _widgetOptions.values.toList()[selectedIndex.value]);
                  },
                  child: Container(
                    width: uiManager.getMaxWidth() / _widgetOptions.length,
                    height: 60,
                    decoration: BoxDecoration(
                      color: selectedIndex.value ==
                              _widgetOptions.keys.toList().indexOf(icon)
                          ? CircleTheme.tertiary
                          : CircleTheme.primary,
                      border: Border(
                        top: BorderSide(
                          color: selectedIndex.value ==
                                  _widgetOptions.keys.toList().indexOf(icon)
                              ? CircleTheme.primaryGradientColor
                              : Colors.transparent,
                          width: 3,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icon.icon,
                          color: selectedIndex.value ==
                                  _widgetOptions.keys.toList().indexOf(icon)
                              ? CircleTheme.primaryGradientColor
                              : Colors.white,
                        )
                      ],
                    ),
                  ),
                ))
            .toList()));
  }
}
