import 'dart:convert';

import 'package:elice_flutter/screen/all_courses_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'package:elice_flutter/constants.dart';
import 'package:elice_flutter/widget/course_home.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // api call
  Future<http.Response> apiGetRecommended() {
    return http.get(Uri.parse(Constants.api_get_recommended));
  }

  Future<http.Response> apiGetFree() {
    return http.get(Uri.parse(Constants.api_get_free));
  }

  List<CourseMain> courseWidgetList = [];
  List<CourseMain> courseFreeWidgetList = [];

  // todo [백엔드 수정 필요] 21.10.30 API 값이 없는 경우 어떤 건 null로 오고 어떤 건 []로 오게 되어있음.
  void initCourseWidgetList() async {
    apiGetRecommended().then((value) {
      int courseCount = jsonDecode(value.body)["courses"].length;
      for (int i = 0; i < courseCount; i++) {
        setState(() {
          courseWidgetList.add(
            CourseMain(
                jsonDecode(value.body)["courses"][i]["title"],
                (jsonDecode(value.body)["courses"][i]["instructors"]
                            .toString() ==
                        "[]")
                    ? "선생님 미등록"
                    : jsonDecode(value.body)["courses"][i]["instructors"][0]
                        ["fullname"],
                // "선생님 미등록",
                "오프라인",
                jsonDecode(value.body)["courses"][i]["logo_file_url"]),
          );
        });
      }
    });

    apiGetFree().then((value) {
      int courseCount = jsonDecode(value.body)["courses"].length;
      for (int i = 0; i < courseCount; i++) {
        setState(() {
          courseFreeWidgetList.add(
            CourseMain(
                jsonDecode(value.body)["courses"][i]["title"],
                (jsonDecode(value.body)["courses"][i]["instructors"]
                            .toString() ==
                        "[]")
                    ? "선생님 미등록"
                    : jsonDecode(value.body)["courses"][i]["instructors"][0]
                        ["fullname"],
                // "선생님 미등록",
                "오프라인",
                (jsonDecode(value.body)["courses"][i]["logo_file_url"]
                                .toString() ==
                            "[]" ||
                        jsonDecode(value.body)["courses"][i]["logo_file_url"] ==
                            null)
                    ? "https://cdn-api.elice.io/api/file/ac460d27036b471e8e18e010e4138a15/week-al.png?se=2021-11-11T00%3A15%3A00Z&sp=rt&sv=2020-06-12&sr=b&sig=Wszfuh8vINuvvWSzS2m3%2BtKDGbIfLOjTpoVaIam3RfI%3D" // todo 아이콘 없는 경우 어떻게 할건지 체크
                    : jsonDecode(value.body)["courses"][i]["logo_file_url"]),
          );
        });
      }
    });
  }

  @override
  void initState() {
    initCourseWidgetList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            sectionBar("추천 과목", 0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: courseWidgetList.toList(),
              ),
            ),
            Divider(),
            sectionBar("무료 과목", 1),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: courseFreeWidgetList.toList(),
              ),
            ),
            // test button
            RawMaterialButton(
              onPressed: () {
                // test
                apiGetRecommended().then((value) {
                  print(value.body);
                  print('////////');
                  print(jsonDecode(value.body)["courses"]);
                  print(jsonDecode(value.body)["courses"].length);
                  print('------');
                  print(jsonDecode(value.body)["courses"][0]["title"]);
                  print(jsonDecode(value.body)["courses"][0]["logo_file_url"]);
                  print(jsonDecode(value.body)["courses"][0]["instructors"]);
                });
              },
              child: Text("test button"),
            )
          ],
        ),
      ),
    );
  }

  Widget sectionBar(String sectionTitle, int courseType) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 8,
          ),
          child: Text(
            sectionTitle,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                // navigate with course type
                print("clicked!");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AllCoursesScreen(courseType)),
                );
              },
              child: const Text(
                "전체 보기",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey),
              ),
            )),
      ],
    );
  }
}
