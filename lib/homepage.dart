import 'dart:convert';
import 'dart:math';
import 'package:gpt_markdown/gpt_markdown.dart';
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "CHAT APP ",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          
        ),

        body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 20,
                ),
              child: GptMarkdown(res, style: const TextStyle(fontSize: 20)),
            ),
          ),

           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: TextField(
              controller: userinput,
              decoration: InputDecoration(
                hintText: "Ask me anything...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    if (userinput.text.isNotEmpty) {
                      getresponse();
                      userinput.clear(); 
                    }
                  },
                  icon: const Icon(Icons.send),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

  void getresponse() async {
    String apikey = "AIzaSyB2tORN8Kmo4sWngYSVsj-8f280QuwtZkY";
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
      var decodedData = jsonDecode(response.body);
      String aiMessage =
          decodedData['candidates'][0]['content']['parts'][0]['text'];

      setState(() {
        res = aiMessage;
      });
    } else {
      print("Error Code: ${response.statusCode}");
      print("Error Body: ${response.body}");
    }
  }
}
