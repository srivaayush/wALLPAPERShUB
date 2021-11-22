// ignore_for_file: use_key_in_widget_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:wallpaper/widgets/widget.dart';
import 'package:http/http.dart' as http;
import 'package:wallpapershub/widgets/widget.dart';
import 'data/data.dart';
import 'model/wallpaper.dart';
class Search extends StatefulWidget {
  final String searchQuery;
  const Search({required this.searchQuery});
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  


@override
  void initState() {
    getSearchWallpaper(widget.searchQuery);
    super.initState();
    searchController.text=widget.searchQuery;
  }
TextEditingController searchController =  TextEditingController();
 List<WallpaperModel> wallpapers =  [];
//
 void getSearchWallpaper(String query) async {
    await http.get(Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=20"), headers: {
      "Authorization": apiKey,
    }).then((value) {
      //  print(response.body.toString());
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        //  print(element);
        WallpaperModel wallpaperModel =  WallpaperModel();
        wallpaperModel = WallpaperModel.fromMap(element);
        wallpapers.add(wallpaperModel);
        // print(wallpaperModel.src.portrait);
      });
      setState(() {});
    });
  }

//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: brandName(),
        elevation: 0,
      ),
      body: SingleChildScrollView(
              child: Column(
                children: [
                   Container(
                      decoration: BoxDecoration(
                          color: const Color(0xfff5f8fd),
                          borderRadius: BorderRadius.circular(30)),
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
                             getSearchWallpaper(searchController.text);
                            },
                            child: const Icon(Icons.search),
                          )
                        ],
                      ),
                    ), const SizedBox(
                      height: 16,
                    ),
                     wallpapersList(wallpapers, context)
                ],
              ),
      ),
    );
  }
}