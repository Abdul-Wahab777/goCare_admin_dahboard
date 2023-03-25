import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:thinkcreative_technologies/Configs/NumberLimits.dart';
import 'package:thinkcreative_technologies/Services/providers/Observer.dart';
import 'package:thinkcreative_technologies/Widgets/dialogs/CustomDialog.dart';
import 'package:thinkcreative_technologies/Widgets/dialogs/UploadAndDownload.dart';

final videoInfo = FlutterVideoInfo();

class FirebaseUploader {
  String thumbnailurl = '';
  Future<String?> uploadFile(
      {required BuildContext context,
      GlobalKey? scaffoldkey,
      required GlobalKey keyLoader,
      required File file,
      String? fileType,
      String? filename,
      String? collection,
      String? folder}) async {
    // final timep=Provider.of<CurrentTime>(context,listen: false);
    Reference storageReference;
    // if (fileType == 'image') {s
    storageReference =
        FirebaseStorage.instance.ref().child("$collection/$folder/$filename");
    // }
    try {
      String extensiontype =
          file.absolute.path.substring(file.absolute.path.lastIndexOf("."));
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path + "/$filename$extensiontype";

      // final targetPath = file.absolute.path + "/unnamed.png";
      print('EXTESNION TYPE: $extensiontype');

      File? compressedFile = (extensiontype == '.png' ||
              extensiontype == '.jpg' ||
              extensiontype == '.jpeg' ||
              extensiontype == '.webp')
          ? await (FlutterImageCompress.compressAndGetFile(
              file.absolute.path,
              tempPath,
              quality: Numberlimits.imageCompressQuality,
              format: extensiontype == '.png'
                  ? CompressFormat.png
                  : extensiontype == '.jpeg'
                      ? CompressFormat.jpeg
                      : extensiontype == '.jpg'
                          ? CompressFormat.jpeg
                          : CompressFormat.webp,
              rotate: Numberlimits.imageCompressRotationAngle,
            ))
          : file;
      // StorageTaskSnapshot uploading = await reference
      //       .putFile(isthumbnail == true ? thumbnailFile : imageFile)
      //       .onComplete;   Reference reference = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = storageReference.putFile(compressedFile!);

      showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return new WillPopScope(
                onWillPop: () async => false,
                child: SimpleDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    // side: BorderSide(width: 5, color: Colors.green)),
                    key: keyLoader,
                    backgroundColor: Colors.white,
                    children: <Widget>[
                      Center(
                        child: StreamBuilder<TaskSnapshot>(
                            stream: uploadTask.snapshotEvents,
                            builder: (BuildContext context, snapshot) {
                              if (snapshot.hasData) {
                                final snap = snapshot.data!;
                                final progress = snap.bytesTransferred > 0
                                    ? 0.001
                                    : snap.bytesTransferred / snap.totalBytes;
                                print('progres::::: $progress');
                                final percentage =
                                    (progress * 100).toStringAsFixed(2);

                                return openUploadDownloaddialog(
                                  context: context,
                                  percent: double.tryParse(percentage),
                                  title: 'Uploading ...',
                                  subtitle:
                                      "${((((snap.bytesTransferred / 1024) / 1000) * 100).roundToDouble()) / 100}/${((((snap.totalBytes / 1024) / 1000) * 100).roundToDouble()) / 100} MB",
                                );
                              } else {
                                return openUploadDownloaddialog(
                                  context: context,
                                  percent: 0.0,
                                  title: 'Uploading...',
                                  subtitle: "Starting...",
                                );
                              }
                            }),
                      ),
                    ]));
          });

      final snapshot = await uploadTask.whenComplete(() {});
      final url = await snapshot.ref.getDownloadURL();
      Navigator.of(keyLoader.currentContext!, rootNavigator: true).pop(); //

      return url;
    } catch (error) {
      Navigator.of(keyLoader.currentContext!, rootNavigator: true).pop(); //
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
              // ignore: missing_return
              onWillPop: () {} as Future<bool> Function()?,
              child: AlertDialog(
                title: new Text(
                  "Could not Load!",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                content: new SingleChildScrollView(
                  child: Text('Please check you Internet Connection & Retry'),
                ),
                actions: <Widget>[
                  new ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                    ),
                    child: new Text("OK"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ));
        },
      );

      print('ERROR ISSSSSSS:::::::::$error');
      return null;
    }
  }

  Image? image;

  Future<bool> deleteFile(
      {BuildContext? context,
      GlobalKey? scaffoldkey,
      GlobalKey? mykeyLoader,
      String? fileType,
      String? filename,
      bool? isDeleteUsingUrl,
      bool? isshowloader,
      String? collection,
      String? folder,
      String? url}) async {
    // final timep=Provider.of<CurrentTime>(context,listen: false);

    // }
    if (isshowloader == null || isshowloader == true) {
      ShowLoading().open(context: context!, key: mykeyLoader);
    }
    Reference storageref = isDeleteUsingUrl == true
        ? FirebaseStorage.instance.refFromURL(url!)
        : FirebaseStorage.instance.ref().child("$collection/$folder");
//  StorageReference storageReference =
    try {
      if (isDeleteUsingUrl == true) {
        await storageref.delete().then((value) {
          if (isshowloader == null || isshowloader == true) {
            ShowLoading().close(context: context, key: mykeyLoader!);
          }

          return true;
        });
      } else {
        await storageref.child("$filename").delete().then((value) {
          if (isshowloader == null || isshowloader == true) {
            ShowLoading().close(context: context, key: mykeyLoader!);
          }

          return true;
        });
      }
    } catch (onError) {
      final observer = Provider.of<Observer>(context!, listen: false);
      if (isshowloader == null || isshowloader == true) {
        Navigator.of(mykeyLoader!.currentContext!, rootNavigator: true)
            .pop(); //
      }

      ShowCustomAlertDialog().open(
        context: scaffoldkey!.currentContext!,
        errorlog: onError.toString(),
        isshowerrorlog: observer.isshowerrorlog,
        dialogtype: 'error',
      );

      return false;
    }
    return true;
  }
}

