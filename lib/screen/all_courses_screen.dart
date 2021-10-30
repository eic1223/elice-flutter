import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AllCoursesScreen extends StatefulWidget {
  int courseType; // 0: recommended, 1: free

  AllCoursesScreen(this.courseType, {Key? key}) : super(key: key);

  @override
  _AllCoursesScreenState createState() => _AllCoursesScreenState();
}

class _AllCoursesScreenState extends State<AllCoursesScreen> {
  late Size dpSize;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dpSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[800],
        title: Text(widget.courseType == 0 ? "추천 과목" : "무료 과목"),
      ),
      body: Container(
        color: Colors.grey,
        child: SingleChildScrollView(
            child: Column(
          children: [
            courseAllWidget(dpSize, "iOS 15 & SwiftUI로 AR 앱 만들기", "원동인 강사"),
            courseAllWidget(dpSize, "iOS 15 & SwiftUI로 AR 앱 만들기", "원동인 강사"),
            courseAllWidget(dpSize, "iOS 15 & SwiftUI로 AR 앱 만들기", "원동인 강사"),
            courseAllWidget(dpSize, "iOS 15 & SwiftUI로 AR 앱 만들기", "원동인 강사"),
            courseAllWidget(dpSize, "iOS 15 & SwiftUI로 AR 앱 만들기", "원동인 강사"),
            courseAllWidget(dpSize, "iOS 15 & SwiftUI로 AR 앱 만들기", "원동인 강사"),
            courseAllWidget(dpSize, "iOS 15 & SwiftUI로 AR 앱 만들기", "원동인 강사"),
            courseAllWidget(dpSize, "iOS 15 & SwiftUI로 AR 앱 만들기", "원동인 강사"),
            courseAllWidget(dpSize, "iOS 15 & SwiftUI로 AR 앱 만들기", "원동인 강사"),
          ],
        )),
      ),
    );
  }

  Widget courseAllWidget(Size dpSize, String title, String instructor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        width: dpSize.width * 1.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 120,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Image.network(
                    // todo 이미지 url 바꿔줘야 함
                    "https://cdn-api.elice.io/api/file/ac460d27036b471e8e18e010e4138a15/week-al.png?se=2021-11-11T00%3A15%3A00Z&sp=rt&sv=2020-06-12&sr=b&sig=Wszfuh8vINuvvWSzS2m3%2BtKDGbIfLOjTpoVaIam3RfI%3D"),
              ),
            ),
            Column(
              children: [
                Text(title),
                Text(instructor),
                Padding(
                  padding: const EdgeInsets.only(left: 6, bottom: 4),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blue,
                    ),
                    padding: const EdgeInsets.all(5),
                    child: const Text(
                      "오프라인",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
