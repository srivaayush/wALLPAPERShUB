// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

// import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
// import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:permission_handler/permission_handler.dart';

class ImageView extends StatefulWidget {
  String imgPath;
  ImageView({required this.imgPath});
  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            //hero satarted

            tag: widget.imgPath,
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  widget.imgPath,
                  fit: BoxFit.cover,
                )),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    _save();
                    Navigator.pop(context);
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFF181717).withOpacity(0.8),
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white24, width: 1),
                            borderRadius: BorderRadius.circular(40),
                            gradient: const LinearGradient(
                                colors: [Color(0x36FFFFFF), Color(0x0FFFFFFF)],
                                begin: FractionalOffset.topLeft,
                                end: FractionalOffset.bottomRight)),
                        child: const Text(
                          "Save in Gallery",
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _save() async {
    var response = await Dio().get(widget.imgPath,
        options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: "hello");
    print(result);
  }

//  _save() async {
//     await _askPermission();
//     var response = await Dio().get(widget.imgPath,
//         options: Options(responseType: ResponseType.bytes));
//     // final result =
//     //     await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
//     // print(result);
//     Navigator.pop(context);
//   }

//   _askPermission() async {
//     if (Platform.isIOS) {
//       /*Map<PermissionGroup, PermissionStatus> permissions =
//           */await PermissionHandler()
//               .requestPermissions([PermissionGroup.photos]);
//     } else {
//      /* PermissionStatus permission = */await PermissionHandler()
//           .checkPermissionStatus(PermissionGroup.storage);
//     }
//   }

}
