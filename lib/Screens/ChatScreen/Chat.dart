import '/Components/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({Key ?key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}




class _ChatScreenState extends State<ChatScreen> {


  String email = "ali@gmail.com";
  String chatDocId = "";
  Query ?query;


  @override
  initState() {

      get();
      super.initState();

  }

  get()async{
    await Firebase.initializeApp();

    query = FirebaseFirestore.instance.collection('Chat');

    query?.where("contact1",isEqualTo: email).get().then((snapshot) {

      chatDocId = snapshot.docs[0].id;

      print(chatDocId);

    }).whenComplete(() {

      FirebaseFirestore.instance.collection("Chat").doc(chatDocId).collection("messages").snapshots().listen((snapshot) {

        print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
        print(snapshot.docs[0].data());
        print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");

      });


    });






  }

  @override
  Widget build(BuildContext context) {




    return Scaffold(
      appBar: appBar("Help Center", context, Colors.white, Colors.black),
      backgroundColor: Colors.white,
    );




  }





}
