
import 'package:get/get.dart';
import 'package:youtube_api/youtube_api.dart';

class YTAPIService extends GetxController {
  static String key = 'AIzaSyDk7T-W0tykaoFBON5_V0tmppISrhxLnbU';

  static String EnvKey = String.fromEnvironment('KEY');

  YoutubeAPI youtube = YoutubeAPI(key );
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
