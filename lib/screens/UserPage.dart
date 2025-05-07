import 'package:flutter/material.dart';
import 'package:quick_cook/screens/FavRecipes.dart';
import 'package:quick_cook/screens/HomePage.dart';
import 'package:quick_cook/screens/LoginPage.dart';
import 'package:quick_cook/screens/RegisterPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quick_cook/utils/colors.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}


class _UserPageState extends State<UserPage> {

    int _selectedIndex = 3;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  final List<Widget> navigationBarScreens = [
    HomePage(),
    FavoriteRecipes(),
    FavoriteRecipes(),
    UserPage(),
  ];

  bool isDarkMode = false;

  String email = ""; 
  String name = ""; 
  String surname = ""; 
  String username = ""; 

  Future<void> fetchUserData() async {
    try {
      // Firebase Authentication ile giriş yapan kullanıcının ID'sini alıyoruz
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Kullanıcı giriş yapmış, uid'ye göre Firestore'dan veri çekiyoruz
        DocumentSnapshot userDoc =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid) // Kullanıcının uid'sine göre belgeyi çekiyoruz
                .get();

        if (userDoc.exists) {
          setState(() {
            email = userDoc['email'] ?? "No email found";
            name = userDoc['name'] ?? "No name found";
            surname = userDoc['surname'] ?? "No surname found";
            username = userDoc['username'] ?? "No username found";
            usernameController.text = username;
          });
        } else {
          print("User document not found");
          setState(() {
            email = "User document not found";
            name = "User document not found";
            surname = "User document not found";
            username = "User document not found";
            usernameController.text = username;
          });
        }
      } else {
        // Eğer kullanıcı giriş yapmamışsa, hata mesajı verebilirsiniz
        print("No user is currently logged in.");
        setState(() {
          email = "No user logged in";
          name = "No user logged in";
          surname = "No user logged in";
          username = "No user logged in";
          usernameController.text = username;
        });
      }
    } catch (e) {
      print("Hata oluştu: $e");
      setState(() {
        email = "Error loading email";
        name = "Error loading name";
        surname = "Error loading surname";
        username = "Error loading username";
        usernameController.text = username;
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
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } else if (index == 1) { 
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FavoriteRecipes(),),
        );
      }
      else if (index == 2) { 
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FavoriteRecipes(),),
        );
      }
      else if (index == 3) { 
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UserPage()),
        );
      }
    }
  }

  Future<void> updateUsername() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'username': usernameController.text});
        
        setState(() {
          username = usernameController.text;
        });
      }
    } catch (e) {
      print("Kullanıcı adı güncellenirken hata oluştu: $e");
    }
  }

  void showUsernameDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[300],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Kullanıcı Adını Değiştir',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: usernameController,
              decoration: InputDecoration(
                hintText: "Yeni kullanıcı adı",
                hintStyle: TextStyle(color: Colors.grey[400]),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Color.fromARGB(255, 182, 47, 79), width: 2),
                ),
                prefixIcon: Icon(Icons.person, color: Colors.black),
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                usernameController.text = username;
              },
              child: Text('İptal', style: TextStyle(color: AppColors.color1,fontWeight: FontWeight.bold)),
            ),
            TextButton(
              onPressed: () {
                updateUsername();
                Navigator.pop(context);
              },
              child: Text('Kaydet', style: TextStyle(color: AppColors.color1,fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.color3,
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 6,
                    decoration: BoxDecoration(
                      color: AppColors.color1,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  Text(
                    name + " " + surname,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text("Kullanıcı Adı"),
                    subtitle: Text(username),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: showUsernameDialog,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text("E-posta"), // E-posta için başlık
                    subtitle: Text(email), // E-posta burada gösteriliyor
                  ),
                  SwitchListTile(
                    title: Text("Karanlık Mod"),
                    secondary: Icon(Icons.dark_mode),
                    value: isDarkMode,
                    inactiveTrackColor: AppColors.color3,
                    activeTrackColor: Colors.grey[900],
                    inactiveThumbColor: Colors.grey[800],
                    onChanged: (value) {
                      setState(() {
                        isDarkMode = value;
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text("Ayarlar"),
                    onTap: () {
                     
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text("Çıkış Yap"),
                    onTap: () async {
                      // Clear saved credentials
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.remove('saved_email');
                      await prefs.remove('saved_password');
                      await prefs.remove('remember_me');
                    
                      
                      // Sign out from Firebase
                      await FirebaseAuth.instance.signOut();
                      
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                  ),
                ],
              ),
              Positioned(
                top: 50,
                left: 0,
                child: IconButton(
                  icon: Icon(Icons.chevron_left),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  color: AppColors.color3,
                ),
              ),
              Positioned(
                top: 75,
                child: Container(
                  padding: EdgeInsets.all(0.1),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.color3, width: 4),
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://i.pinimg.com/736x/ea/92/7e/ea927ea501a719d85a98f61fd2dfc447.jpg',
                    ),
                    backgroundColor: AppColors.color3,
                  ),
                ),
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
              color: Colors.black.withOpacity(0.3),
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
      ),
    );
  }
}