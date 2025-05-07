import 'package:flutter/material.dart';
import 'package:quick_cook/screens/LoginPage.dart';
import 'package:quick_cook/services/auth_service.dart';
import 'package:quick_cook/utils/colors.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController surnameController = TextEditingController();
final TextEditingController usernameController = TextEditingController();

bool sifreGizleme = true;

class _RegisterpageState extends State<Registerpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios, color: AppColors.color2),
                ),
              ),
            ),
            Center(
              child: Text(
                "Hemen Kayıt Olun!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColors.color2,
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(child: Image.asset('assets/images/logo.png', width: 300)),
            Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Quick",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                    TextSpan(
                      text: "Cook",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        color: AppColors.color1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Adınız",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Adınızı Giriniz',
                labelStyle: TextStyle(color: AppColors.color2),
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
            SizedBox(height: 20),
            Text(
              "Soyadınız",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              controller: surnameController,
              decoration: InputDecoration(
                hintText: "Soyadınızı Giriniz",
                labelStyle: TextStyle(color: AppColors.color2),
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
            SizedBox(height: 20),
            Text(
              "E-posta",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "E-postanızı giriniz",
                labelStyle: TextStyle(color: AppColors.color2),
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
            SizedBox(height: 20),
            Text(
              "Kullanıcı Adı",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                hintText: "Kullanıcı Adınızı Giriniz",
                labelStyle: TextStyle(color: AppColors.color2),
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
            SizedBox(height: 20),
            Text(
              "Şifre",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: sifreGizleme,
              decoration: InputDecoration(
                hintText: "Şifrenizi Giriniz",
                labelStyle: TextStyle(color: AppColors.color2),
                suffixIcon: IconButton(
                  icon: Icon(sifreGizleme ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined),
                  onPressed: () {
                    setState(() {
                      sifreGizleme = !sifreGizleme;
                    });
                  }, 
                  ),
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
            SizedBox(height: 50),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                    AppColors.color1,
                  ),
                  padding: WidgetStateProperty.all(
                    EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 2.7,
                      vertical: MediaQuery.of(context).size.height / 70,
                    ),
                  ),
                ),
                onPressed: () => _register(context),
                child: Text(
                  "Kayıt Ol",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.color3,
                  ),
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Zaten hesabın var mı? ",
                    style: TextStyle(color: AppColors.color2),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      "Giriş Yap",
                      style: TextStyle(
                        color: AppColors.color2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}



void _register(BuildContext context) async {
  String name = nameController.text;
  String surname = surnameController.text;
  String username = usernameController.text;
  String email = emailController.text;
  String password = passwordController.text;

  if (name.isEmpty ||
      surname.isEmpty ||
      username.isEmpty ||
      email.isEmpty ||
      password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            "Lütfen Tüm Alanları Doldurunuz!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        backgroundColor: Colors.red[600],
        duration: Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  } else {
    bool isSuccessRegister = await AuthService().signUp(
      context: context,
      name: name,
      surname: surname,
      username: username,
      email: email,
      password: password,
    );

    if (isSuccessRegister) {
      nameController.clear();
      surnameController.clear();
      usernameController.clear();
      emailController.clear();
      passwordController.clear();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(
              child: Text(
                "Kayıt Başarılı!",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            backgroundColor: Colors.greenAccent[400],
            duration: Duration(seconds: 3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: EdgeInsets.only(bottom: 25, left: 10, right: 10),
            behavior: SnackBarBehavior.floating,
          ),
        );
    }
  }
}

