
// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:wallpapershub/views/model/category_model.dart';

class CategoriesTile extends StatelessWidget {
  final String ?imgUrl;final String ?title;

  const CategoriesTile({required this.imgUrl, required this.title});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Categorie(
          categoryName: title!.toLowerCase(),
        )));
      },
          child: Container(
        margin: const EdgeInsets.only(right: 4),
        child: Stack(
          children: [
            ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      imgUrl!,
                      height: 50,
                      width: 100,
                      fit: BoxFit.cover,
                    )),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.black12,
              ),
              alignment: Alignment.center,
              height: 50,
              width: 100,
              child: Text(
                title!,
                style:
                    const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
