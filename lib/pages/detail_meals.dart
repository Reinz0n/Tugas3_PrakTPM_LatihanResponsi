import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:latihan_responsi/models/detail_meals.dart';
import 'package:latihan_responsi/network/load_data_source.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailMealPage extends StatefulWidget{
  const DetailMealPage({super.key, required this.idDetailMeal});

  final String idDetailMeal;

  @override
  State<DetailMealPage> createState() => _DetailMealPageState();
}

class _DetailMealPageState extends State<DetailMealPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Detail'),
      ),
      body: _buildDetailMealsBody(),
    );
  }

  Widget _buildDetailMealsBody(){
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadDetailMeal(widget.idDetailMeal),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
          if(snapshot.hasError){
            return _buildErrorSection();
          }
          if(snapshot.hasData){
            MealDetailModel mealDetailModel = MealDetailModel.fromJson(snapshot.data);
            return _buildSuccessSection(mealDetailModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection(){
    return Text("Error");
  }

  Widget _buildLoadingSection(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(MealDetailModel data){
    return ListView.builder(
      itemCount: data.meals!.length,
      itemBuilder: (BuildContext context, int index){
        return _buildItemDetailMeal(data.meals![index]);
      },
    );
  }

  Widget _buildItemDetailMeal(Meals detailMealData){
    return InkWell(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Image.network(
                  detailMealData.strMealThumb!,
                  height: 200,
                  width: 200,
                ),
                SizedBox(height: 10),
                Text(
                  detailMealData.strMeal!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Category: ${detailMealData.strCategory}'),
                    SizedBox(height: 50),
                    SizedBox(width: 100),
                    Text('Area: ${detailMealData.strArea}'),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ingredients:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 5),
                    Table(
                      columnWidths: {
                        0: FixedColumnWidth(200),
                        1: FixedColumnWidth(200),
                        2: FixedColumnWidth(200),
                        3: FixedColumnWidth(100)
                      },
                      children: [
                        TableRow(
                            children: [
                              Text(detailMealData.strIngredient1!),
                              Text(detailMealData.strMeasure1!),
                              Text(detailMealData.strIngredient11!),
                              Text(detailMealData.strMeasure11!),
                            ]
                        ),
                        TableRow(
                            children: [
                              Text(detailMealData.strIngredient2!),
                              Text(detailMealData.strMeasure2!),
                              Text(detailMealData.strIngredient12!),
                              Text(detailMealData.strMeasure12!),
                            ]
                        ),
                        TableRow(
                            children: [
                              Text(detailMealData.strIngredient3!),
                              Text(detailMealData.strMeasure3!),
                              Text(detailMealData.strIngredient13!),
                              Text(detailMealData.strMeasure13!),
                            ]
                        ),
                        TableRow(
                            children: [
                              Text(detailMealData.strIngredient4!),
                              Text(detailMealData.strMeasure4!),
                              Text(detailMealData.strIngredient14!),
                              Text(detailMealData.strMeasure14!),
                            ]
                        ),
                        TableRow(
                            children: [
                              Text(detailMealData.strIngredient5!),
                              Text(detailMealData.strMeasure5!),
                              Text(detailMealData.strIngredient15!),
                              Text(detailMealData.strMeasure15!),
                            ]
                        ),
                        TableRow(
                            children: [
                              Text(detailMealData.strIngredient6!),
                              Text(detailMealData.strMeasure6!),
                              Text(detailMealData.strIngredient16!),
                              Text(detailMealData.strMeasure16!),
                            ]
                        ),
                        TableRow(
                            children: [
                              Text(detailMealData.strIngredient7!),
                              Text(detailMealData.strMeasure7!),
                              Text(detailMealData.strIngredient17!),
                              Text(detailMealData.strMeasure17!),
                            ]
                        ),
                        TableRow(
                            children: [
                              Text(detailMealData.strIngredient8!),
                              Text(detailMealData.strMeasure8!),
                              Text(detailMealData.strIngredient18!),
                              Text(detailMealData.strMeasure18!),
                            ]
                        ),
                        TableRow(
                            children: [
                              Text(detailMealData.strIngredient9!),
                              Text(detailMealData.strMeasure9!),
                              Text(detailMealData.strIngredient19!),
                              Text(detailMealData.strMeasure19!),
                            ]
                        ),
                        TableRow(
                            children: [
                              Text(detailMealData.strIngredient10!),
                              Text(detailMealData.strMeasure10!),
                              Text(detailMealData.strIngredient20!),
                              Text(detailMealData.strMeasure20!),
                            ]
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Instructions:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(detailMealData.strInstructions!),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: (){
                        launchURL(detailMealData.strYoutube!);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.play_arrow_rounded),
                          SizedBox(width: 10),
                          Text('Watch Tutorial'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Future <void> launchURL(String url) async{
  final Uri _url = Uri.parse(url);
  if(!await launchUrl(_url)){
    throw "Couldn't launch url";
  }
}