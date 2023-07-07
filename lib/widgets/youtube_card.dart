import 'package:delta/features/youtube_video/widgets/get_video_card.dart';
import 'package:flutter/material.dart';

Widget youtubeCard(video, itemCount) {
  return Column(
    children: [
      const SizedBox(height: 25),
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
