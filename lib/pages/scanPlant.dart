import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tflite/flutter_tflite.dart';

class scanPlant extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<scanPlant> {
  bool loading = true;
  File? _image;
  List _output = [];
  double confidence = 0.0; // New variable to store confidence percentage
  final imagepicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadmodel().then((value) {
      setState(() {});
    });
  }

  detectimage(File image) async {
    var prediction = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 3,
      threshold: 0.0,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    setState(() {
      _output = prediction as List;
      loading = false;
    });

    showHighestConfidence();
  }

  void showHighestConfidence() {
    if (_output.isNotEmpty) {
      var highestConfidence = _output[0];
      for (var output in _output) {
        if (output['confidence'] > highestConfidence['confidence']) {
          highestConfidence = output;
        }
      }

      setState(() {
        _output = [highestConfidence];
        confidence = highestConfidence['confidence'] * 100;
      });
    }
  }

  loadmodel() async {
    await Tflite.loadModel(
        model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
  }

  @override
  void dispose() {
    super.dispose();
  }

  pickimage_camera() async {
    // ignore: deprecated_member_use
    var image = await imagepicker.getImage(source: ImageSource.camera);
    if (image == null) {
      return null;
    } else {
      _image = File(image.path);
    }
    detectimage(_image as File);
  }

  pickimage_gallery() async {
    // ignore: deprecated_member_use
    var image = await imagepicker.getImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    } else {
      _image = File(image.path);
    }
    detectimage(_image as File);
  }
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        // Handle back button press
        Navigator.popUntil(context, (route) => route.isFirst);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: Text('Scan Plant'),
        ),
        body: SafeArea(
          child: Container(
            color: Colors.lightGreen[100],
            height: h,
            width: w,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 15),
                Text(
                  'To detect disease, upload your image by camera or gallery.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildImageButton('assets/images/camera.png', pickimage_camera),
                    _buildImageButton('assets/images/images.png', pickimage_gallery),
                  ],
                ),
                SizedBox(height: 20),
                if (loading)
                  CircularProgressIndicator()
                else
                  if (_image != null)
                    Column(
                      children: [
                        Container(
                          height: 220,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 3),
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: Image.file(_image!),
                        ),
                        if (_output != null)
                          Column(
                            children: [
                              Text(
                                _output[0]['label'].toString().substring(0),
                                style: TextStyle(fontSize: 22),
                              ),
                              Text(
                                'Confidence: ${confidence.toStringAsFixed(3)}%',
                              ),
                            ],
                          )
                        else
                          Text(''),
                      ],
                    )
                  else
                    Container(),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return scanPlant();
                        },
                      ),
                    );
                  },
                  child: Text('Scan Again'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageButton(String imagePath, VoidCallback onTap) {
    return Container(
      height: 150,
      width: 140,
      child: Card(
        elevation: 10,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(
              image: AssetImage(imagePath),
            ),
          ),
        ),
      ),
    );
  }

// ... (existing methods)
}