firestoreupdatedoc(
    {BuildContext? context,
    GlobalKey? scaffoldkey,
    GlobalKey? keyloader,
    String? collection,
    DocumentReference? ref,
    bool isloadingshow = true,
    String? document,
    var updatemap}) async {
  if (isloadingshow = true) {
    ShowLoading().open(context: context!, key: keyloader);
  }

  DocumentReference reference =
      ref ?? FirebaseFirestore.instance.collection(collection!).doc(document);

  reference.set(updatemap, SetOptions(merge: true)).then((value) {
    if (isloadingshow = true) {
      ShowLoading().close(context: context, key: keyloader!);
    }
  }).catchError((error) {
    if (isloadingshow = true) {
      ShowLoading().close(context: context, key: keyloader!);
    }
    print('Error: $error');
    ShowSnackbar().open(
        context: context,
        scaffoldKey: scaffoldkey as GlobalKey<ScaffoldState>,
        status: 1,
        time: 3,
        label: 'Error Occured : $error');
  });
}

firestoredeletedoc(
    {required BuildContext context,
    GlobalKey? scaffoldkey,
    GlobalKey? keyloader,
    required String collection,
    String? document,
    bool? ispop}) async {
  ShowLoading().open(context: context, key: keyloader);
  await FirebaseFirestore.instance
      .collection(collection)
      .doc(document)
      .delete()
      .then((value) {
    ShowLoading().close(context: context, key: keyloader!);
    if (ispop == false || ispop == null) {
      ShowSnackbar().open(
          context: context,
          scaffoldKey: scaffoldkey as GlobalKey<ScaffoldState>,
          status: 2,
          time: 3,
          label: 'Delete Operation Successfull !');
    } else {
      ShowSnackbar().open(
          context: context,
          scaffoldKey: scaffoldkey as GlobalKey<ScaffoldState>,
          status: 2,
          time: 3,
          label: 'Delete Operation Successfull !');

      Navigator.pop(context);
    }
  }).catchError((error) {
    ShowLoading().close(context: context, key: keyloader!);
    print('Error: $error');
    ShowSnackbar().open(
        context: context,
        scaffoldKey: scaffoldkey as GlobalKey<ScaffoldState>,
        status: 1,
        time: 3,
        label: 'Error Occured : $error');
  });
}
