
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatelessWidget {
  WebViewController? controller; // 컨트롤러 변수 생성

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.orange,

        title: Text('Code Factory'),

        centerTitle: true,

        // AppBar의 actions 매개변수
        actions: [
          IconButton(
              // 눌렀을 때 콜백 함수 설정
              onPressed: () {
            if (controller != null) {

            //  웹 뷰에서 보여줄 사이트 실행하기
              controller!.loadUrl('https://blog.codefactory.ai');
            //   controller!.goBack();

            }
          },
            // 홈 버튼 아이콘 설정
            icon: Icon(
              Icons.home,
            ),
          ),

        ],

      ),
      body: WebView(

        // 웹뷰 생성 함수
        onWebViewCreated: (WebViewController controller) {
          this.controller = controller;
        },
        initialUrl: 'https://blog.codefactory.ai',
        javascriptMode: JavascriptMode.unrestricted,
      ),
      );
  }

}
