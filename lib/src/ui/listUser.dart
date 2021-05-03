import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ws/src/pref/preference.dart';
import 'package:flutter_ws/src/ui/chat.dart';
import 'package:flutter_ws/src/ui/colors.dart';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'function/onNotif.dart';

class ListUserPage extends StatefulWidget {
  ListUserPage({Key key}) : super(key: key);
  final WebSocketChannel channel =
      IOWebSocketChannel.connect('ws://ws-chat123.herokuapp.com/');

  @override
  _ListUserPageState createState() => _ListUserPageState(channel: channel);
}

class _ListUserPageState extends State<ListUserPage> {
  final WebSocketChannel channel;
  var usersList = [];
  String username;

  _ListUserPageState({this.channel}) {
    channel.stream.listen((e) {
      var event = json.decode(e);
      print(event);
      if (event['method'] == 'users') {
        usersList.clear();
        (event['result']['users']).forEach((val) {
          if (val['user'] != username) {
            print(val);
            usersList.add(val);
          }
        });
      } else if (event['method'] == 'message') {
        print(event['result']);
        onNotif(event['result']['from'], event['result']['message']);
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    _onSignSocket();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _onSignSocket();
      print('resume');
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  void _onSignSocket() {
    getKdUser().then((value) {
      channel.sink.add(json.encode({
        'id': 1,
        'method': 'username',
        'params': {'username': value}
      }));
      username = value;
      channel.sink.add(json.encode({'method': 'users'}));
    });
  }

  Container getMessageList(Size _size) {
    List<Widget> listWidget = [];

    for (var user in usersList) {
      listWidget.add(
        buildListUser(_size, context, user['user']),
      );
    }

    return Container(
      alignment: Alignment.center,
      child: ListView(
        children: listWidget,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('List User'),
            InkWell(
              onTap: () {
                _onSignSocket();
              },
              child: Icon(Icons.refresh_outlined),
            ),
          ],
        ),
        backgroundColor: colorses.dasar,
      ),
      body: getMessageList(_size),
    );
  }

  Padding buildListUser(Size _size, BuildContext context, String nama) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: _size.width * 0.9,
        height: _size.height * 0.1,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              nama,
              style: TextStyle(fontSize: 28),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatPage(receiver: nama),
                    ));
              },
              child: Icon(Icons.arrow_forward_ios_rounded),
            )
          ],
        ),
      ),
    );
  }
}
