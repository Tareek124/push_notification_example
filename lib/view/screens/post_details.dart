import 'package:flutter/material.dart';
import 'package:push_notification_example/colors.dart';

class AdDetailsScreen extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String price;
  const AdDetailsScreen({
    Key? key,
    required this.imageUrl,
    required this.price,
    required this.description,
    required this.title,
  }) : super(key: key);

  Widget sliverAppBar() {
    return SliverAppBar(
      expandedHeight: 450,
      leadingWidth: double.infinity,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: Image.network(
          imageUrl,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  Widget characterInfo(String title, String desc) {
    return RichText(
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
      text: TextSpan(children: [
        TextSpan(
          text: "$title :   ",
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: purple),
        ),
        TextSpan(
          text: desc,
          style: const TextStyle(
              fontWeight: FontWeight.normal, fontSize: 22, color: purple),
        )
      ]),
    );
  }

  Widget buildDivider(double height) {
    return Divider(
      height: 30,
      endIndent: height,
      color: purple.withOpacity(0.3),
      thickness: 4,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          sliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildDivider(80),
                      characterInfo("Title", title),
                      buildDivider(170),
                      characterInfo("Description", description),
                      buildDivider(30),
                      characterInfo("Price", "$price EGP"),
                      buildDivider(170),
                      buildDivider(30),
                      const SizedBox(
                        height: 35,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
