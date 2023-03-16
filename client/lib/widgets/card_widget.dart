import 'package:client/classes/CardContent.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final CardContent cardContent;

  const CardWidget({Key? key, required this.cardContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: cardContent.onTap,
      child: Card(
          color: Colors.white,
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: SizedBox(
            width: 300,
            height: 120,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.purple[100],
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
                        style: const TextStyle(fontSize: 15, color: Colors.black),
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
            ),
          )),
    );
  }
}
