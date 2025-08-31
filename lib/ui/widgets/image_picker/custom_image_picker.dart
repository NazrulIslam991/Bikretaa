import 'dart:io';

import 'package:bikretaa/ui/widgets/snack_bar_messege/snackbar_messege.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palette_generator/palette_generator.dart';

class CustomImagePicker extends StatefulWidget {
  final Function(File) onImageSelected;
  final double height;
  final double width;

  const CustomImagePicker({
    super.key,
    required this.onImageSelected,
    required this.height,
    required this.width,
  });

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  XFile? _selectedImageFile;
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  Color _imageBackgroundColor = Colors.grey[200]!;

  @override
  void initState() {
    super.initState();
    _handleLostData();
  }

  Future<void> _updateImageBackgroundColor(File imageFile) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(FileImage(imageFile));
    setState(() {
      _imageBackgroundColor =
          paletteGenerator.dominantColor?.color ?? Colors.grey[200]!;
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 600,
        maxHeight: 600,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        _selectedImageFile = pickedFile;
        _selectedImage = File(pickedFile.path);
        await _updateImageBackgroundColor(_selectedImage!);
        widget.onImageSelected(_selectedImage!);
        setState(() {});
      }
    } catch (e) {
      showSnackbarMessage(context, 'Error picking image: $e');
    }
  }

  Future<void> _handleLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) return;

    final XFile? file = response.file;
    if (file != null) {
      _selectedImageFile = file;
      _selectedImage = File(file.path);
      await _updateImageBackgroundColor(_selectedImage!);
      widget.onImageSelected(_selectedImage!);
      setState(() {});
    } else if (response.exception != null) {
      showSnackbarMessage(context, 'Error retrieving lost image data');
    }
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Select Image",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 20.r,
                        backgroundColor: Colors.grey[200],
                        child: IconButton(
                          icon: Icon(Icons.photo_library, size: 20.sp),
                          onPressed: () {
                            Navigator.of(context).pop();
                            _pickImage(ImageSource.gallery);
                          },
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text("Gallery"),
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 20.r,
                        backgroundColor: Colors.grey[200],
                        child: IconButton(
                          icon: Icon(Icons.camera_alt, size: 20.sp),
                          onPressed: () {
                            Navigator.of(context).pop();
                            _pickImage(ImageSource.camera);
                          },
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text("Camera"),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.h),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showImagePickerOptions,
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12.r),
          color: _selectedImage == null
              ? Colors.grey[200]
              : _imageBackgroundColor,
        ),
        child: _selectedImage != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.file(
                  _selectedImage!,
                  fit: BoxFit.contain,
                  width: widget.width,
                  height: widget.height,
                ),
              )
            : Center(
                child: Text(
                  "Tap to select image",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
      ),
    );
  }
}
