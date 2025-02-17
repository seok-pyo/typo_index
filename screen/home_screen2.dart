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
        titleSpacing: 30,
        toolbarHeight: 80,
        centerTitle: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.menu_book,
                  color: Colors.black87,
                )),
          )
        ],
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        title: Text(
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
            '타이포그래피 인덱스'),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: false,
            stretch: false,
            titleSpacing: 0.0,
            backgroundColor: Colors.white,
            expandedHeight: 150.0,
            flexibleSpace: Center(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: setTextField()),
            ),
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance.collection('word').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SliverToBoxAdapter(
                      child: Center(
                    child: Text(style: TextStyle(fontSize: 15), '글자를 모읍니다...'),
                  ));
                }

                List<Typographymodel> words = snapshot.data!.docs.map((doc) {
                  return Typographymodel.fromJson(doc.data());
                }).toList();

                List<Typographymodel> filteredWords = words.where((word) {
                  return word.word.toLowerCase().contains(_searchQuery);
                }).toList();

                return SliverList.separated(
                  itemCount: filteredWords.length,
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.grey[500],
                    thickness: 0.5,
                    indent: 30,
                    endIndent: 30,
                  ),
                  itemBuilder: (context, index) {
                    final word = filteredWords[index];
                    return SizedBox(
                      height: 70,
                      child: Center(
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 30),
                          title: Text(
                            word.word,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              print('Yes!');
                            },
                            child: Icon(
                              color: Colors.black45,
                              Icons.bookmark_border_rounded,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                  name: word.word,
                                  meaning1: word.meaning1,
                                  meaning2: word.meaning2,
                                  meaning3: word.meaning3,
                                  subtitle: word.subtitle,
                                  refer: word.refer,
                                  simil: word.simil,
                                  body: word.body,
                                  note: word.note,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              }),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 60,
            ),
          )
        ],
      ),
    );
  }

  TextField setTextField() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: "Search...",
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black45,
            width: 1,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black45, width: 1.25),
        ),
        focusColor: Colors.black45,
        hintStyle: TextStyle(color: Colors.black45),
        prefixIcon: Icon(
          Icons.search,
          color: Colors.black45,
        ),
        suffixIcon: _searchQuery.isNotEmpty
            ? IconButton(
                icon: Icon(
                  Icons.clear,
                  color: Colors.black45,
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
    );
  }
}
