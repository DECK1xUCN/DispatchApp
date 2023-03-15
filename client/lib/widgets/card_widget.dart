import 'package:client/classes/CardContent.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final CardContent cardContent;

  const CardWidget({Key? key, required this.cardContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
          width: 300,
          height: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: 45,
                backgroundColor: Colors.purple[200],
                child: const Icon(
                  Icons.flight,
                  color: Colors.deepPurple,
                  size: 60,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    cardContent.title,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    cardContent.subtitle,
                    style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
