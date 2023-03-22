import 'dart:io';

import 'package:camera/camera.dart';
import 'package:family/screen/signup/photo_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SignUpCamera extends StatefulWidget {
  final Function setImage;
  final VoidCallback closeCamera;
  const SignUpCamera(
      {super.key, required this.setImage, required this.closeCamera});

  @override
  State<SignUpCamera> createState() => _SignUpCameraState();
}

void _logError(String code, String? message) {
  // ignore: avoid_print
  print('Error: $code${message == null ? '' : '\nError Message: $message'}');
}

class _SignUpCameraState extends State<SignUpCamera> {
  CameraController? controller;
  XFile? imageFile;
  // bool isOpenCamera = false;
  bool isCameraFront = false;
  File? finalImage;

  int _pointers = 0;
  double _baseScale = 1.0;
  double _currentScale = 1.0;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;

  List<CameraDescription> _cameras = <CameraDescription>[];

  void setUpCamera() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      _cameras = await availableCameras();
    } on CameraException catch (e) {
      _logError(e.code, e.description);
    } finally {
      onNewCameraSelected(_cameras[1]);
    }
  }

  @override
  void initState() {
    super.initState();
    setUpCamera();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SizedBox(
            height: size.height * 0.65,
            width: size.width * 1,
            child: _cameraPreviewWidget(),
          ),
        ),

        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SizedBox(
            height: size.height * 0.35,
            width: size.width * 1,
            child: PhotoSelector(
              setImage: widget.setImage,
              closeCamera: widget.closeCamera,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SizedBox(
            height: size.height * 0.35,
            width: size.width * 1,
            child: Align(
              alignment: Alignment.topRight,
              child: _cameraTogglesRowWidget(),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SizedBox(
            height: size.height * 0.35,
            width: size.width * 1,
            child: Align(
              alignment: Alignment.topCenter,
              child: _captureControlRowWidget(),
            ),
          ),
        ),
        // finalImage != null
        //     ? Image.file(finalImage as File)
        //     : Container(),
      ],
    );
  }

  Widget _cameraPreviewWidget() {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return Container();
    } else {
      return Listener(
        onPointerDown: (_) => _pointers++,
        onPointerUp: (_) => _pointers--,
        child: CameraPreview(
          controller!,
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onScaleStart: _handleScaleStart,
              onScaleUpdate: _handleScaleUpdate,
              onTapDown: (TapDownDetails details) =>
                  onViewFinderTap(details, constraints),
            );
          }),
        ),
      );
    }
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _baseScale = _currentScale;
  }

  Future<void> _handleScaleUpdate(ScaleUpdateDetails details) async {
    if (controller == null || _pointers != 2) {
      return;
    }

    _currentScale = (_baseScale * details.scale)
        .clamp(_minAvailableZoom, _maxAvailableZoom);

    await controller!.setZoomLevel(_currentScale);
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (controller == null) {
      return;
    }
  }

  Widget _cameraTogglesRowWidget() {
    // final List<Widget> toggles = <Widget>[];
    Widget widget;

    void onChanged(CameraDescription? description) {
      if (description == null) {
        return;
      }

      onNewCameraSelected(description);
    }

    if (_cameras.isEmpty) {
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        showInSnackBar('No camera found.');
      });
      return const Text('None');
    } else {
      widget = isCameraFront
          ? ElevatedButton(
              onPressed: () {
                onChanged(_cameras[1]); //back camera
                setState(() {
                  isCameraFront = !isCameraFront;
                });
              },
              child: const Icon(Icons.face))
          : ElevatedButton(
              onPressed: () {
                onChanged(_cameras[0]); //front camera
                setState(() {
                  isCameraFront = !isCameraFront;
                });
              },
              child: const Icon(Icons.camera_alt));
      // for (final CameraDescription cameraDescription in _cameras) {
      //   print(cameraDescription);
      //   toggles.add(
      //     SizedBox(
      //       width: 90.0,
      //       child: RadioListTile<CameraDescription>(
      //         title: Icon(Icons.camera),
      //         groupValue: controller?.description,
      //         value: cameraDescription,
      //         onChanged:
      //             controller != null && controller!.value.isRecordingVideo
      //                 ? null
      //                 : onChanged,
      //       ),
      //     ),
      //   );
      // }
    }
    return widget;
    // return Row(children: toggles);
  }

  Future<void> onNewCameraSelected(CameraDescription cameraDescription) async {
    final CameraController? oldController = controller;
    if (oldController != null) {
      // `controller` needs to be set to null before getting disposed,
      // to avoid a race condition when we use the controller that is being
      // disposed. This happens when camera permission dialog shows up,
      // which triggers `didChangeAppLifecycleState`, which disposes and
      // re-creates the controller.
      controller = null;
      await oldController.dispose();
    }

    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    controller = cameraController;

    // If the controller is updated then update the UI.
    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
      if (cameraController.value.hasError) {
        showInSnackBar(
            'Camera error ${cameraController.value.errorDescription}');
      }
    });

    try {
      await cameraController.initialize();
      await Future.wait(<Future<Object?>>[
        // The exposure mode is currently not supported on the web.
        // ...!kIsWeb
        //     ? <Future<Object?>>[
        //         cameraController.getMinExposureOffset().then(
        //             (double value) => _minAvailableExposureOffset = value),
        //         cameraController
        //             .getMaxExposureOffset()
        //             .then((double value) => _maxAvailableExposureOffset = value)
        //       ]
        //     : <Future<Object?>>[],
        cameraController
            .getMaxZoomLevel()
            .then((double value) => _maxAvailableZoom = value),
        cameraController
            .getMinZoomLevel()
            .then((double value) => _minAvailableZoom = value),
      ]);
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          showInSnackBar('You have denied camera access.');
          break;
        case 'CameraAccessDeniedWithoutPrompt':
          // iOS only
          showInSnackBar('Please go to Settings app to enable camera access.');
          break;
        case 'CameraAccessRestricted':
          // iOS only
          showInSnackBar('Camera access is restricted.');
          break;
        case 'AudioAccessDenied':
          showInSnackBar('You have denied audio access.');
          break;
        case 'AudioAccessDeniedWithoutPrompt':
          // iOS only
          showInSnackBar('Please go to Settings app to enable audio access.');
          break;
        case 'AudioAccessRestricted':
          // iOS only
          showInSnackBar('Audio access is restricted.');
          break;
        default:
          _showCameraException(e);
          break;
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  //camera to take picture
  _captureControlRowWidget() {
    final CameraController? cameraController = controller;
    return IconButton(
      icon: const Icon(Icons.camera_alt),
      color: Colors.blue,
      onPressed: cameraController != null &&
              cameraController.value.isInitialized &&
              !cameraController.value.isRecordingVideo
          ? onTakePictureButtonPressed
          : null,
    );
  }

  void onTakePictureButtonPressed() {
    takePicture().then((XFile? file) {
      if (mounted) {
        setState(() {
          imageFile = file;
          finalImage = File(imageFile!.path);
          widget.setImage(finalImage);
          widget.closeCamera();
          // isOpenCamera = !isOpenCamera;
        });
        if (file != null) {
          showInSnackBar('Picture saved to ${file.path}');
        }
      }
    });
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      final XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  //exception and messages
  void showInSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _showCameraException(CameraException e) {
    _logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }
}
