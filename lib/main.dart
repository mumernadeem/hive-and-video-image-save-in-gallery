import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Hive practice',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                var box = await Hive.openBox('myBox');
                box.put('name', 'Umer');
              },
              child: const Text(
                'Name saver',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                var box1 = await Hive.openBox('myBox');
                var name = box1.get('name');
                print('Name: $name');
              },
              child: const Text(
                'Get name',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                XFile? pickedFile =
                    await picker.pickImage(source: ImageSource.camera);
                if (pickedFile != null) {
                  var box = await Hive.openBox('myBox');
                  File imageFile1 = File(pickedFile.path);
                  GallerySaver.saveImage(imageFile1.path).then((value) {
                    box.put('image path', imageFile1.path);
                    print('image saved');
                  });
                }
              },
              child: const Text(
                'Take photo to save in gallery',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                var box1 = await Hive.openBox('myBox');
                var name = box1.get('image path');
                print('image path: $name');
              },
              child: const Text(
                'Get photo path',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                var box = await Hive.openBox('myBox');
                XFile? pickedFile =
                    await picker.pickVideo(source: ImageSource.camera);
                if (pickedFile != null) {
                  File videoFile1 = File(pickedFile.path);
                  GallerySaver.saveVideo(videoFile1.path).then((value) {
                    box.put('video path', videoFile1.path);
                    print('video saved');
                  });
                }
              },
              child: const Text(
                'Record video to save in gallery',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                var box1 = await Hive.openBox('myBox');
                var name = box1.get('video path');
                print('video path: $name');
              },
              child: const Text(
                'Get video path',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
