import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipes/Model/Model_Recipes.dart';

void main() {
  runApp(MaterialApp(
    home: Api_Recipes_Get(),
    debugShowCheckedModeBanner: false,
  ));
}

class Api_Recipes_Get extends StatefulWidget {
  const Api_Recipes_Get({Key? key}) : super(key: key);

  @override
  State<Api_Recipes_Get> createState() => _Api_Recipes_GetState();
}

class _Api_Recipes_GetState extends State<Api_Recipes_Get> {
  List l = [];

  get_Api_Call() async {
    var url = Uri.parse('https://dummyjson.com/recipes');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    //l=jsonDecode(response.body);

    Map mp = jsonDecode(response.body);
    l = mp['recipes'];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_Api_Call();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade300,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Recipes",
          style: TextStyle(
              fontSize: 25,
              color: Colors.lightGreen,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.separated(
        itemCount: l.length,
        itemBuilder: (context, index) {
          Recipes m = Recipes.fromJson(l[index]);
          return Card(
            child: ListTile(
                subtitle: Text(
                  "Rating : ${m.rating}",
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
                title: Text(
                  "Name : ${m.name}",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
                leading: Text(
                  "Id : ${m.id}",
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
                trailing:  Text(
          "UserId : ${m.userId}",
          style: TextStyle(
          fontSize: 13,
          color: Colors.black,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold),
            ),)
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Colors.black,
            thickness: 1,
            height: 1,
          );
        },
      ),
    );
  }
}
