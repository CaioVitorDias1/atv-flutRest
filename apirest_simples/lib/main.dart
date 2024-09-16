// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}
   
class MyAppState extends State<MainApp>{
  List<dynamic> dataList = [];

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

    if(response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      setState(() {
        dataList = jsonResponse;
      });
    } else {
      print("request failed with error: ${response.statusCode}");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("API RESPONSE DEMO"),
        ),
        body: ListView.builder(
          itemCount: dataList.length,
          itemBuilder: (BuildContext context, int index) {
            Color colors = (index % 2 == 0)? Colors.blue : Colors.yellow;
            final item = dataList[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: colors,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text("Name: ${item["name"]}"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ID: ${item['id']}'),
                    Text('Name: ${item['name']}'),
                    Text('Username: ${item['username']}'),
                    Text('Email: ${item['email']}'),
                    Text('Address: '),
                      Text('Street: ${item['address']['street']}'),
                      Text('Suite: ${item['address']['suite']}'),
                      Text('City: ${item['address']['city']}'),
                      Text('Zipcode: ${item['address']['zipcode']}'),
                      Text('Geo: '),
                        Text('Lat: ${item['address']['geo']['lat']}'),
                        Text('Lng: ${item['address']['geo']['lng']}'),
                  ],),
              ),
            );
          }
      ),
    ),
    );
  }
}


