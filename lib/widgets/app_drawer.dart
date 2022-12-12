import 'package:Task_Planner/models/task_category.dart';
import 'package:Task_Planner/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/task_provider.dart';
import '../models/categories.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentCategory = Provider.of<TaskProvider>(
      context,
      listen: false,
    ).currentCategory;
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
              itemCount: Categories.categoriesList.length,//10
              itemBuilder: (context, index) {
                TaskCategory category = Categories.categoriesList[index];
                return InkWell(
                  onTap: () {},
                  child: Ink(
                    child: ListTile(
                      tileColor: category == currentCategory
                          ? Colors.blue.withOpacity(0.12)
                          : null,
                      onTap: () {
                        Provider.of<TaskProvider>(
                          context,
                          listen: false,
                        ).setCurrentCategory(category);

                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => HomeScreen(title: category.name),
                          ),
                        );
                      },
                      leading: Icon(
                        Categories.categoriesList[index].icon,
                        color: category == currentCategory
                            ? ThemeData().primaryColor
                            : null,
                      ),
                      title: Text(
                        Categories.categoriesList[index].name,
                        style: TextStyle(
                          color: category == currentCategory
                              ? ThemeData().primaryColor
                              : null,
                        ),
                      ),
                    ),
                  ),
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
