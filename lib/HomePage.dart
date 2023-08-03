import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:video_9/Model/UserModel.dart';
import 'package:http/http.dart'as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UserModel> userList=[];
  Future<List<UserModel>> getUser()async
  {
    final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200)
    {

      for(Map i in data)
        {
          userList.add(UserModel.fromJson(i));
        }
      return userList;
    }
    else
    {

      return userList;



    }



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: FutureBuilder(

              future: getUser(),
              builder: (context,AsyncSnapshot<List<UserModel>> snapshot)
          {
           if(!snapshot.hasData)
           {

             return Text("Loading");
           }
           else
           {
             return ListView.builder(
                 itemCount: userList.length,
                 itemBuilder: (context,index)
                 {
                   return Card(
                     child: Padding(
                       padding: EdgeInsets.all(8),
                       child: Column(
                         children: [
                        Reusable(title:'Name',value:snapshot.data![index].name.toString(),),
                           SizedBox(height: 10,),
                           Reusable(title:'Number',value:snapshot.data![index].phone.toString(),),
                           SizedBox(height: 10,),
                           Reusable(title:'email',value:snapshot.data![index].email.toString(),),
                           SizedBox(height: 10,),
                           Reusable(title:'Address',value:snapshot.data![index].address!.street.toString(),),
                           SizedBox(height: 10,),
                           Reusable(title:'Geo',value:snapshot.data![index].address!.geo!.lat.toString(),)
                         ],
                       ),
                     ),
                   );


                 });
           }



          })


          )

        ],
      ),
    );
  }
}
class Reusable extends StatelessWidget {
  String title,value;
  Reusable({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),

          Text(value)

        ],

      ),
    );
  }
}

