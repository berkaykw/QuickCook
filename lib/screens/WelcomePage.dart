import 'package:flutter/material.dart';
import 'package:quick_cook/screens/LoginPage.dart';
import 'package:quick_cook/utils/colors.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

final String hosgeldinText = "Hoş geldin!";
final String girisText = "QuickCook ile evdeki malzemeler ile harika tarifler keşfet.";

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 60),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                hosgeldinText,
                style: TextStyle(
                  fontSize: 36, 
                  fontWeight: FontWeight.bold,
                  color: AppColors.color1,
                  wordSpacing: 2,
                  letterSpacing: 2,
                  ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              girisText,
              style: TextStyle(
                fontSize: 25, 
                fontWeight: FontWeight.bold,
                color: AppColors.color2,
                wordSpacing: 2,
                letterSpacing: 2,
                ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 10),
          Image.asset('assets/images/logo.png', width: 300),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 60,
            ),
            child: Center(
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
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 6),
          BaslaButonu(),
        ],
      ),
    );
  }
}

class BaslaButonu extends StatelessWidget {
  const BaslaButonu({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(AppColors.color1),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 3.5,
            vertical: MediaQuery.of(context).size.height / 90,
          ),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
      child: Text(
        "Başla",
        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.color3,fontSize: 18),
      ),
    );
  }
}
