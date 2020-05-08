import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class HomePage extends StatefulWidget {
  final String title;
  HomePage({Key key, @required this.title}) :super(key:key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url="https://api.github.com/users";
  List data;
  var isLoading=false;

  @override
  void initState() {
    super.initState();
    this.getjsondata();
  }

  Future<String> getjsondata ()async{
    var response = await http.get( Uri.encodeFull(url));
    setState(() {
      var convertDatatojson=json.decode(response.body);
      this.data=convertDatatojson;
      print(data);
    });
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context,int index)
        {
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                  radius:20,
                  backgroundImage:NetworkImage(data[index]['avatar_url']),
                  backgroundColor: Colors.transparent,
                  ),
                  title: Text(data[index]['login'],style: TextStyle(fontSize:22,fontWeight:FontWeight.bold,color:Colors.redAccent )),
                  subtitle:Text(data[index]['url'],style: TextStyle(fontSize:15),) ,
                )
              ],
            ),
          );
        },
        itemCount: data.length,),
    );
}
}