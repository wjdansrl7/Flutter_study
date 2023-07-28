
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../component/custom_video_player.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Home Screen'),
    );
  }

}

class _HomeScreenState extends State<HomeScreen>{
  XFile? video; // 동영상 저장할 변수

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      // 동영상이 선택됐을 때와 선택 안 됐을 때 보여줄 위젯
      body: video == null ? renderEmpty() : renderVideo(),
    );
  }

  Widget renderEmpty() { // 동영상 선택 전 보여줄 위젯
    return Container(
      width: MediaQuery.of(context).size.width, // 넓이 최대로 늘려주기
      decoration: getBoxDecoration(),
      child: Column(

      //  위젯들 가운데 정렬
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Logo(
              onTap: onNewVideoPressed, // 로고를 택하면 실행하는 함수
            ), // 로고 이미지
            SizedBox(height: 30),
            _AppName(), // 앱 이름
          ],
      ),
    );
  }

  void onNewVideoPressed() async{ // 이미지 선택하는 기능을 구현한 함수
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if(video != null) {
      setState(() {
        this.video = video;
      });
    }
  }

  BoxDecoration getBoxDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF2A3A7C),
          Color(0xFF000118),
        ],
      ),
    );
  }

  Widget renderVideo() { // 동영상 선택 후 보여줄 위젯
    return Center(
      child: CustomVideoPlayer(
        video: video!,
        onNewVideoPressed: onNewVideoPressed,
      ), // 동영상 재생기 위젯
    );
  }

}



// HomeScreenState 클래스 아래에 추가
class _Logo extends StatelessWidget { // 로고를 보여줄 위젯
  final GestureTapCallback onTap; // 탭했을 때 실행할 함수
  const _Logo({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // 상위 위젯으로부터 탭 콜백받기
      child: Image.asset(
        'asset/img/logo.png', // 로고 이미지
      ),
    );
  }
}

// _Logo 클래스 아래에 추가
class _AppName extends StatelessWidget{ // 앱 제목을 보여줄 위젯
  const _AppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 30,
      fontWeight: FontWeight.w300,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Video',
            style: textStyle,
          ),
          Text(
              'Player',
            style: textStyle.copyWith(
              fontWeight: FontWeight.w700,
            ),
          )
        ],
    );
  }
}
