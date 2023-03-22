import 'dart:io';

// import 'package:camera/camera.dart';
import 'package:family/screen/signup/signup_camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/login_sign_provider.dart';
// import 'package:flutter/scheduler.dart';

class SignUp extends StatefulWidget {
  final String email;
  final String username;
  final String password;

  const SignUp(
      {super.key,
      required this.email,
      required this.username,
      required this.password});

  @override
  State<SignUp> createState() => _SignUpState();
}

// void _logError(String code, String? message) {
//   // ignore: avoid_print
//   print('Error: $code${message == null ? '' : '\nError Message: $message'}');
// }

class _SignUpState extends State<SignUp> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();

  // CameraController? controller;
  // XFile? imageFile;
  bool isOpenCamera = false;
  // bool isCameraFront = false;
  File? finalImage;

  void _showDialog(bool option) {
    String message = '';
    option == false
        ? message = 'account successfully created'
        : message = 'username has been used';
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: option == false
            ? const Text('Succeed')
            : const Text('An Error Occured'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Okay'),
          ),
        ],
      ),
    );
  }

  // int _pointers = 0;
  // double _baseScale = 1.0;
  // double _currentScale = 1.0;
  // double _minAvailableZoom = 1.0;
  // double _maxAvailableZoom = 1.0;

  // List<CameraDescription> _cameras = <CameraDescription>[];

  // void setUpCamera() async {
  //   try {
  //     WidgetsFlutterBinding.ensureInitialized();
  //     _cameras = await availableCameras();
  //   } on CameraException catch (e) {
  //     _logError(e.code, e.description);
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   setUpCamera();
  // }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    aboutController.dispose();
  }

  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   final CameraController? cameraController = controller;

  //   // App state changed before we got the chance to initialize.
  //   if (cameraController == null || !cameraController.value.isInitialized) {
  //     return;
  //   }

  //   if (state == AppLifecycleState.inactive) {
  //     cameraController.dispose();
  //   } else if (state == AppLifecycleState.resumed) {
  //     onNewCameraSelected(cameraController.description);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final loginSignProvider =
        Provider.of<LoginSignProvider>(context, listen: false);

    // final arguments =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // final String email = arguments['email'] as String;
    // final String password = arguments['password'] as String;
    // final String username = arguments['username'] as String;

    // print(email);

    void setImage(File fileImage) {
      setState(() {
        finalImage = fileImage;
      });
    }

    void closeCamera() {
      isOpenCamera = !isOpenCamera;
    }

    return
        // Scaffold(
        //   // appBar: AppBar(),
        //   body: !isOpenCamera
        //       ? SafeArea(
        //           child: SingleChildScrollView(
        //             physics: const BouncingScrollPhysics(),
        //             child:
        !isOpenCamera
            ? Column(
                children: [
                  Container(
                    height: size.height * 0.4,
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          //just navigate to signUpCamera
                          isOpenCamera = !isOpenCamera;
                          // onNewCameraSelected(_cameras[1]);
                        });
                      },
                      child: CircleAvatar(
                        radius: size.width * 0.3,
                        backgroundImage: finalImage == null
                            ? const NetworkImage(
                                "https://st4.depositphotos.com/14953852/24787/v/450/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg")
                            : FileImage(finalImage!) as ImageProvider,
                      ),
                    ),
                  ),
                  SizedBox(
                    // color: Colors.blue,
                    height: size.height * 0.1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10, bottom: 5),
                          child: Text(
                            "name",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.pink,
                            ),
                            child: TextField(
                              controller: nameController,
                              decoration: const InputDecoration.collapsed(
                                hintText: "",
                              ),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    height: size.height * 0.35,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10, bottom: 5),
                          child: Text(
                            "about",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.pink,
                            ),
                            child: TextField(
                              controller: aboutController,
                              decoration: const InputDecoration.collapsed(
                                hintText: "",
                              ),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                        onPressed: () async {
                          final name = nameController.text;
                          final about = aboutController.text;

                          final userAvailablity = await loginSignProvider
                              .findUserAvailable(widget.username);

                          if (!userAvailablity) {
                            loginSignProvider.createUser(
                              widget.username,
                              widget.email,
                              widget.password,
                              finalImage as File,
                              name,
                              about,
                            );
                          }

                          _showDialog(userAvailablity);
                        },
                        child: const Text("Next")),
                  )
                ],
              )
            : SizedBox(
                height: size.height * 1,
                child: SignUpCamera(
                  setImage: setImage,
                  closeCamera: closeCamera,
                ),
              );
    //   ),
    // )

    // : SingleChildScrollView(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         SizedBox(
    //           height: size.height * 0.65,
    //           width: size.width * 1,
    //           child: _cameraPreviewWidget(),
    //         ),
    //         _cameraTogglesRowWidget(),
    //         _captureControlRowWidget(),
    //         // finalImage != null
    //         //     ? Image.file(finalImage as File)
    //         //     : Container(),
    //       ],
    //     ),
    //   ),
    // );
  }

  // Widget _cameraPreviewWidget() {
  //   final CameraController? cameraController = controller;

  //   if (cameraController == null || !cameraController.value.isInitialized) {
  //     return Container();
  //   } else {
  //     return Listener(
  //       onPointerDown: (_) => _pointers++,
  //       onPointerUp: (_) => _pointers--,
  //       child: CameraPreview(
  //         controller!,
  //         child: LayoutBuilder(
  //             builder: (BuildContext context, BoxConstraints constraints) {
  //           return GestureDetector(
  //             behavior: HitTestBehavior.opaque,
  //             onScaleStart: _handleScaleStart,
  //             onScaleUpdate: _handleScaleUpdate,
  //             onTapDown: (TapDownDetails details) =>
  //                 onViewFinderTap(details, constraints),
  //           );
  //         }),
  //       ),
  //     );
  //   }
  // }

  // void _handleScaleStart(ScaleStartDetails details) {
  //   _baseScale = _currentScale;
  // }

  // Future<void> _handleScaleUpdate(ScaleUpdateDetails details) async {
  //   if (controller == null || _pointers != 2) {
  //     return;
  //   }

  //   _currentScale = (_baseScale * details.scale)
  //       .clamp(_minAvailableZoom, _maxAvailableZoom);

  //   await controller!.setZoomLevel(_currentScale);
  // }

  // void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
  //   if (controller == null) {
  //     return;
  //   }
  // }

  // Widget _cameraTogglesRowWidget() {
  //   // final List<Widget> toggles = <Widget>[];
  //   Widget widget;

  //   void onChanged(CameraDescription? description) {
  //     if (description == null) {
  //       return;
  //     }

  //     onNewCameraSelected(description);
  //   }

  //   if (_cameras.isEmpty) {
  //     SchedulerBinding.instance.addPostFrameCallback((_) async {
  //       showInSnackBar('No camera found.');
  //     });
  //     return const Text('None');
  //   } else {
  //     widget = isCameraFront
  //         ? ElevatedButton(
  //             onPressed: () {
  //               onChanged(_cameras[1]); //back camera
  //               setState(() {
  //                 isCameraFront = !isCameraFront;
  //               });
  //             },
  //             child: const Icon(Icons.camera))
  //         : ElevatedButton(
  //             onPressed: () {
  //               onChanged(_cameras[0]); //front camera
  //               setState(() {
  //                 isCameraFront = !isCameraFront;
  //               });
  //             },
  //             child: const Icon(Icons.camera_alt_outlined));
  //     // for (final CameraDescription cameraDescription in _cameras) {
  //     //   print(cameraDescription);
  //     //   toggles.add(
  //     //     SizedBox(
  //     //       width: 90.0,
  //     //       child: RadioListTile<CameraDescription>(
  //     //         title: Icon(Icons.camera),
  //     //         groupValue: controller?.description,
  //     //         value: cameraDescription,
  //     //         onChanged:
  //     //             controller != null && controller!.value.isRecordingVideo
  //     //                 ? null
  //     //                 : onChanged,
  //     //       ),
  //     //     ),
  //     //   );
  //     // }
  //   }
  //   return widget;
  //   // return Row(children: toggles);
  // }

  // Future<void> onNewCameraSelected(CameraDescription cameraDescription) async {
  //   final CameraController? oldController = controller;
  //   if (oldController != null) {
  //     // `controller` needs to be set to null before getting disposed,
  //     // to avoid a race condition when we use the controller that is being
  //     // disposed. This happens when camera permission dialog shows up,
  //     // which triggers `didChangeAppLifecycleState`, which disposes and
  //     // re-creates the controller.
  //     controller = null;
  //     await oldController.dispose();
  //   }

  //   final CameraController cameraController = CameraController(
  //     cameraDescription,
  //     ResolutionPreset.medium,
  //     enableAudio: false,
  //     imageFormatGroup: ImageFormatGroup.jpeg,
  //   );

  //   controller = cameraController;

  //   // If the controller is updated then update the UI.
  //   cameraController.addListener(() {
  //     if (mounted) {
  //       setState(() {});
  //     }
  //     if (cameraController.value.hasError) {
  //       showInSnackBar(
  //           'Camera error ${cameraController.value.errorDescription}');
  //     }
  //   });

  //   try {
  //     await cameraController.initialize();
  //     await Future.wait(<Future<Object?>>[
  //       // The exposure mode is currently not supported on the web.
  //       // ...!kIsWeb
  //       //     ? <Future<Object?>>[
  //       //         cameraController.getMinExposureOffset().then(
  //       //             (double value) => _minAvailableExposureOffset = value),
  //       //         cameraController
  //       //             .getMaxExposureOffset()
  //       //             .then((double value) => _maxAvailableExposureOffset = value)
  //       //       ]
  //       //     : <Future<Object?>>[],
  //       cameraController
  //           .getMaxZoomLevel()
  //           .then((double value) => _maxAvailableZoom = value),
  //       cameraController
  //           .getMinZoomLevel()
  //           .then((double value) => _minAvailableZoom = value),
  //     ]);
  //   } on CameraException catch (e) {
  //     switch (e.code) {
  //       case 'CameraAccessDenied':
  //         showInSnackBar('You have denied camera access.');
  //         break;
  //       case 'CameraAccessDeniedWithoutPrompt':
  //         // iOS only
  //         showInSnackBar('Please go to Settings app to enable camera access.');
  //         break;
  //       case 'CameraAccessRestricted':
  //         // iOS only
  //         showInSnackBar('Camera access is restricted.');
  //         break;
  //       case 'AudioAccessDenied':
  //         showInSnackBar('You have denied audio access.');
  //         break;
  //       case 'AudioAccessDeniedWithoutPrompt':
  //         // iOS only
  //         showInSnackBar('Please go to Settings app to enable audio access.');
  //         break;
  //       case 'AudioAccessRestricted':
  //         // iOS only
  //         showInSnackBar('Audio access is restricted.');
  //         break;
  //       default:
  //         _showCameraException(e);
  //         break;
  //     }
  //   }

  //   if (mounted) {
  //     setState(() {});
  //   }
  // }

  // //camera to take picture
  // _captureControlRowWidget() {
  //   final CameraController? cameraController = controller;
  //   return IconButton(
  //     icon: const Icon(Icons.camera_alt),
  //     color: Colors.blue,
  //     onPressed: cameraController != null &&
  //             cameraController.value.isInitialized &&
  //             !cameraController.value.isRecordingVideo
  //         ? onTakePictureButtonPressed
  //         : null,
  //   );
  // }

  // void onTakePictureButtonPressed() {
  //   takePicture().then((XFile? file) {
  //     if (mounted) {
  //       setState(() {
  //         imageFile = file;
  //         finalImage = File(imageFile!.path);
  //         isOpenCamera = !isOpenCamera;
  //       });
  //       if (file != null) {
  //         showInSnackBar('Picture saved to ${file.path}');
  //       }
  //     }
  //   });
  // }

  // Future<XFile?> takePicture() async {
  //   final CameraController? cameraController = controller;
  //   if (cameraController == null || !cameraController.value.isInitialized) {
  //     showInSnackBar('Error: select a camera first.');
  //     return null;
  //   }

  //   if (cameraController.value.isTakingPicture) {
  //     // A capture is already pending, do nothing.
  //     return null;
  //   }

  //   try {
  //     final XFile file = await cameraController.takePicture();
  //     return file;
  //   } on CameraException catch (e) {
  //     _showCameraException(e);
  //     return null;
  //   }
  // }

  // //exception and messages
  // void showInSnackBar(String message) {
  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(SnackBar(content: Text(message)));
  // }

  // void _showCameraException(CameraException e) {
  //   _logError(e.code, e.description);
  //   showInSnackBar('Error: ${e.code}\n${e.description}');
  // }
}
