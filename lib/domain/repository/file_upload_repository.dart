import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FileUploadRepository{
  Future<String?>uploadImage(File imageFile)async{

    try {
    // Generate a unique filename
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    // Reference to the Firebase Storage location
    Reference storageReference = FirebaseStorage.instance.ref().child('images/$fileName.jpg');

    // Upload the image
    await storageReference.putFile(imageFile);

    // Get the download URL
    String downloadURL = await storageReference.getDownloadURL();

    // Return the download URL
    return downloadURL;
  } catch (error) {
    log('Error uploading image: $error');
    return null;
  }
  }
}