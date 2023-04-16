import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetGetLocalstorag extends StatefulWidget {
  const SetGetLocalstorag({Key? key}) : super(key: key);

  @override
  State<SetGetLocalstorag> createState() => _SetGetLocalstoragState();
}

class _SetGetLocalstoragState extends State<SetGetLocalstorag> {
  SharedPreferences? prefs;
  String? stringData = "";
  int? intData = 0;
  bool? BoolData = false;
  double? DoubleData = 11.2;
  List? ListData = ['hardi', 'hitali'];

  setInstant() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    // TODO: implement initState
    setInstant();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Local Storag"),
        backgroundColor: Colors.cyan,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.cyan),
                fixedSize: MaterialStatePropertyAll(
                  Size(120, 80),
                ),
              ),
              onPressed: () {
                prefs!.setString("name", "hardi");
                prefs!.setString("last_name", "kotadiya");
                prefs!.setInt("number", 1712889911);
                prefs!.setBool("hello", true);
                prefs!.setDouble("hardi", 1.3);
                prefs!
                    .setStringList('items', <String>['food', 'names', 'wark']);
              },
              child: const Text("Set Data"),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.cyan),
                fixedSize: MaterialStatePropertyAll(
                  Size(120, 80),
                ),
              ),
              onPressed: () {
                if (prefs!.containsKey("last_name")) {
                  stringData = prefs!.getString("last_name");
                  intData = prefs!.getInt("number");
                  BoolData = prefs!.getBool("hello");
                  DoubleData = prefs!.getDouble("hardi");
                  ListData = prefs!.getStringList("items");
                  setState(() {});
                } else {
                  debugPrint("No Data");
                }
              },
              child: const Text("Get Data"),
            ),
            const SizedBox(height: 15),
            Text(
              stringData!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              intData!.toString(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              BoolData!.toString(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              DoubleData!.toString(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              ListData!.toString(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
