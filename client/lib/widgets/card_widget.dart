import 'package:client/classes/CardContent.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final CardContent cardContent;

  const CardWidget({Key? key, required this.cardContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.purple,
      elevation: 10,
      child: SizedBox(
        width: 300,
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
                Icons.airplanemode_active,
                size: 50,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    cardContent.title,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                ),
                Text(
                    cardContent.subtitle,
                  style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}

