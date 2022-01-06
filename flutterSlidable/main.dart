/*
                                                   https://github.com/baranalhas
 */

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'contacts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {

    Future<List<Contacts>> getKisilerList() async{
      var KisiList = <Contacts>[];
      var kisi1 = Contacts(name: "Baran", surname: "Alhas", imgUrl: "https://upload.wikimedia.org/wikipedia/commons/d/d5/Contacts_%28iOS%29.png");
      var kisi2 = Contacts(name: "Jake", surname: "Murphy", imgUrl: "https://upload.wikimedia.org/wikipedia/commons/d/d5/Contacts_%28iOS%29.png");
      var kisi3 = Contacts(name: "Michael", surname: "Bailey", imgUrl: "https://upload.wikimedia.org/wikipedia/commons/d/d5/Contacts_%28iOS%29.png");
      var kisi4 = Contacts(name: "James", surname: "Goodman", imgUrl: "https://upload.wikimedia.org/wikipedia/commons/d/d5/Contacts_%28iOS%29.png");
      var kisi5 = Contacts(name: "Steven", surname: "Clements", imgUrl: "https://upload.wikimedia.org/wikipedia/commons/d/d5/Contacts_%28iOS%29.png");
      var kisi6 = Contacts(name: "Mindy", surname: "Stone", imgUrl: "https://upload.wikimedia.org/wikipedia/commons/d/d5/Contacts_%28iOS%29.png");
      KisiList.add(kisi1);
      KisiList.add(kisi2);
      KisiList.add(kisi3);
      KisiList.add(kisi4);
      KisiList.add(kisi5);
      KisiList.add(kisi6);
      return KisiList;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: const [
            Text("Test"),
          ],
        ),
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: FutureBuilder<List<Contacts>>(
          future: getKisilerList(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              var kisiListesi = snapshot.data;
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: kisiListesi!.length,
                itemBuilder: (context,index){
                  var kisi = kisiListesi[index];
                  return Card(
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Slidable(
                      startActionPane: ActionPane(
                        extentRatio: 0.35,
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Call Action for ${kisi.name}"),
                                  )
                              );
                            },
                            icon: Icons.phone,
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                              label: 'Call',
                          ),
                        ],
                      ),
                      endActionPane: ActionPane(
                        extentRatio: 0.8,
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Delete ${kisi.name} ?"),
                                  action: SnackBarAction(
                                    label: "Yes",
                                    onPressed: (){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text("Deleted"),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              );
                              },
                            icon: Icons.delete,
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            label: 'Del',
                          ),
                          SlidableAction(
                            onPressed: (context){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Message Action for ${kisi.name}"),
                                  )
                              );
                            },
                            foregroundColor: Colors.white,
                            icon: Icons.message_rounded,
                            backgroundColor: Colors.blueAccent,
                            label: 'Text',
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ClipOval(child: Image.network(kisi.imgUrl)),
                        ),
                        title: Text('${kisi.name} ${kisi.surname}',),
                      ),
                    ),
                  );
                },
              );
            }else{
              return Center();
            }
          },
        ),
      ),
    );
  }
}