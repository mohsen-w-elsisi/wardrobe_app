import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:wardrobe_app/cloth_item_editers/new_cloth_item_manager.dart';

class NewItemCameraDialog extends StatefulWidget {
  final NewClothItemManager newClothItemManager;

  const NewItemCameraDialog({required this.newClothItemManager, super.key});

  @override
  State<NewItemCameraDialog> createState() => _NewItemCameraDialogState();
}

class _NewItemCameraDialogState extends State<NewItemCameraDialog> {
  late final CameraController _cameraController;
  late final Future<void> _cameraControllerFuture;

  @override
  void initState() {
    super.initState();
    _cameraControllerFuture = _initCameraController();
  }

  Future<void> _initCameraController() async {
    // TODO: what if device has no camera
    final camera = (await availableCameras()).firstOrNull!;
    final cameraController = CameraController(
      camera,
      ResolutionPreset.medium,
    );
    await cameraController.initialize();
    _cameraController = cameraController;
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: FutureBuilder(
        future: _cameraControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Expanded(child: CameraPreview(_cameraController)),
                Container(
                  color: Colors.black,
                  height: 125,
                  padding: const EdgeInsets.all(24),
                  child: GestureDetector(
                    onTap: _takePhoto,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                )
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  void _takePhoto() async {
    final photoXFile = await _cameraController.takePicture();
    final photoBytes = await File(photoXFile.path).readAsBytes();
    widget.newClothItemManager.image = photoBytes;
  }
}
