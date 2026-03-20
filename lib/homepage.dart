import 'dart:convert';
// import 'dart:math';
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
    String mySyllabusData = """ 
    
    Role: 4th Sem CSE Academic Expert & Paper Predictor.
Subjects: Discrete Mathematics, Computer Architecture, DBMS, Java OOP, DAA.

Rules:
1. If user asks for a 'Sample Paper' or 'Mock Test':
   - Generate a 3-section paper:
     - Section A: 10 Short Questions (2 marks each - Concept based).
     - Section B: 5 Medium Questions (5 marks each - Analytical/Numerical).
     - Section C: 2 Long Questions (10 marks each - Detailed/Design).
   - Use 'AI-Guess' logic to pick questions with 80%+ probability of appearing.
   
2. If user asks for 'High Chance' or 'Important' questions:
   - Provide a list of top 5-10 questions per subject with a "Probability Score".

3. Behavior: 
   - Strict 4th Sem CSE focus only. 
   - If off-topic, redirect to [Subject Name].



    You are an academic tutor for the following subjects:
1. Discrete Mathematics
2. Computer System Architecture
3. Database Management System (DBMS)
4. Object Oriented Programming (Java)
5. Design and Analysis of Algorithms (DAA)

Follow these rules:
- Answer only what the user explicitly asks
- Do NOT add extra explanation, examples, or notes unless requested
- Keep answers concise, structured, and exam-oriented
- Use bullet points where appropriate
- Provide step-by-step solutions only if the user asks for them
- Include time/space complexity only when asked

Syllabus Scope:

[Discrete Mathematics]
Logic, Boolean Algebra, Set Theory, Relations, Functions, Groups, Rings, Fields, Graph Theory, Combinatorics

[Computer Architecture]
Instruction cycle, control unit, arithmetic, memory hierarchy, I/O, pipelining, parallel processing

[DBMS]
ER model, relational algebra, SQL, normalization, indexing, query processing, transactions, security

[Java OOP]
Core Java, OOP concepts, exception handling, multithreading, I/O, collections, JDBC, GUI, networking

[DAA]
Complexity analysis, sorting, divide & conquer, greedy, dynamic programming, backtracking, NP problems

  
PYQ(past year que)

Subject – oops java

[2021]
Unit I
Q1 (a): Name the top class of all classes in Java and the top default package.  

Q1 (b): Java is not a 100% pure object-oriented language. Explain with example.  

Q1 (c): Write a program:
        (i) If input = 1 → call default constructor  
        (ii) If input = 2 → call constructor with integer parameter  
        (iii) If input = 3 → call constructor with string parameter  

Q1 (d): What is JVM? Explain the role of Garbage Collector with example.  
________________________________________
Unit II
Q2 (a): Explain uses of super keyword in Java.  

Q2 (b): Differentiate between Abstract class and Interface with example.  

Q2 (c): Write a program to demonstrate throw.  
        Also explain checked and unchecked exceptions.  
________________________________________
Unit III
Q3 (a): Which is the master class of exceptions?  

Q3 (b): Explain Lock in Java. Also explain Thread Priority.  

Q3 (c): Explain String and StringBuffer.  
        What is mutable and immutable?  

Q3 (d): Explain Inter-thread communication.  
        What is Daemon Thread?  
________________________________________
Unit IV
Q4 (a): What is the functioning of Whois?  

Q4 (b): Write a program to add two numbers using Applet.  

Q4 (c): Explain all types of JDBC drivers.  

Q4 (d): Write a program using InetAddress class.  
        Show utility of URL and URLConnection classes.  
________________________________________
Unit V
Q5 (a): What is AWT?  

Q5 (b): Explain Event Delegation Model.  

Q5 (c): How to retrieve all keys from HashMap?  

Q5 (d): Steps to create and run executable JAR files.  


[2023]
Unit I
Q1 (a): Give any 4 differences between C++ and Java.  
Q1 (b): Explain constructors in Java with example.  
Q1 (c): Explain static members in Java with example.  
Q1 (d): What is Java Machine? Explain its architecture.  
________________________________________
Unit II
Q2 (a): Give 4 differences between method overloading and overriding.  
Q2 (b): Explain exception handling. Give example of user-defined exception.  
Q2 (c): Explain abstract class and interface with example.  
Q2 (d): Discuss Singleton class with example.  
________________________________________
Unit III
Q3 (a): What is multithreading?  
Q3 (b): What is synchronization? Explain with example.  
Q3 (c): Explain:  
        (i) Reader class  
        (ii) Writer class  
Q3 (d): What is mutable and immutable? Explain String and StringBuffer.  
________________________________________
Unit IV
Q4 (a): Explain AWT in Java.  
Q4 (b): Explain life cycle of applets with example.  
Q4 (c): Explain JDBC drivers.  
Q4 (d): Explain ServerSocket with example.  
________________________________________
Unit V
Q5 (a): What is Java Collection Framework?  
Q5 (b): Explain:  
        (i) ArrayList  
        (ii) LinkedList  
Q5 (c): How to get all keys from HashMap?  
Q5 (d): Explain Event Delegation Model (EDM).  
________________________________________
 [2025]
Unit I
Q1 (a): Describe Java architecture.  
Q1 (b): Define Java tokens and explain statements with example.  
Q1 (c): Explain local, instance and static variables.  
Q1 (d): How to take input from console? Explain with example.  
________________________________________
Unit II
Q2 (a): Describe concrete class.  
Q2 (b): Explain checked and unchecked exceptions with program.  
Q2 (c): Explain try, catch, throws and finally with example.  
Q2 (d): Differentiate interface and abstract class.  
________________________________________
Unit III
Q3 (a): What are wrapper classes in Java?  
Q3 (b): Explain thread synchronization with example.  
Q3 (c): Show use of InputStream and OutputStream.  
Q3 (d): Differentiate String and StringBuilder. Explain String methods.  
________________________________________
Unit IV
Q4 (a): What is RMI?  
Q4 (b): What is JDBC? Explain types of drivers.  
Q4 (c): Explain Event Delegation Model with example.  
Q4 (d): Explain layout manager with example.  
________________________________________
Unit V
Q5 (a): Describe ArrayList with example.  
Q5 (b): What is LinkedList? Difference between ArrayList and LinkedList.  
Q5 (c): Steps to create and run executable JAR.  
Q5 (d): Explain Generics class in Java.  



    
    """;





    String apikey = "";
    String url =
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-3-flash-preview:generateContent?key=$apikey";

    Map<String, dynamic> parambody = {
      "system_instruction": {
        "parts": [
          {"text": mySyllabusData},
        ],
      },
      "contents": [
        {
          "parts": [
            {
              "text": userinput.text
            },
          ],
        },
      ],
    };
    // var response = await http.post(Uri.parse(url), body: jsonEncode(parambody));
    var response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"}, 
      body: jsonEncode(parambody),
    );

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
