
import 'package:flutter/material.dart';
class MessageBuble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String userName;
  final Key key;

  MessageBuble(this.message,this.userName, this.isMe,{this.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.purple[300] : Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),topRight:Radius.circular(12),
              bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12), 
              bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
            ),
          ),
          width: 120,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              //snapshot will hold data about user 

                Text(
                  userName,
                  style: TextStyle(fontWeight: FontWeight.bold,
                  color: isMe ?Colors.black:Theme.of(context).accentTextTheme.headline1.color
                  ),
                  )
              ,
              Text(message,
                  style: TextStyle(
                      color: isMe ?Colors.black:Theme.of(context).accentTextTheme.headline1.color)
                ,      
                textAlign: isMe ? TextAlign.end : TextAlign.start,
              ),
              
            ],
          ),
        ),
      ],
    );
  }
}
