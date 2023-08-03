import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class GetApiWithoutModel extends StatefulWidget {
  const GetApiWithoutModel({Key? key}) : super(key: key);

  @override
  State<GetApiWithoutModel> createState() => _GetApiWithoutModelState();
}

class _GetApiWithoutModelState extends State<GetApiWithoutModel> {
  List<Photos> photoslist=[];
  // future ka andar Future<List<> ya return type hoti ha mtlb list return ho gi
Future<List<Photos>>  getphotos() async{
var response= await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
var data=jsonDecode(response.body.toString());
if(response.statusCode==200){
  photoslist.clear();
  for(Map i in data){
    Photos photos=Photos(title: i['title'], id: i['id'], url: i['url']);
    photoslist.add(photos);
  }
  return photoslist;
}
else{
  return photoslist;
}
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GetApiCustom"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getphotos (),
                builder: (context,AsyncSnapshot<List<Photos>> snapshot){
                  if(!snapshot.hasData){
                    return Text("Loading");
                  }
                  else {
                    return ListView.builder(
                        itemCount: photoslist.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(snapshot.data![index].url.toString()),

                            ),
                            subtitle: Text(snapshot.data![index].title.toString(),),
                            title: Text ("Notes ID" +snapshot.data![index].id.toString()),

                          );
                        });
                  }

            }),
          ),
        ],
      ),
    );

  }
}
class Photos{
  String title, url;
  int id;
  Photos({
    required this.title,
    required this.id,
    required this.url,

});

}
