import 'package:Task_Planner/Providers/current_category_page_provider.dart';
import 'package:Task_Planner/models/category.dart';
import 'package:Task_Planner/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:Task_Planner/constants.dart';
import 'package:provider/provider.dart';

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
              itemCount: Categories.categoriesList.length,
              itemBuilder: (context, index) {
                Category category = Categories.categoriesList[index];
                return Ink(
                  child: ListTile(
                    onTap: () {
                      Provider.of<CurrentCategoryPageProvider>(
                        context,
                        listen: false,
                      ).setCurrentCategory(category);

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => HomeScreen(title: category.name),
                        ),
                      );
                      // print(
                      //   Provider.of<CurrentCategoryPageProvider>(
                      //     context,
                      //     listen: false,
                      //   ).currentCategory.name,
                      // );
                    },
                    leading: Icon(Categories.categoriesList[index].icon),
                    title: Text(Categories.categoriesList[index].name),
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
