import 'package:flutter/material.dart';
import 'package:elice_flutter/constants.dart';
import 'package:elice_flutter/screen/home_screen.dart';
import 'package:elice_flutter/screen/qr_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List _widgetOptions = [
    HomeScreen(),
    QrScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Constants.appTitle,
          style: TextStyle(color: Colors.indigo),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                print("noti clicked!");
              },
              icon: const Icon(
                Icons.notifications_none_outlined,
                color: Colors.grey,
              ))
        ],
      ),
      body: Container(
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        currentIndex: _selectedIndex, //현재 선택된 Index
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home_outlined),
          ),
          BottomNavigationBarItem(
            label: 'QR',
            icon: Icon(Icons.qr_code),
          ),
        ],
      ),
    );
  }
}
