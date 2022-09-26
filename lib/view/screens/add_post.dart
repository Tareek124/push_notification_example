import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:push_notification_example/colors.dart';
import '../../logic/cubit/Post_Ad_Cubit/post_ad_cubit_cubit.dart';
import '../../logic/functions/pick_image.dart';
import '../../logic/functions/send_notification.dart';
import '../../logic/functions/storage_method.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/post_ad_listener.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  Uint8List? imageFile;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  String? imageUrl;

  selectImage(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Create a Post',
            style: TextStyle(),
          ),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo', style: TextStyle()),
                onPressed: () async {
                  Navigator.pop(context);
                  var permissions = await Permission.camera.request();
                  if (permissions.isGranted) {
                    Uint8List file = await pickImage(ImageSource.camera);
                    setState(() {
                      imageFile = file;
                    });
                    imageUrl = await StorageMethods()
                        .uploadImageToStorage("postPic", imageFile!);
                    print(
                        "===================================url======================================");
                    print(imageUrl);
                  } else {
                    print("Denied");
                  }
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery',
                    style: TextStyle(
                      color: Colors.black,
                    )),
                onPressed: () async {
                  Navigator.of(context).pop();
                  var permissions = await Permission.storage.request();
                  if (permissions.isGranted) {
                    Uint8List file = await pickImage(ImageSource.gallery);
                    setState(() {
                      imageFile = file;
                    });
                    imageUrl = await StorageMethods().uploadImageToStorage(
                      "postPic",
                      imageFile!,
                    );
                  } else {
                    print("Denied");
                  }
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel", style: TextStyle()),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void clear() {
    setState(() {
      imageUrl = null;
      descriptionController.clear();
      titleController.clear();
      priceController.clear();
    });
  }

  @override
  void dispose() {
    super.dispose();
    descriptionController.dispose();
    titleController.dispose();
    priceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: Center(
            child: Column(
              children: [
                PostAdListener(accountContext: context),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    await selectImage(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: purple,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(25)),
                    width: double.infinity,
                    height: 200,
                    child: imageFile == null
                        ? Icon(
                            Icons.add_a_photo,
                            size: 70,
                            color: Colors.black.withOpacity(0.5),
                          )
                        : Image.memory(imageFile!, fit: BoxFit.contain),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomTextFieldOutline(
                  controller: titleController,
                  maxLines: 1,
                  label: "Title",
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomTextFieldOutline(
                  controller: descriptionController,
                  maxLines: 4,
                  label: "Description",
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomTextFieldOutline(
                  controller: priceController,
                  maxLines: 1,
                  label: "Price",
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 80,
                ),
                CustomButton(
                  text: "Post",
                  function: () {
                    BlocProvider.of<PostAdCubit>(context)
                        .postAPost(
                            price: priceController.text,
                            description: descriptionController.text,
                            imageUrl: imageUrl!,
                            title: titleController.text)
                        .whenComplete(() {
                      callOnFcmApiSendPushNotifications(
                          title: titleController.text,
                          imageUrl: imageUrl!,
                          description: descriptionController.text,
                          price: priceController.text);
                      clear();
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
