import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_html/flutter_html.dart';
import 'package:quick_cook/utils/colors.dart';

class RecipeDetailPage extends StatefulWidget {
  final int recipeId;

  RecipeDetailPage({required this.recipeId});

  @override
  _RecipeDetailPageState createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  Map<String, dynamic>? recipeDetails;
  String apiKey = '3b8a08da94fd40e68181d23ef0e448ff';

  @override
  void initState() {
    super.initState();
    fetchRecipeDetails();
  }

  Future<void> fetchRecipeDetails() async {
    final url = Uri.parse(
      'https://api.spoonacular.com/recipes/${widget.recipeId}/information?apiKey=$apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        recipeDetails = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load recipe details');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (recipeDetails == null) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Image.asset("assets/images/logo.png", width: 250)),
            Center(child: CircularProgressIndicator(color: AppColors.color1)),
          ],
        ),
      );
    }
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
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.color3,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            centerTitle: true,
            title: Text(
              recipeDetails!['title'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppColors.color3,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(recipeDetails!['image']),
            SizedBox(height: 10),
            Text(
              'Hazırlık Süresi: ${recipeDetails!['readyInMinutes']} dakika',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Kişi Sayısı: ${recipeDetails!['servings']} kişi',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 5,
              margin: EdgeInsets.all(5.0),
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Malzemeler:',
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                    ),
                    ...List.generate(
                      recipeDetails!['extendedIngredients'].length,
                      (index) => Text(
                        '- ${recipeDetails!['extendedIngredients'][index]['original']}',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 5, 
              margin: EdgeInsets.all(5.0), 
              child: Padding(
                padding: EdgeInsets.all(5.0,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Talimatlar:',
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                    ),
                    Html(data: recipeDetails!['summary']),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            recipeDetails!['instructions'] != null
                ? Text(recipeDetails!['instructions'])
                : Text('Talimat bulunamadı.'),
          ],
        ),
      ),
    );
  }
}
