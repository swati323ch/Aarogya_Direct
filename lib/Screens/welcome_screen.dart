import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(80, 80, 80, 80),
              child: Image.asset(
                'assets/images/real.png',
              ),
            ),
            Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Keep yourself safer with active geofence",
                      style:
                          TextStyle(color: Color.fromARGB(199, 23, 119, 197)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Track, Monitor, \nStay",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Safer !",
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(203, 236, 80, 32)),
                          ),
                        ],
                      ),
                    ),
                    FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.pushNamed(context, '/map');
                      },
                      backgroundColor: Color.fromARGB(203, 236, 80, 32),
                      label: Text("Get Started "),
                    ),
                  ],
                )),
          ],
        ),
      ]),
    );
  }
}
