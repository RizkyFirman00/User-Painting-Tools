import 'package:flutter/material.dart';

class CardUsers extends StatefulWidget {
  final String emailUser;
  final String longNameUser;
  final String npkUser;
  final Future<void> Function() onPressedDelete;

  const CardUsers(
      {super.key,
      required this.emailUser,
      required this.longNameUser,
      required this.npkUser,
      required this.onPressedDelete});

  @override
  State<CardUsers> createState() => _CardUsersState();
}

class _CardUsersState extends State<CardUsers> {
  bool isCardPressed = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isCardPressed = !isCardPressed;
        });
      },
      child: Card(
        child: isCardPressed
            ? Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          widget.onPressedDelete().then((_) {
                            setState(() {
                              isCardPressed = false;
                            });
                          });
                        },
                        icon: Icon(
                          Icons.delete,
                          size: 40,
                          color: Colors.red,
                        ),
                      ),
                      Text("Delete", style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),),
                    ],
                  )
                ],
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email: ",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      widget.emailUser,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "NPK: ",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      widget.npkUser,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
