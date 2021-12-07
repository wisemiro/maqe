import 'package:flutter/material.dart';
import 'package:maqe/nav-bar/AddBooking/ui/addBooking.dart';
import 'package:maqe/nav-bar/Bookings/ui/Bookings.dart';
import 'package:maqe/nav-bar/Persons/ui/persons.dart';
import 'package:maqe/nav-bar/home/ui/home.dart';
import 'package:maqe/nav-bar/user-profile/ui/profile.dart';
import 'package:maqe/theme/colors.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<Widget> _children = [];
  int _currentIndex = 0;

  @override
  // ignore: must_call_super
  initState() {
    _children.add(Home());
    _children.add(Booking());
    _children.add(AddBooking());
    _children.add(Persons());
    _children.add(UserProfile());
  }

  BottomNavigationBar _buildBottomNavigation() {
    return BottomNavigationBar(
      elevation: 25,
      onTap: _onTabTapped,
      selectedItemColor: MaqeColor.activeIconColor,
      unselectedItemColor: MaqeColor.deactiveIconColor,
      iconSize: 25.0,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: ''),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add_box,
            color: MaqeColor.activeIconColor,
          ),
          label: '',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.people_outline), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
      ],
      currentIndex: _currentIndex,
    );
  }

  _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }
}
