import 'package:flutter/material.dart';

class BannerSliderWidget extends StatelessWidget {
  final List<String> imgList;
  final PageController pageController;

  BannerSliderWidget({
    required this.imgList,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135.0,
      child: PageView.builder(
        controller: pageController,
        itemCount: imgList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: NetworkImage(imgList[index]),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        onPageChanged: (int index) {
          // Optional: Add any state changes when page changes
        },
      ),
    );
  }
}
