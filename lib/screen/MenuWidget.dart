import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  final List<String> menuImgList;

  MenuWidget({
    required this.menuImgList,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (int i = 0; i < menuImgList.length; i++)
          _buildMenu(menuImgList[i]),
      ],
    );
  }

  Widget _buildMenu(String imageUrl) {
    return Column(
      children: [
        Container(
          width: 85,
          height: 85,
          margin: EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
