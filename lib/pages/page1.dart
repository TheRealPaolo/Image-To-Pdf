// ignore_for_file: unnecessary_null_comparison, library_private_types_in_public_api, avoid_print, unused_element, use_build_context_synchronously
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'message.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final List<File> _image = [];
  final picker = ImagePicker();
  final pdf = pw.Document();

// CONVERT IMAGE TO PDF
  create() async {
    for (var img in _image) {
      final image = pw.MemoryImage(img.readAsBytesSync());

      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context contex) {
            return pw.Center(child: pw.Image(image));
          }));
    }
  }

// PICK IMAGE FROM GALLERY
  getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image.add(File(pickedFile.path));
      } else {
        print('No image');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Convert image to pdf",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.picture_as_pdf,
                color: Colors.white,
              ),
              onPressed: () {
                create();
                save();
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: getImage,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: _image.isNotEmpty
          ? ListView.builder(
              itemCount: _image.length,
              itemBuilder: (context, index) {
                return Container(
                    height: 400,
                    width: double.infinity,
                    margin: const EdgeInsets.all(8),
                    child: Image.file(
                      _image[index],
                      fit: BoxFit.cover,
                    ));
              },
            )
          : const Center(
              child: Text(
              "Upload your image",
              style: TextStyle(color: Colors.black, fontSize: 26),
            )),
    );
  }

  save() async {
    try {
      final dir = await getExternalStorageDirectory();
      final file = File('${dir!.path}/file.pdf');
      await file.writeAsBytes(await pdf.save());
      showMessage(context, 'success', 'saved');
    } catch (e) {
      showMessage(context, "error", e.toString());
    }
  }
}
