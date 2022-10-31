import 'package:flutter/material.dart';
import 'package:Task_Planner/constants.dart' as constants;

class AppDrawer extends StatelessWidget {
  AppDrawer({
    Key? key,
  }) : super(key: key);

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
              itemCount: constants.categoriesList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(constants.categoriesList[index].icon),
                  title: Text(constants.categoriesList[index].name),
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
