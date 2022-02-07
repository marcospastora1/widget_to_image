import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'Widget to image',
    initialRoute: '/home',
    getPages: [
      GetPage(name: '/home', page: () => HomeScreen()),
    ],
  ));
}

class HomeScreen extends StatelessWidget {
  ScreenshotController screenshotController = ScreenshotController();

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Screenshot'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Screenshot(
              controller: screenshotController,
              child: Container(
                color: Colors.yellow,
                margin: const EdgeInsets.all(5),
                width: 200,
                height: 200,
                child: const Center(
                  child: Text('vai virar imagem'),
                ),
              ),
            ),
            ElevatedButton(
              child: const Text(
                'printar widget',
              ),
              onPressed: () {
                screenshotController.capture().then((capturedImage) async {
                  saveShare(capturedImage!);
                }).catchError((onError) {
                  print(onError);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future saveShare(Uint8List bytes) async {
  Directory tempDir = await getTemporaryDirectory();
  final file = File('${tempDir.path}/image.png');
  await file.writeAsBytes(bytes);
  Share.shareFiles(['${tempDir.path}/image.png']);
}