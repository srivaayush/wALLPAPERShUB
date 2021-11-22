// ignore_for_file: use_key_in_widget_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpapershub/views/categoryTiles.dart';
import 'package:wallpapershub/views/model/wallpaper.dart';
import 'package:wallpapershub/views/search.dart';
import 'package:wallpapershub/widgets/widget.dart';
import 'data/data.dart';
import 'model/category_model.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //
  List<CategoriesModel> categories = [];
  int noofloads = 30;
  List<WallpaperModel> wallpapers = [];
  TextEditingController searchController = TextEditingController();

  void getTrendingWallpaper() async {
    await http.get(Uri.parse("https://api.pexels.com/v1/curated?per_page=10"),
        headers: {
          "Authorization": apiKey,
        }).then((value) {
      //  print(response.body.toString());
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        //  print(element);
        WallpaperModel wallpaperModel = WallpaperModel();
        wallpaperModel = WallpaperModel.fromMap(element);
        wallpapers.add(wallpaperModel);
        // print(wallpaperModel.src.portrait);
      });
      setState(() {});
    });
  }

  @override
  void initState() {
    getTrendingWallpaper();
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: brandName(),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(30)),
              margin: const EdgeInsets.symmetric(horizontal: 30),
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search Wallpaper",
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Search(
                            searchQuery: searchController.text,
                          ),
                        ),
                      );
                    },
                    child: const Icon(Icons.search),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 80,
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoriesTile(
                      title: categories[index].categoryName,
                      imgUrl: categories[index].imgUrl,
                    );
                  }),
            ),

            //
            wallpapersList(wallpapers, context)
          ],
        ),
      ),
    );
  }
}
