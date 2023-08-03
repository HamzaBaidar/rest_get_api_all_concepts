import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Model/usermodel.dart';
class ComplexJsonWithPlugin extends StatefulWidget {
  const ComplexJsonWithPlugin({Key? key}) : super(key: key);

  @override
  State<ComplexJsonWithPlugin> createState() => _ComplexJsonWithPluginState();
}

class _ComplexJsonWithPluginState extends State<ComplexJsonWithPlugin> {
  // ya ab complex json ha with making model through Jsontodart plugin
 List <Usermodel> userlist =[];
Future<List<Usermodel>> getUserapi()async {
  var response= await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
  var data= jsonDecode(response.body.toString());
  if(response.statusCode==200){
    for( Map i in data){
      userlist.add(Usermodel.fromJson(i));
      print(i['name']);
    }
    return userlist;
 }
  else{
    return userlist;
 }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ComplexJsonPlugin"),
      centerTitle: true,
      backgroundColor: Colors.blue,),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getUserapi(),
                builder: (context,AsyncSnapshot<List<Usermodel>> snapshot){
                  if(!snapshot.hasData){
                    return CircularProgressIndicator();
                  }
                  else{
                    return   ListView.builder(
                        itemCount: userlist.length,
                        itemBuilder:(context,index){
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                Reusable(value: (snapshot.data![index].name.toString()), title: ('Name')),
                                  Reusable(value: (snapshot.data![index].email.toString()), title: ("Email Address")),
                                  Reusable(value: (snapshot.data![index].address!.city.toString()), title: ('Address')),
                                  Reusable(value: snapshot.data![index].address!.geo!.lat.toString(), title: ("Latitude"))

                                ],
                              ),
                            ),
                          );

                        });
                  }


                }

                ),
          )

        ],
      ),
    );
  }
}
class Reusable extends StatelessWidget {
  String title, value;
   Reusable({ required this.value, required this.title,  Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
        Text(value)
      ],
    );
  }
}

