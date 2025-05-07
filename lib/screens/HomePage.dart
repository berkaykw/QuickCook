// ignore_for_file: unnecessary_nullable_for_final_variable_declarations, prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';
import 'package:quick_cook/screens/FavRecipes.dart';
import 'package:quick_cook/screens/TarifDetailPage.dart';
import 'package:quick_cook/screens/UserPage.dart';
import 'package:quick_cook/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quick_cook/utils/globals.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String headerText = "Elinizdeki malzemeler ile yemek pişirin.";
  final String subtitle =
      "Yapabileceğiniz tarifleri keşfetmek için malzemelerinizi girin.";
  int _selectedIndex = 0;
  String username = "Yükleniyor...";

  final TextEditingController _malzemeController = TextEditingController();
  List<String> malzemeler = [];
  List<dynamic> _recipes = [];

  final List<Widget> navigationBarScreens = [
    HomePage(),
    FavoriteRecipes(),
    FavoriteRecipes(),
    UserPage(),
  ];

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        DocumentSnapshot userDoc =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get();

        if (userDoc.exists) {
          setState(() {
            username = userDoc['username'] ?? "Kullanıcı adı bulunamadı";
          });
        } else {
          setState(() {
            username = "Kullanıcı kaydı bulunamadı";
          });
        }
      } else {
        setState(() {
          username = "Giriş yapılmamış";
        });
      }
    } catch (e) {
      print("Hata oluştu: $e");
      setState(() {
        username = "Hata oluştu";
      });
    }
  }

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

  Future<void> fetchRecipes(String ingredients) async {
    String apiKey = '3b8a08da94fd40e68181d23ef0e448ff';

    final url = Uri.parse(
      'https://api.spoonacular.com/recipes/findByIngredients?ingredients=$ingredients&number=20&apiKey=$apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        _recipes = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.color4,
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
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.menu, color: AppColors.color3),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
            centerTitle: true,
            title: Text(
              'Malzemelere Göre Tarif Ara',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: AppColors.color3,
              ),
            ),
          ),
        ),
      ),
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: AppColors.color5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      'https://play-lh.googleusercontent.com/8OkZHhe9B39oVMR6K1nYJXfWn6lbmlb9yUEYJr3ULgF0ZiI5ZEmq_AIJncsvscoXCh0=w526-h296-rw',
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Hoş Geldiniz, $username",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Ana Sayfa'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Ayarlar'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Çıkış Yap'),
              onTap: () async {},
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15.0, top: 15.0),
              child: Text(
                headerText,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.color5,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0, top: 5.0, bottom: 10.0),
              child: Text(
                subtitle,
                style: TextStyle(fontSize: 16, color: AppColors.color5),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                controller: _malzemeController,
                decoration: InputDecoration(
                  labelText: 'Malzemeleri girin',
                  labelStyle: TextStyle(color: AppColors.color2),
                  prefixIcon: Icon(Icons.add, color: AppColors.color2),
                  filled: true,
                  fillColor: Colors.grey[100],
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.color2, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                        AppColors.color4,
                      ),
                      padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 4.5,
                          vertical: MediaQuery.of(context).size.height / 85,
                        ),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      fetchRecipes(malzemeler.toString());
                    },
                    child: Text(
                      "Tarifleri Bul",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.color3,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                        AppColors.color5,
                      ),
                      padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 20,
                          vertical: MediaQuery.of(context).size.height / 85,
                        ),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      if (_malzemeController.text.isNotEmpty) {
                        setState(() {
                          malzemeler.add(_malzemeController.text);
                          _malzemeController.clear();
                        });
                      }
                    },
                    child: Text(
                      "Ekle",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.color3,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Wrap(
              spacing: 8.0,
              children:
                  malzemeler.map((malzeme) {
                    return Chip(
                      label: Text(malzeme),
                      onDeleted: () {
                        setState(() {
                          malzemeler.remove(malzeme);
                        });
                      },
                    );
                  }).toList(),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _recipes.length,
              itemBuilder: (context, index) {
                final recipe = _recipes[index];
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    child: ListTile(
                      leading: Image.network(recipe['image'], width: 80),
                      title: Text(
                        recipe['title'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Eksik Malzemeler: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: recipe['missedIngredients']
                                  .map((item) => item['name'].toString())
                                  .toList()
                                  .join(', '),
                            ),
                          ],
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          // Tarifin favorilerde olup olmadığını kontrol et
                          bool isRecipeAlreadyFavorite = favoriteRecipes.any(
                            (item) => item['title'] == recipe['title'],
                          );

                          if (!isRecipeAlreadyFavorite) {
                            setState(() {
                              // Tarif favorilere ekleniyor
                              favoriteRecipes.add({
                                'title': recipe['title'],
                                'image': recipe['image'],
                              });
                            });

                            // SnackBar ile kullanıcıyı bilgilendir
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Center(
                                  child: Text(
                                    "Tarif Favorilere Eklendi!",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                backgroundColor: Colors.greenAccent[400],
                                duration: Duration(seconds: 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                margin: EdgeInsets.only(
                                  bottom: 25,
                                  left: 10,
                                  right: 10,
                                ),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          } else {
                            // Eğer tarif zaten favorilerdeyse, kullanıcıyı bilgilendir
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Center(
                                  child: Text(
                                    "Bu tarif zaten favorilerinizde!",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                backgroundColor: AppColors.color4,
                                duration: Duration(seconds: 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                margin: EdgeInsets.only(
                                  bottom: 25,
                                  left: 10,
                                  right: 10,
                                ),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        },
                        icon: Icon(Icons.favorite_border_rounded),
                      ),

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    RecipeDetailPage(recipeId: recipe['id']),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
