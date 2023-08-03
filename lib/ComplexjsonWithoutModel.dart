import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ComplexJsonWithoutModel extends StatefulWidget {
  const ComplexJsonWithoutModel({Key? key}) : super(key: key);

  @override
  State<ComplexJsonWithoutModel> createState() => _ComplexJsonWithoutModelState();
}
// Global variable
var data;
class _ComplexJsonWithoutModelState extends State<ComplexJsonWithoutModel> {
  Future<void> getuserapi() async{
    var response= await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
      if(response.statusCode==200){
        data=jsonDecode(response.body.toString());
      } else
        {

        }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(
        "ComplexJsonWithoutModel"
      ),
      centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        toolbarHeight: 30,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getuserapi(),
              builder: ( context,  snapshot)
            { if(snapshot.connectionState== ConnectionState.waiting){
              return Text("Loading");
            }
            else {
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          Reusable(title: ("Name"), value: (data[index]['name']
                              .toString())),
                          Reusable(title: ("Geo"), value: (data[index]['address']['geo'].toString())),

                        ],
                      ),
                    );
                  });
            }
            },

            ),
          ),
        ],
      ),
    );
  }
}
class Reusable extends StatelessWidget {
  String title,value;
   Reusable({ required this.title, required this.value, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(value),
      ],
    );
  }
}
