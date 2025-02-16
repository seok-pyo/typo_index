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
          title: Text('타이포그래피 용어 정리')),
      body: Column(
        children: [
          // 🔍 검색창 추가
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
                  // 선택되었을 때 밑줄 색상 변경
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
                  _searchQuery = value.toLowerCase(); // 소문자로 변환하여 검색
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

                // 🔍 Firebase에서 가져온 데이터를 Typographymodel 리스트로 변환
                List<Typographymodel> words = snapshot.data!.docs.map((doc) {
                  return Typographymodel.fromJson(
                      doc.data() as Map<String, dynamic>);
                }).toList();

                // 🔍 검색어가 포함된 단어만 필터링
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

// 🔹 리스트 뷰 생성
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
      return GestureDetector(
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
        child: Container(
          decoration: BoxDecoration(
              // color: Colors.white,
              ),
          height: 40,
          margin: EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.centerLeft,
          child: Text(
            words[index].word,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      );
    },
  );
}
