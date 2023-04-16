import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:local_storag/modal/to_do_modal.dart';
import 'package:local_storag/res/common/app_button.dart';
import 'package:local_storag/res/constant/app_string.dart';
import 'package:local_storag/res/constant/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'to_do_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferences? prefs;
  setInstant() async {
    prefs = await SharedPreferences.getInstance();
    getData();
  }

  setData() {
    List<String> data = [];
    for (int i = 0; i < toDoList.length; i++) {
      data.add(jsonEncode(toDoList[i].toJson()));
    }
    debugPrint(data.toString());
    prefs!.setStringList("call data", data);
  }

  getData() {
    List<String> data = [];
    data = prefs!.getStringList("call data")!;
    for (int i = 0; i < data.length; i++) {
      toDoList.add(ToDoModel.fromJson(jsonDecode(data[i])));
    }
    debugPrint(toDoList.toString());
    setState(() {});
  }

  List<ToDoModel> toDoList = [];
  @override
  void initState() {
    setInstant();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Image.asset("assets/images/home_screen.png"),
            ),
            toDoList.isEmpty
                ? const Padding(
                    padding: EdgeInsets.only(bottom: 340),
                    child: Text(
                      "No Data Found",
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.textColor,
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemCount: toDoList.length,
                      padding: const EdgeInsets.all(20),
                      itemBuilder: (context, index) => Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          border: Border.all(color: const Color(0xFFFF97B1)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Title: ${toDoList[index].title}",
                              style: const TextStyle(
                                  color: AppColors.Colortext,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "description:${toDoList[index].des!}",
                              style: const TextStyle(
                                  color: AppColors.Colortext,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "date:${toDoList[index].date!}",
                              style: const TextStyle(
                                  color: AppColors.textHintColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Time:${toDoList[index].time!}",
                              style: const TextStyle(
                                  color: AppColors.textHintColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    dynamic data = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddToDoScreen(
                                          toDoList: toDoList,
                                          index: index,
                                        ),
                                      ),
                                    );
                                    if (data != null) {
                                      debugPrint("Data--->$data");
                                      toDoList = data;
                                      setData();
                                      setState(() {});
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Color(0xFFFF97B1),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    toDoList.removeAt(index);
                                    setData();
                                    setState(() {});
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Color(0xFFFF97B1),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () async {
          dynamic data = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddToDoScreen(
                toDoList: toDoList,
              ),
            ),
          );

          if (data != null) {
            debugPrint("Data --> $data");
            toDoList = data;
            setState(() {});
          }
        },
        child: const Padding(
          padding: EdgeInsets.only(right: 50),
          child: AppButton(
            title: AppStings.addToDo,
            width: 250,
          ),
        ),
      ),
    );
  }
}
