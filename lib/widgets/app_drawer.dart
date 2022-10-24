import 'package:Task_Planner/models/category.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({
    Key? key,
  }) : super(key: key);

  var categories = [
    Category(name: 'Today', icon: Icons.today),
    Category(name: 'Inbox', icon: Icons.inbox),
    Category(name: 'Welcome', icon: Icons.waving_hand_sharp),
    Category(name: 'Work', icon: Icons.today),
    Category(name: 'Personal', icon: Icons.work),
    Category(name: 'Shopping', icon: Icons.shopping_cart_rounded),
    Category(name: 'Wish List', icon: Icons.hourglass_top),
    Category(name: 'Birthday', icon: Icons.cake),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            child: Center(
              child: Row(
                children: [
                  Expanded(
                    child: UserAccountsDrawerHeader(
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: Colors.deepPurpleAccent,
                        child: Text(
                          'A',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      currentAccountPictureSize: Size(60, 60),
                      accountName: Text(
                        'Abdalazeez Shahateet',
                        style: TextStyle(fontSize: 18),
                      ),
                      accountEmail: null,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(categories[index].icon),
                  title: Text(categories[index].name),
                );
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text(
              'Add List',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
