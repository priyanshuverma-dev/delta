import 'package:delta/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_api/youtube_api.dart';

Widget listItem(YouTubeVideo video) {
  return GestureDetector(
    onDoubleTap: () async {
      Uri url = Uri.parse(video.url);
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
      } else {}
    },
    child: Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white12,
            Colors.white10,
          ],
        ),
        color: Colours.primarySwatch.withOpacity(0.5),
        // color: Color.fromRGBO(48, 49, 52, 0.2),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
        boxShadow: const [
          BoxShadow(
            // color: Colors.grey.withOpacity(0.2),
            color: Color.fromRGBO(118, 118, 118, 0.2),
            offset: Offset(0, 2),
            blurRadius: 8.0,
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              height: 200,
              video.thumbnail.medium.url ?? '',
              fit: BoxFit.fill,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!.toDouble()
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(Icons.error),
                );
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5.0),
              Text(
                video.title,
                softWrap: true,
                style: TextStyle(fontSize: 12.0, color: Colours.textColor),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: Text(
                  video.channelTitle,
                  softWrap: true,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colours.textColor.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
