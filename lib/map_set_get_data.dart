// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageMapScreen extends StatefulWidget {
  const LocalStorageMapScreen({Key? key}) : super(key: key);

  @override
  State<LocalStorageMapScreen> createState() => _LocalStorageMapScreenState();
}

class _LocalStorageMapScreenState extends State<LocalStorageMapScreen> {
  SharedPreferences? prefs;

  setInstant() async {
    prefs = await SharedPreferences.getInstance();
  }

  Map<String, dynamic> selectedTimes = {
    "car": "BMW",
    "Name": "HARDI",
    "Time ": 3,
    "id_no ": 12378,
    "mobile_no ": 1324365873,
    "age ": 24,
    // "\nLong Rest Time Settings": 15,
    // "\nTerm of Resting Time Setrtings": 5
  };

  @override
  void initState() {
    // TODO: implement initState
    setInstant();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? encodedMap = json.encode(selectedTimes);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Local Storag",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.greenAccent),
                  fixedSize: MaterialStatePropertyAll(
                    Size(120, 80),
                  ),
                ),
                onPressed: () {
                  prefs!.setString('timeData', encodedMap!);
                },
                child: const Text(
                  "Set Data",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.greenAccent),
                  fixedSize: MaterialStatePropertyAll(
                    Size(120, 80),
                  ),
                ),
                onPressed: () {
                  if (prefs!.containsKey("last_name")) {
                    prefs!.setString('timeData', encodedMap!);
                    setState(() {});
                  } else {
                    debugPrint("No Data");
                  }
                },
                child: const Text(
                  "Get Data",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                encodedMap!.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
