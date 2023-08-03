import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rest_get_api_custom/Model/ProductModel.dart';
import 'package:http/http.dart' as http;
class VeryComplexJson extends StatefulWidget {
  const VeryComplexJson({Key? key}) : super(key: key);

  @override
  State<VeryComplexJson> createState() => _VeryComplexJsonState();
}

class _VeryComplexJsonState extends State<VeryComplexJson> {
 Future<ProductModel> getcustomerapi() async {
   var response= await http.get(Uri.parse('https://webhook.site/05e8160e-bf73-4603-ae6b-8df37e93a615'));
   var data= jsonDecode(response.body.toString());
   if(response.statusCode==200){
     return ProductModel.fromJson(data);
   } else {
     return ProductModel.fromJson(data);
   }
   
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("VeryComplexJson"),
      centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: getcustomerapi(),
                  builder: (context,snapshot){
                    if(snapshot.hasData){
                      return ListView.builder(
                          itemCount: snapshot.data!.data!.length,
                          itemBuilder: (context,index){
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Text(snapshot.data!.data![index].categories!.name.toString()),
                                  subtitle: Text(snapshot.data!.data![index].shop!.shopemail.toString()),
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(snapshot.data!.data![index].shop!.image.toString()),
                                  ),
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.height *.3,
                                  width: MediaQuery.of(context).size.width ,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data!.data![index].images!.length,
                                      itemBuilder: (context,i){
                                 return Padding(
                                   padding: const EdgeInsets.only(right: 10,bottom: 10),
                                   child: Container(
                                     height: MediaQuery.of(context).size.height*.25,
                                     width: MediaQuery.of(context).size.width *.38,
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(10),
                                       image: DecorationImage(
                                         fit: BoxFit.cover,
                                         image: NetworkImage(snapshot.data!.data![index].images![i].url.toString()),
                                       )
                                     ),
                                   ),
                                 );
                                  }),
                                ),

                              ],
                            );
                          });
                    } else{
                      return const Text("Loading");
                    }

              }),
            )
          ],
        ),
      ),
    );
  }
}
