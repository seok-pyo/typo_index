import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:typo_index/screen/detail_screen.dart';
import 'package:typo_index/service/typography_model.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen2> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.black,
          elevation: 0,
          title: Text('타이포그래피 인덱스')),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(60, 20, 60, 40),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search...",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.greenAccent,
                    width: 1,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent, width: 1),
                ),
                focusColor: Colors.greenAccent,
                hintStyle: TextStyle(color: Colors.greenAccent),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.greenAccent,
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: Colors.greenAccent,
                        ),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = "";
                          });
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('word').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                List<Typographymodel> words = snapshot.data!.docs.map((doc) {
                  return Typographymodel.fromJson(
                      doc.data() as Map<String, dynamic>);
                }).toList();

                List<Typographymodel> filteredWords = words.where((word) {
                  return word.word.toLowerCase().contains(_searchQuery);
                }).toList();

                return makeList(filteredWords);
              },
            ),
          ),
        ],
      ),
    );
  }
}

ListView makeList(List<Typographymodel> words) {
  return ListView.separated(
    separatorBuilder: (context, index) => Divider(
      color: Colors.grey[500],
      thickness: 0.5,
      indent: 30,
      endIndent: 30,
    ),
    itemCount: words.length,
    itemBuilder: (context, index) {
      return ListTile(
        title: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.centerRight,
          child: Text(
            words[index].word,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(
                name: words[index].word,
                meaning1: words[index].meaning1,
                meaning2: words[index].meaning2,
                meaning3: words[index].meaning3,
                subtitle: words[index].subtitle,
                refer: words[index].refer,
                simil: words[index].simil,
                body: words[index].body,
                note: words[index].note,
              ),
            ),
          );
        },
      );
    },
  );
}
