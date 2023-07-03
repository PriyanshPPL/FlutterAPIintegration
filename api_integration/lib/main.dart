import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

late String stringResponse;
late Map mapResponse;
late Map dataResponse;
late List listResponse;

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Future apicall() async {
    http.Response response;
    response = await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
    if (response.statusCode == 200) {
      setState(() {
        // stringResponse = response.body;
        mapResponse = json.decode(response.body);
        listResponse = mapResponse['data'];
      });
    }
  }

  @override
  void initState() {
    apicall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Integration'),
      ),
      // body: Center(
      //   child: Container(
      //     height: 200,
      //     width: 300,
      //     decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(20), color: Colors.blue),
      //     child: Center(
      //       child: listResponse == null
      //           ? Container()
      //           : Text(listResponse[5]['first_name'].toString()),
      //     ),
      //   ),
      // ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(listResponse[index]['avatar']),
              ),
              Text(listResponse[index]['id'].toString()),
              const Padding(padding: EdgeInsets.all(8.0)),
              Text(listResponse[index]['email'].toString()),
              const Padding(padding: EdgeInsets.all(8.0)),
              Text(listResponse[index]['first_name'].toString()),
              const Padding(padding: EdgeInsets.all(8.0)),
              Text(listResponse[index]['last_name'].toString()),
            ]),
          );
        },
        itemCount: listResponse == null ? 0 : listResponse.length,
      ),
    );
  }
}
