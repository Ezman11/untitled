import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _subPageIndex = 0;
  var _selectedBottomNavIndex = 0;
  var _profile = 'assets/images/profile.png';
  var _name = 'Nattapong Kunlapong';
  var _email = 'Nattapong@gmail.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(40.0),
                      child: Container(
                        width: 80.0,
                        height: 80.0,
                        child: Image.asset(_profile),
                      )
                  ),
                  Text(
                    _name,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    _email,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ),
            ListTile(
              title: _buildDrawerItem(Icon(Icons.fastfood,color: _subPageIndex == 0 ? Colors.blue : Colors.black ,), 'Food'),
              onTap: () => _showSubPage(0),
              selected: _subPageIndex == 0,
            ),
            ListTile(
              title: _buildDrawerItem(Icon(Icons.person,color: _subPageIndex == 1 ? Colors.blue : Colors.black ,), 'Profile'),
              onTap: () => _showSubPage(1),
              selected: _subPageIndex == 1,
            ),
          ],
        ),
      ),
      bottomNavigationBar: _subPageIndex == 0 ? BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Your Order',
          ),
        ],
        currentIndex: _selectedBottomNavIndex,
        onTap: (index) {
          setState(() {
            _selectedBottomNavIndex = index;
          });
        },
      ):null,
      body: Container(
        child: _buildSubPage(),
      ),
    );
  }

  _showSubPage(int index) {
    setState(() {
      _subPageIndex = index;
    });
    Navigator.of(context).pop();
  }

  Widget _buildSubPage() {
    switch (_subPageIndex) {
      case 0: // home page
        return _selectedBottomNavIndex == 0? Center(
          child: Text('FOOD MENU ',
              style: Theme.of(context).textTheme.headline1),
        ) : Center(
          child: Text('YOUR ORDER ',
              style: Theme.of(context).textTheme.headline1),
        );
      case 1:
        return Profile();
      default:
        return SizedBox.shrink();
    }
  }

  Row _buildDrawerItem(Widget icon, String title) {
    return Row(
      children: [
        icon,
        SizedBox(width: 8.0),
        Text(title),
      ],
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _profile = 'assets/images/profile.png';
    var _name = 'Nattapong Kunlapong';
    var _email = 'Nattapong@gmail.com';
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Container(
                  //color: Colors.red,
                  width: 200.0,
                  height: 200.0,
                  child: Image.asset(_profile ,),
                )
            ),

            Text(_name ,style: Theme.of(context).textTheme.headline1,),

            Text(_email),
          ],
        ),
      ),
    );
  }
}