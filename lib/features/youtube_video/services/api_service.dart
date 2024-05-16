import 'package:get/get.dart';
import 'package:youtube_api/youtube_api.dart';

class YTAPIService extends GetxController {

  YoutubeAPI youtube = YoutubeAPI("");
  RxList videoResult = [].obs;
  Future<void> callAPI(String search) async {
    videoResult.value = await youtube.search(
      search,
      order: 'relevance',
      videoDuration: 'any',
    );
    videoResult.value = await youtube.nextPage();
  }
}
