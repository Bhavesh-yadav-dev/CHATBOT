import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController userinput = TextEditingController();
  String res = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "CHAT APP ",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: sqrt1_2,
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: userinput,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  label: Text("enter here"),
                  hint: Text("hey, what you think just ask me"),
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                if (userinput.text.isNotEmpty) {
                  getresponse();
                }
              },
              child: Text("send your throught"),
            ),

            Text(res, style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }

  void getresponse() async {
    String apikey = "";
    String url =
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-3-flash-preview:generateContent?key=$apikey";

    Map<String, dynamic> parambody = {
      "contents": [
        {
          "parts": [
            {"text": userinput.text},
          ],
        },
      ],
    };
    var response = await http.post(Uri.parse(url), body: jsonEncode(parambody));

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
