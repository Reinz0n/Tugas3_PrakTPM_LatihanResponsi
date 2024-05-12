import 'package:flutter/material.dart';
import 'package:latihan_responsi/models/meals.dart';
import 'package:latihan_responsi/network/load_data_source.dart';
import 'package:latihan_responsi/pages/detail_meals.dart';

class MealPage extends StatefulWidget{
  const MealPage({Key? key, required this.idMeal}) : super(key: key);

  final String idMeal;

  @override
  State<MealPage> createState() => _MealPageState();
}

class _MealPageState extends State<MealPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.idMeal} Meals'),
      ),
      body: _buildListMealsBody(),
    );
  }

  Widget _buildListMealsBody(){
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadMeals(widget.idMeal),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
          if(snapshot.hasError){
            return _buildErrorSection();
          }
          if(snapshot.hasData){
            MealsModel mealsModel = MealsModel.fromJson(snapshot.data);
            return _buildSuccessSection(mealsModel);
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

  Widget _buildSuccessSection(MealsModel data){
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.75,
      ),
      itemCount: data.meals!.length,
      itemBuilder: (BuildContext context, int index){
        return _buildItemMeals(data.meals![index]);
      },
    );
  }

  Widget _buildItemMeals(Meals mealsData){
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailMealPage(idDetailMeal: mealsData.idMeal!)
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.network(
                  mealsData.strMealThumb!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                mealsData.strMeal!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}