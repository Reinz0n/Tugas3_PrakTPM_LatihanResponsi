import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latihan_responsi/models/categories.dart';
import 'package:latihan_responsi/network/load_data_source.dart';
import 'package:latihan_responsi/pages/meals.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Categories'),
        centerTitle: true,
      ),
      body: _buildListCategoriesBody(),
    );
  }

  Widget _buildListCategoriesBody(){
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadCategories(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
          if(snapshot.hasError){
            return _buildErrorSection();
          }
          if(snapshot.hasData){
            CategoriesModel categoriesModel = CategoriesModel.fromJson(snapshot.data);
            return _buildSuccessSection(categoriesModel);
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

  Widget _buildSuccessSection(CategoriesModel data){
    return ListView.builder(
      itemCount: data.categories!.length,
      itemBuilder: (BuildContext context, int index){
        return _buildItemCategories(data.categories![index]);
      },
    );
  }

  Widget _buildItemCategories(Categories categoriesData){
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MealPage(idMeal: categoriesData.strCategory!)
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[200]!,
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(color: Colors.grey[400]!)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Image.network(categoriesData.strCategoryThumb!),
                  SizedBox(height: 10),
                  Text(
                    categoriesData.strCategory!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(categoriesData.strCategoryDescription!),
            ),
          ],
        ),
      ),
    );
  }
}