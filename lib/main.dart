import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:listadecontatos/Api.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, accentColor: Colors.red),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Api> _api;

  Future<List<Api>> _getUser() async {
    try {
      List<Api> listuser = List();
      final response =
          await http.get('https://jsonplaceholder.typicode.com/users');
      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        decodeJson.forEach((item) => listuser.add(Api.fromJson(item)));
        return listuser;
      } else {
        print("error ao conectar na lista" + response.statusCode.toString());
        return null;
      }
    } catch (e, stacktrace) {
      print("error ao conectar na lista" + stacktrace.toString());
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _getUser().then((map) {
      _api = map;
      print(_api.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Lista de Contatos",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              )
            ],
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 50,
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width,
                color: Colors.redAccent,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      color: Colors.white),
                  height: MediaQuery.of(context).size.height - 200,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 15, left: 40, right: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Status"),
                            IconButton(
                              icon: Icon(Icons.more_vert),
                              onPressed: () {},
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          height: 60,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _api.length,
                            itemBuilder: (BuildContext contexte, int index) {
                              return Container(
                                child: CircleAvatar(
                                  radius: 35,
                                  backgroundColor: Colors.redAccent,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 28,
                                    backgroundImage: NetworkImage(
                                        "https://loremflickr.com/320/32$index"),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 150, right: 10, bottom: 10),
                child: Container(
                  height: MediaQuery.of(context).size.height - 240,
                  child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Container(
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(
                                      "https://loremflickr.com/320/32$index"),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 160,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    _api[index].name,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    _api[index].address.street,
                                    style: TextStyle(fontSize: 17),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("17:00"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: index != 0
                                            ? Colors.red
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        index != 0 ? '$index' : ' ',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        );
                      }),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

