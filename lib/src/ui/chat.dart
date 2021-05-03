import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ws/src/pref/preference.dart';
import 'package:flutter_ws/src/ui/colors.dart';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatPage extends StatefulWidget {
  final String receiver;

  ChatPage({Key key, this.receiver}) : super(key: key);
  final WebSocketChannel channel =
      IOWebSocketChannel.connect('ws://ws-chat123.herokuapp.com/');

  @override
  _ChatPageState createState() => _ChatPageState(channel: channel);
}

class _ChatPageState extends State<ChatPage> {
  final WebSocketChannel channel;
  final _sendText = TextEditingController();
  ScrollController _scrollController = new ScrollController();

  var messageList = [];

  _ChatPageState({this.channel}) {
    channel.stream.listen((e) {
      var event = json.decode(e);
      print(event);
      if (event['method'] == 'message') {
        print(event['result']);
        messageList.add(event['result']);
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    _onSignSocket();

    super.initState();
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  void _onSend() {
    getKdUser().then((value) {
      channel.sink.add(json.encode({
        'method': 'message',
        'params': {
          'from': value,
          'to': widget.receiver,
          'message': _sendText.text
        }
      }));
      messageList.add({'to': widget.receiver, 'message': _sendText.text});
      _sendText.text = '';
      setState(() {});
    });
  }

  void _onSignSocket() {
    getKdUser().then((value) {
      channel.sink.add(json.encode({
        'id': 1,
        'method': 'username',
        'params': {'username': value}
      }));
    });
  }

  Container getMessageList(Size _size) {
    List<Widget> listWidget = [];

    for (var message in messageList) {
      listWidget.add(
        Container(
          alignment: Alignment.bottomRight,
          padding: EdgeInsets.all(10),
          width: _size.width * 0.9,
          height: _size.height * 0.06,
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: colorses.background,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                message['from'] == null ? 'Me ~' : '${message['from']} ~',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                message['message'],
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      width: _size.height * 1,
      height: _size.width * 0.8,
      padding: EdgeInsets.all(10),
      child: ListView(
        controller: _scrollController,
        reverse: false,
        shrinkWrap: true,
        children: listWidget,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 1),
      () =>
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent),
    );
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorses.dasar,
        title: Text("Tumbas Cangkruk"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: getMessageList(_size),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: _size.width * 0.76,
                    child: TextFormField(
                      controller: _sendText,
                      decoration: InputDecoration(
                        labelText: 'Send Message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  FloatingActionButton(
                    backgroundColor: colorses.dasar,
                    onPressed: () {
                      _onSend();
                    },
                    child: Icon(Icons.send),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
