import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:uuid/uuid.dart';
import 'package:meta/meta.dart';
import 'package:push_notification_example/data/post_model.dart';

part 'post_ad_cubit_state.dart';

class PostAdCubit extends Cubit<PostAdCubitState> {
  PostAdCubit() : super(PostAdCubitInitial());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> postAPost({
    required String description,
    required String imageUrl,
    required String title,
    required String price,
  }) async {
    emit(PostAdLoading());

    String id = const Uuid().v1();

    final postModel = PostModel(
      price: price,
      description: description,
      time: FieldValue.serverTimestamp(),
      id: id,
      imageUrl: imageUrl,
      title: title,
    );

    try {
      await _firestore.collection("posts").doc(id).set(postModel.toJson());
      emit(PostAdSuccess());
    } catch (e) {
      emit(PostAdError(error: e.toString()));
    }
  }
}
