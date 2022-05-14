import 'package:ceiba/data/api.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Userinfo extends StatefulWidget {
  Userinfo({Key? key, required this.user}) : super(key: key);

  Map user;

  @override
  State<Userinfo> createState() => _UserinfoState();
}

class _UserinfoState extends State<Userinfo> {
  final api = Api();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.blueGrey.withOpacity(0.45),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AppBar - - - - - - - - - - //
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsets.only(top: 20, left: 20),
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  children: const [
                    Icon(
                      Icons.arrow_back_rounded,
                      size: 25,
                      color: Colors.white70,
                    ),
                    SizedBox(width: 15),
                    Text(
                      "Atrás",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Body - - - - - - - - - - - //
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(6),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 5,
                    color: Colors.black26,
                    offset: Offset(0.0, 3.0),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.user['name'],
                        style: const TextStyle(
                          color: Color.fromARGB(221, 31, 211, 136),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 5,
                              color: Colors.black26,
                              offset: Offset(0.0, 3.0),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.user['email'],
                        style: TextStyle(
                          color: Colors.lightBlue.withOpacity(0.8),
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.user['phone'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: const [
                  Text(
                    "Posts",
                    style: TextStyle(
                      fontSize: 23,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: Divider(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height - 216,
              child: FutureBuilder(
                future: api.getUserInfoWithCache(1),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                      separatorBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Divider(
                            height: 0,
                          ),
                        );
                      },
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 5,
                                color: Colors.black26,
                                offset: Offset(0.0, 3.0),
                              ),
                            ],
                          ),
                          child: SizedBox(
                            width: size.width - 50,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data[index]['title'],
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Divider(),
                                Text(
                                  snapshot.data[index]['body'],
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
