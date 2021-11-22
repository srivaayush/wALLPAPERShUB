import 'package:flutter/material.dart';
import 'package:wallpapershub/views/image_view.dart';
import 'package:wallpapershub/views/model/wallpaper.dart';
// import 'package:wallpaper/views/image_view.dart';
// import 'package:wallpaper/views/model/wallpaper.dart';

Widget brandName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Text(
        'wALLPAPER',
        style: TextStyle(color: Colors.black),
      ),
      Text(
        "hUB",
        style: TextStyle(color: Colors.white),
      )
    ],
  );
}

Widget wallpapersList(List<WallpaperModel> wallpapers, BuildContext context) {
  return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 6.0,
        children: wallpapers.map((wallpaper) {
          return GridTile(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ImageView(imgPath: wallpaper.src!.portrait),
                  ),
                );
              },
              child: Hero(
                tag: wallpaper.src!.portrait,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      wallpaper.src!.portrait,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          );
        }).toList(),
      ));
}
