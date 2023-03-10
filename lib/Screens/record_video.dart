import 'dart:io';
import 'package:blackcoffer/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:path/path.dart' as path;

class VideoCapture extends StatefulWidget {
  VideoCapture({super.key});
  static String routeName = "Video Capture";

  @override
  State<VideoCapture> createState() => _VideoCaptureState();
}

class _VideoCaptureState extends State<VideoCapture> {
  final ImagePicker _picker = ImagePicker();
  String videoURL = '';
  late final XFile? file;
  VideoPlayerController? _controller;
  bool isCaptured = false;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  var data;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Capture video")),
        backgroundColor: kPrimaryColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    file = await _picker.pickVideo(
                        source: ImageSource.camera,
                        maxDuration: const Duration(seconds: 10));
                    setState(() {
                      isCaptured = true;
                    });
                    _playVideo(file);
                    print("Video Path ${file!.path}");
                  },
                  icon: Icon(Icons.video_call_rounded,
                      color: Colors.green, size: 50),
                ),
                Text(
                  "Capture Video",
                  style: TextStyle(color: Colors.black),
                ),
                Container(height: 200, child: _previewVideo()),
                SizedBox(height: size.height * 0.04),
                TextField(
                  controller: _titleController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    label: Text("Title"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                TextField(
                  controller: _locationController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    label: Text("Location"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                TextField(
                  controller: _categoryController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    label: Text("Category"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                (isCaptured)
                    ? MaterialButton(
                        child: Text(
                          "Submit Object",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        onPressed: () async {
                          await userCollection
                              .doc(user!.uid)
                              .get()
                              .then((doc) => data = doc.data())
                              .catchError((error) => {
                                    print("Error on get data from User"),
                                    print(error.toString())
                                  });
                          String imgURL = data['photoURL'];
                          Reference ref = FirebaseStorage.instance
                              .ref('users Video')
                              .child(path.basename(file!.path));
                          FirebaseFirestore _fireStore =
                              FirebaseFirestore.instance;
                          try {
                            await ref.putFile(File(file!.path));
                            ref.getDownloadURL().then((value) {
                              _fireStore.collection('Videos').doc().set({
                                "Video URL": value,
                                "title": _titleController.text,
                                "location": _locationController.text,
                                "category": _categoryController.text,
                                "userName": _auth.currentUser!.displayName,
                              });
                            });
                            print(ref);
                            Fluttertoast.showToast(
                              msg: "Video uploaded successfully",
                              toastLength: Toast.LENGTH_LONG,
                            );
                          } catch (e) {
                            print(e);
                          }
                          Navigator.pop(context);
                        },
                        color: Color.fromRGBO(0, 179, 134, 1.0),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _previewVideo() {
    if (_controller == null) {
      return const Text(
        'You have not yet picked a video',
        textAlign: TextAlign.center,
      );
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AspectRatioVideo(_controller),
    );
  }

  Future<void> _playVideo(XFile? file) async {
    if (file != null && mounted) {
      print("Loading Video");
      await _disposeVideoController();
      late VideoPlayerController controller;
      /*if (kIsWeb) {
        controller = VideoPlayerController.network(file.path);
      } else {*/
      controller = VideoPlayerController.file(File(file.path));
      //}
      _controller = controller;
      // In web, most browsers won't honor a programmatic call to .play
      // if the video has a sound track (and is not muted).
      // Mute the video so it auto-plays in web!
      // This is not needed if the call to .play is the result of user
      // interaction (clicking on a "play" button, for example).

      //await controller.setVolume(volume);
      await controller.initialize();
      await controller.setLooping(true);
      await controller.play();
      setState(() {});
    } else {
      print("Loading Video error");
    }
  }

  Future<void> _disposeVideoController() async {
    /*  if (_toBeDisposed != null) {
      await _toBeDisposed!.dispose();
    }
    _toBeDisposed = _controller;*/
    if (_controller != null) {
      await _controller!.dispose();
    }
    _controller = null;
  }
}

class AspectRatioVideo extends StatefulWidget {
  AspectRatioVideo(this.controller);

  final VideoPlayerController? controller;

  @override
  AspectRatioVideoState createState() => AspectRatioVideoState();
}

class AspectRatioVideoState extends State<AspectRatioVideo> {
  VideoPlayerController? get controller => widget.controller;
  bool initialized = false;

  void _onVideoControllerUpdate() {
    if (!mounted) {
      return;
    }
    if (initialized != controller!.value.isInitialized) {
      initialized = controller!.value.isInitialized;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    controller!.addListener(_onVideoControllerUpdate);
  }

  @override
  void dispose() {
    controller!.removeListener(_onVideoControllerUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return Center(
        child: AspectRatio(
          aspectRatio: controller!.value.aspectRatio,
          child: VideoPlayer(controller!),
        ),
      );
    } else {
      return Container();
    }
  }
}
