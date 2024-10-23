import 'package:flutter/material.dart';

class CardUsers extends StatefulWidget {
  final String npkUser;
  final String longNameUser;
  final String passwordUser;
  final Future<void> Function() onPressedDelete;

  const CardUsers(
      {super.key,
        required this.npkUser,
        required this.longNameUser,
        required this.passwordUser,
        required this.onPressedDelete});

  @override
  State<CardUsers> createState() => _CardUsersState();
}

class _CardUsersState extends State<CardUsers> {
  bool isCardPressed = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.white.withOpacity(0.3),
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        setState(() {
          isCardPressed = !isCardPressed;
        });
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15),
          child: AnimatedCrossFade(
            duration: Duration(milliseconds: 300),
            firstChild: Column(
              mainAxisSize: MainAxisSize.max,
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
                  widget.npkUser,
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
                Expanded(
                  child: Text(
                    widget.passwordUser,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            secondChild: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 100,
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                    Text(
                      "Delete",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            crossFadeState: isCardPressed
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
          ),
        ),
      ),
    );
  }
}
