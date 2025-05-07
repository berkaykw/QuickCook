import 'package:flutter/material.dart';
import 'package:quick_cook/screens/RegisterPage.dart';
import 'package:quick_cook/services/auth_service.dart';
import 'package:quick_cook/utils/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final String loginText = "Hesabınıza Giriş Yapın!";
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

bool sifreGizleme = true;

class _LoginPageState extends State<LoginPage> {
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
                loginText,
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
              "E-posta Adresi",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'E-postanızı giriniz',
                labelText: 'E-posta',
                labelStyle: TextStyle(color: AppColors.color2),
                prefixIcon: Icon(Icons.email_outlined, color: AppColors.color2),
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
                hintText: 'Şifrenizi Giriniz',
                labelText: 'Şifre',
                labelStyle: TextStyle(color: AppColors.color2),
                prefixIcon: Icon(Icons.lock_outlined, color: AppColors.color2),
                suffixIcon: IconButton(
                  icon: Icon(
                    sifreGizleme
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
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
            SizedBox(height: 60),
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
                onPressed: () {
                  AuthService().signIn(
                    context: context,
                    email: emailController.text,
                    password: passwordController.text,
                  );
                },
                child: Text(
                  "Giriş Yap",
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
                    "Hesabın Yok mu? ",
                    style: TextStyle(color: AppColors.color2),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Registerpage()),
                      );
                    },
                    child: Text(
                      "Kayıt ol",
                      style: TextStyle(
                        color: AppColors.color2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
