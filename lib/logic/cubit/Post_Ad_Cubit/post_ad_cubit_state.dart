part of 'post_ad_cubit_cubit.dart';

@immutable
abstract class PostAdCubitState {}

class PostAdCubitInitial extends PostAdCubitState {}

class PostAdInitial extends PostAdCubitInitial {}

class PostAdLoading extends PostAdCubitInitial {}

class PostAdError extends PostAdCubitInitial {
  final String error;
  PostAdError({required this.error});
}

class PostAdSuccess extends PostAdCubitInitial {}
