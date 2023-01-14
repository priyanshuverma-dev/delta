import 'package:answer_it/features/youtube_video/widgets/getVideoCard.dart';
import 'package:flutter/material.dart';

Widget youtubeCard(video, itemCount) {
  return Column(
    children: [
      SizedBox(height: 25),
      SizedBox(
        height: 320,
        child: PageView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => listItem(
            video[index],
          ),
          itemCount: itemCount,
          physics: const BouncingScrollPhysics(),
        ),
      ),
    ],
  );
}
