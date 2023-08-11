import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class home_screen extends StatefulWidget {
  const home_screen({Key? key}) : super(key: key);

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  final TextEditingController _searchController = TextEditingController();
  List<ChatMessage> _chatMessages = []; // Initialize an empty list
  // bool _isLoading = false;

  Future<String> getResponseFromAPI(String search) async {
    try {
      String apiKey = "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";
      var url = Uri.https("api.openai.com", "/v1/completions");

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      };

      Map<String, dynamic> body = {
        "model": 'text-davinci-003',
        "prompt": search,
        "max_tokens": 2000,
      };

      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);
        return responseJson["choices"][0]["text"];
      } else {
        throw Exception("Failed to get response from API");
      }
    } catch (e) {
      print("Caught exception: $e");
      return "";
    }
  }

  void _getResponse(String message) async {
    // setState(() {
    //   _isLoading = true;
    // });

    try {
      String response = await getResponseFromAPI(message);

      setState(() {
        _chatMessages
            .add(ChatMessage(text: message, isUser: true)); // User's message
        _chatMessages
            .add(ChatMessage(text: response, isUser: false)); // Bot's response
      });
    } catch (e) {
      _chatMessages.add(ChatMessage(
          text: e.toString(), isUser: false)); // Error message from bot
    }

    // setState(() {
    //   _isLoading = false;
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title:
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Image.asset(
            //       'images/chatbot app icon.png',
            //       height: screenHeight * 0.09,
            //     ),
            //     SizedBox(
            //       width: screenWidth * 0.02,
            //     ),
            Text("ChatBot App"),
        //   ],
        // ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _chatMessages.length,
              itemBuilder: (context, index) {
                ChatMessage message = _chatMessages[index];
                return Align(
                  alignment:
                      message.isUser ? Alignment.topRight : Alignment.topLeft,
                  child: Container(
                    padding: EdgeInsets.only(left: 9, right: 9),
                    child: Column(
                      crossAxisAlignment: (message.isUser
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start),
                      children: [
                        Text(
                          message.isUser ? 'user' : 'bot',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          message.text,
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Enter your message...',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (_searchController.text.isNotEmpty) {
                      _getResponse(_searchController.text);
                      _searchController.clear(); // Clear the text field
                    }
                  },
                  icon: Icon(
                    Icons.send,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}
