import 'package:flutter/material.dart';
import 'package:typo_index/screen/detail_screen.dart';
import 'package:typo_index/service/get_store.dart';
import 'package:typo_index/service/typography_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final Future<List<Typographymodel>> model = GetStore.getFirebase();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu_book))],
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            // style: TextStyle(fontFamily: 'Danjo'),
            'Typography Index',
          ),
        ),
        body: FutureBuilder<List<Typographymodel>>(
          future: model,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: Text('Loading'));
            }
            return Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: makeList(snapshot));
          },
        ),
      ),
    );
  }
}

ListView makeList(AsyncSnapshot<List<Typographymodel>> snapshot) {
  return ListView.separated(
    separatorBuilder: (context, index) => SizedBox(
      height: 10,
    ),
    itemCount: snapshot.data!.length,
    itemBuilder: (context, index) {
      return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(
                  name: snapshot.data![index].word,
                  meaning1: snapshot.data![index].meaning1,
                  meaning2: snapshot.data![index].meaning2,
                  meaning3: snapshot.data![index].meaning3,
                  subtitle: snapshot.data![index].subtitle,
                  refer: snapshot.data![index].refer,
                  simil: snapshot.data![index].simil,
                  body: snapshot.data![index].body,
                  note: snapshot.data![index].note,
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.2),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                )
              ],
            ),
            height: 80,
            margin: EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.center,
            child: Text(
                style: TextStyle(
                    // fontFamily: 'Danjo',
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
                snapshot.data![index].word),
          ));
    },
  );
}
