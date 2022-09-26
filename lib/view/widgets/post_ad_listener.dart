import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubit/Post_Ad_Cubit/post_ad_cubit_cubit.dart';

class PostAdListener extends StatelessWidget {
  final BuildContext accountContext;
  const PostAdListener({Key? key, required this.accountContext})
      : super(key: key);

  _showSnackBar(
      {required BuildContext context,
      required String desc,
      required String title}) {
    ScaffoldMessenger.of(accountContext).showSnackBar(
      SnackBar(
        content: Text(desc),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: title,
          onPressed: () {},
        ),
      ),
    );
  }

  _showDialog(BuildContext context) {
    return const AlertDialog(
      backgroundColor: Colors.transparent,
      content: Center(child: CircularProgressIndicator()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocListener<PostAdCubit, PostAdCubitState?>(
          listenWhen: (previous, current) {
            return current != previous;
          },
          listener: (context, state) {
            if (state is PostAdError) {
              Navigator.pop(accountContext);
              _showSnackBar(
                  context: accountContext, desc: state.error, title: "Error");
            } else if (state is PostAdLoading) {
              showDialog(
                  context: accountContext,
                  builder: (context) {
                    return _showDialog(accountContext);
                  });
            } else if (state is PostAdSuccess) {
              Navigator.pop(accountContext);
            }
          },
          child: const SizedBox(),
        ),
      ],
    );
  }
}
