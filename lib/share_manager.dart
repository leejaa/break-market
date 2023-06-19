import 'package:flutter/cupertino.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class ShareManager {
  late BuildContext context;

  setContext(BuildContext contextParam) {
    context = contextParam;
  }

  share(String url) async {
    print("url: $url");

    bool isKakaoTalkSharingAvailable =
        await ShareClient.instance.isKakaoTalkSharingAvailable();
    if (isKakaoTalkSharingAvailable) {
      try {
        final FeedTemplate defaultFeed = FeedTemplate(
          content: Content(
            title: '카드정보',
            description: '#포켓몬카드 #스포츠카드',
            imageUrl: Uri.parse(
                'https://breakncompany.s3.ap-northeast-2.amazonaws.com/market/card_wm/82badd499c7f4c7e8d7989686865509b.webp'),
            link: Link(
                webUrl: Uri.parse('https://market.break.co.kr'),
                mobileWebUrl: Uri.parse('https://market.break.co.kr')),
          ),
          buttons: [
            Button(
              title: '웹으로 보기',
              link: Link(
                webUrl: Uri.parse('https://market.break.co.kr/'),
                mobileWebUrl: Uri.parse('https://market.break.co.kr/'),
              ),
            ),
          ],
        );

        Uri uri =
            await ShareClient.instance.shareDefault(template: defaultFeed);
        // await ShareClient.instance
        //     .shareScrap(url: 'https://market.break.co.kr');
        await ShareClient.instance.launchKakaoTalk(uri);
        print('카카오톡 공유 완료');
      } catch (error) {
        print('카카오톡 공유 실패 $error');
      }
    } else {
      print('카카오톡 미설치');
      // showCupertinoDialog(context: context, builder: (context: BuildContext) => const CupertinoAlertDialog(title: Text('카카오톡 미설치'), content: Text('카카오톡이 설치되지 않았습니다.')))
      // ignore: use_build_context_synchronously
      showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
                title: const Text('카카오톡이 설치되지 않았습니다.'),
                actions: [
                  CupertinoDialogAction(
                      child: Text('Close'),
                      onPressed: () => Navigator.pop(context)),
                ],
              ));
    }
  }
}
