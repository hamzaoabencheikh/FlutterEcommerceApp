import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoppingapp/constants/utils.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _brandnameEditingController =
      TextEditingController();
  final TextEditingController _priceEditingController = TextEditingController();
  final TextEditingController _sizeEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  File? imageFile;
  Future _getFromGallery() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) return;

    File file = File(image.path);
    setState(() {
      imageFile = file;
    });
  }

  final CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Future<String> uploadImage(File file) async {
    String imageurl = '';
    Reference reference = FirebaseStorage.instance.ref();
    Reference referenceDirImage = reference.child('images');
    String uniquename = DateTime.now().millisecondsSinceEpoch.toString();

    Reference referenceImageToUpload =
        referenceDirImage.child('${_titleEditingController.text}_$uniquename');
    try {
      await referenceImageToUpload.putFile(file);
      imageurl = await referenceImageToUpload.getDownloadURL();
      print(imageurl);
    } catch (e) {
      print(e);
    }

    return imageurl;
  }

  void addProduct() async {
    String imageurl = await uploadImage(imageFile!);
    final product = {
      "product_name": _titleEditingController.text,
      "product_brandname": _brandnameEditingController.text,
      "product_size": _sizeEditingController.text,
      "product_price": _priceEditingController.text,
      "product_imageurl": imageurl
    };
    products.add(product);
  }

  void clearTextfield() {
    _brandnameEditingController.clear();
    _priceEditingController.clear();
    _sizeEditingController.clear();
    _titleEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  'ADD PRODUCT',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              Form(
                  key: _formKey,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 9, vertical: 15),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _titleEditingController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter product title';
                            }
                          },
                          decoration: const InputDecoration(
                            filled: true,
                            border: OutlineInputBorder(),
                            labelText: 'Title',
                            hintText: 'product title',
                            prefixIcon: Icon(Icons.title),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _brandnameEditingController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter brand name';
                            }
                          },
                          decoration: const InputDecoration(
                            filled: true,
                            border: OutlineInputBorder(),
                            labelText: 'Brand',
                            hintText: 'Brand Name',
                            prefixIcon: Icon(Icons.branding_watermark_sharp),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _sizeEditingController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter product size';
                            }
                          },
                          decoration: const InputDecoration(
                            filled: true,
                            border: OutlineInputBorder(),
                            labelText: 'Size',
                            hintText: 'product size',
                            prefixIcon: Icon(Icons.man),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _priceEditingController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter price';
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            filled: true,
                            border: OutlineInputBorder(),
                            labelText: 'Price',
                            hintText: 'product price',
                            prefixIcon: Icon(Icons.attach_money),
                          ),
                        ),
                      ],
                    ),
                  )),
              InkWell(
                onTap: () {
                  _getFromGallery();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: imageFile == null ? 200 : 300,
                      width: double.infinity,
                      color: Colors.blueGrey,
                      child: imageFile == null
                          ? const Icon(
                              Icons.image,
                              size: 40,
                            )
                          : Container(
                              child: Image.file(
                                imageFile!,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (imageFile != null) {
                        if (FirebaseAuth.instance.currentUser != null) {
                          addProduct();
                          //clearTextfield();
                        } else {
                          showSnackBar(
                              context, 'please login to use this function');
                        }
                      } else {
                        showSnackBar(context, 'Please select a  image');
                      }
                    }
                  },
                  child: Text('add'))
            ],
          ),
        ),
      ),
    );
  }
}
