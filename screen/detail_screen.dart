import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String name,
      meaning1,
      meaning2,
      meaning3,
      subtitle,
      refer,
      note,
      simil,
      body;

  const DetailScreen({
    super.key,
    required this.name,
    required this.meaning1,
    this.meaning2 = '',
    this.meaning3 = '',
    this.refer = '',
    required this.subtitle,
    this.body = '',
    this.note = '',
    this.simil = '',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(name)),
        body: SizedBox(
          width: double.infinity,
          child: Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Text(subtitle,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        meaning1,
                        style: TextStyle(height: 1.7),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: meaning2.isNotEmpty
                          ? Text(
                              meaning2,
                              style: TextStyle(height: 1.7),
                            )
                          : SizedBox(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: meaning3.isNotEmpty
                          ? Text(
                              meaning3,
                              style: TextStyle(height: 1.7),
                            )
                          : SizedBox(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: refer.isNotEmpty
                          ? Text(
                              refer,
                              style: TextStyle(height: 1.7),
                            )
                          : SizedBox(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: simil.isNotEmpty
                          ? Text(
                              simil,
                              style: TextStyle(height: 1.7),
                            )
                          : SizedBox(),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: body.isNotEmpty
                          ? Text(
                              body,
                              style: TextStyle(height: 1.7, fontSize: 18),
                            )
                          : SizedBox(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: note.isNotEmpty
                          ? Text(
                              note,
                              style: TextStyle(height: 1.7, fontSize: 18),
                            )
                          : SizedBox(),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              )),
        ));
  }
}
