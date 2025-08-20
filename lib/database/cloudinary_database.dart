import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class CloudinaryService {
  final String cloudName;
  final String uploadPreset;

  CloudinaryService({required this.cloudName, required this.uploadPreset});

  Future<String?> uploadImage(File image) async {
    try {
      final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
      );

      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = uploadPreset
        ..files.add(await http.MultipartFile.fromPath('file', image.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        final res = await http.Response.fromStream(response);
        final data = jsonDecode(res.body);
        return data['secure_url'];
      } else {
        print("Cloudinary Upload failed: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Cloudinary Upload error: $e");
      return null;
    }
  }
}
