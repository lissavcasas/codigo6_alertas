import 'dart:io';

import 'package:codigo6_alertas/models/news_model.dart';
import 'package:codigo6_alertas/services/api_service.dart';
import 'package:codigo6_alertas/utils/types.dart';
import 'package:codigo6_alertas/widgets/common_button_widget.dart';
import 'package:codigo6_alertas/widgets/common_textfield_widget.dart';
import 'package:codigo6_alertas/widgets/general_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';

class NewsFormPage extends StatefulWidget {
  const NewsFormPage({super.key});

  @override
  State<NewsFormPage> createState() => _NewsFormPageState();
}

class _NewsFormPageState extends State<NewsFormPage> {
  final TextEditingController _titulocontroller = TextEditingController();
  final TextEditingController _linkcontroller = TextEditingController();
  ImagePicker imagePicker = ImagePicker();
  XFile? image;

  final formKey = GlobalKey<FormState>();

  String errormessage = "";

  bool isLoading = false;

  Future<void> getImageGallery() async {
    image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      errormessage = "";
      setState(() {});
    }
    setState(() {});
  }

  Future<void> getImageCamera() async {
    image = await imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      errormessage = "";
      setState(() {});
    }
    setState(() {});
  }

  registerNews() async {
    if (formKey.currentState!.validate()) {
      if (image != null) {
        isLoading = true;
        setState(() {});
        File newImageFile = await FlutterNativeImage.compressImage(image!.path);
        ApiService apiService = ApiService();
        NewsModel model = NewsModel(
          id: 0,
          link: _linkcontroller.text,
          titulo: _titulocontroller.text,
          fecha: DateTime.now(),
          imagen: newImageFile.path,
        );
        apiService.registerNews(model).then((value) {
          isLoading = false;
          Navigator.pop(context);
        }).catchError((error) {
          isLoading = false;
          setState(() {});
        });
      } else {
        errormessage = "Selecciona una imagen";
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Text(
                        "Registra Noticias",
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      CommonTextFieldWidget(
                        label: "Titulo",
                        hintText: "Ingrese un título",
                        type: InputType.text,
                        controller: _titulocontroller,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      CommonTextFieldWidget(
                        label: "Link",
                        hintText: "Ingresa un Link",
                        type: InputType.text,
                        controller: _linkcontroller,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                getImageGallery();
                              },
                              label: const Text("Galeria"),
                              icon: const Icon(Icons.image),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                getImageCamera();
                              },
                              label: const Text("Cámara"),
                              icon: const Icon(Icons.camera),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pink,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // image != null
                      //     ? ClipRRect(
                      //         borderRadius: BorderRadius.circular(14.0),
                      //         child: Image.file(
                      //           File(image!.path),
                      //           height: 220,
                      //         ),
                      //       )
                      //     : Image.asset("assets/images/placeholder.webp"),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: double.infinity,
                        height: 220,
                        decoration: BoxDecoration(
                          //color: Colors.amber,
                          borderRadius: BorderRadius.circular(14.0),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: image != null
                                ? FileImage(File(image!.path))
                                : const AssetImage(
                                        "assets/images/placeholder.webp")
                                    as ImageProvider,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 10.0,
                        ),
                        child: Row(
                          children: [
                            Text(
                              errormessage,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 13.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: CommonButtonWidget(
                text: "Registrar",
                onPressed: () {
                  registerNews();
                },
              ),
            ),
          ),
          isLoading
              ? Container(
                  color: Colors.white.withOpacity(0.6),
                  child: loadingWidget,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
