import 'package:flutter/material.dart';
import 'package:quick_cook/screens/HomePage.dart';
import 'package:quick_cook/screens/UserPage.dart';
import 'package:quick_cook/utils/colors.dart';
import 'package:quick_cook/utils/globals.dart';

class FavoriteRecipes extends StatefulWidget {
  const FavoriteRecipes({super.key});

  @override
  State<FavoriteRecipes> createState() => _FavoriteRecipesState();
}

class _FavoriteRecipesState extends State<FavoriteRecipes> {
  int _selectedIndex = 1;

  void onItemTapped(int index) async {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
      if (index == 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else if (index == 1) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FavoriteRecipes()),
        );
      } else if (index == 2) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FavoriteRecipes()),
        );
      } else if (index == 3) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UserPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.color1,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded),
              color: AppColors.color3,
              iconSize: 20,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Favori Tarifler',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: AppColors.color3,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: favoriteRecipes.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: ListTile(
                    leading: Image.network(
                      favoriteRecipes[index]['image']!,
                      width: 80,
                    ),
                    title: Text(favoriteRecipes[index]['title']!),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          favoriteRecipes.removeAt(index);
                        });
                      },
                      icon: Icon(
                        Icons.delete_outline_outlined,
                        color: AppColors.color1,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: NavigationBar(
            height: 65,
            elevation: 0,
            backgroundColor: Colors.white,
            indicatorColor: Color.fromARGB(255, 182, 47, 79).withOpacity(0.2),
            selectedIndex: _selectedIndex,
            onDestinationSelected: onItemTapped,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            destinations: [
              NavigationDestination(
                icon: Icon(
                  Icons.home_outlined,
                  color:
                      _selectedIndex == 0 ? AppColors.color1 : Colors.grey[700],
                ),
                selectedIcon: Icon(Icons.home, color: AppColors.color1),
                label: "Ana Sayfa",
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.favorite_border_rounded,
                  color:
                      _selectedIndex == 1 ? AppColors.color1 : Colors.grey[700],
                ),
                selectedIcon: Icon(Icons.favorite, color: AppColors.color1),
                label: "Favori Tarifler",
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.auto_fix_high_outlined,
                  color:
                      _selectedIndex == 2 ? AppColors.color1 : Colors.grey[700],
                ),
                selectedIcon: Icon(
                  Icons.auto_fix_high,
                  color: AppColors.color1,
                ),
                label: "Rastgele Tarif",
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.person_outline,
                  color:
                      _selectedIndex == 3 ? AppColors.color1 : Colors.grey[700],
                ),
                selectedIcon: Icon(Icons.person, color: AppColors.color1),
                label: "Profil",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
