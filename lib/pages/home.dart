import 'package:ceiba/data/api.dart';
import 'package:ceiba/pages/user_info.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final api = Api();
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
            // custom App Bar - - - - - - - - - - - - - - - - - - - - //
            Container(
              height: 80,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  SizedBox(
                    height: 30,
                    child: Image.asset(
                      'assets/logo.png',
                      color: Colors.black.withOpacity(0.2),
                      colorBlendMode: BlendMode.srcATop,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Prueba de Ingreso',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Search bar - - - - - - - - - - - - - - - - - - - - //
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: controller,
                onChanged: (value) {
                  setState(() {});
                },
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(0),
                  hintText: 'Buscar',
                  hintStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Body - - - - - - - - - - - - - - - - - - - - //
            SizedBox(
              height: size.height - 140,
              child: FutureBuilder(
                future: api.getWithCache(),
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
                        if (snapshot.data[index]['name']
                            .toString()
                            .toLowerCase()
                            .contains(controller.text.toLowerCase())) {
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
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 60,
                                      width: 60,
                                      child: CircleAvatar(
                                        backgroundColor:
                                            Colors.black.withOpacity(0.4),
                                        child: const Icon(
                                          Icons.person_rounded,
                                          size: 35,
                                          color:
                                              Color.fromARGB(188, 22, 212, 117),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data[index]['name'],
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          snapshot.data[index]['email'],
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          snapshot.data[index]['phone'],
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Positioned(
                                  right: -5,
                                  bottom: -12,
                                  child: TextButton(
                                    child: const Text(
                                      'Ver más',
                                      style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 15,
                                      ),
                                    ),
                                    onPressed: () {
                                      FocusScope.of(context).unfocus();
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (c, a1, a2) => Userinfo(
                                              user: snapshot.data[index]),
                                          transitionsBuilder:
                                              (c, anim, a2, child) =>
                                                  FadeTransition(
                                                      opacity: anim,
                                                      child: child),
                                          transitionDuration:
                                              const Duration(milliseconds: 500),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
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
