import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:thinkcreative_technologies/Configs/DbPaths.dart';
import 'package:thinkcreative_technologies/Configs/Dbkeys.dart';
import 'package:thinkcreative_technologies/Configs/Mycolors.dart';
import 'package:thinkcreative_technologies/Widgets/CustomCard.dart';
import 'package:thinkcreative_technologies/Widgets/MyScaffold.dart';

// import 'package:grokartadmin/main2.dart';
class SearchService {
  searchByName(String searchField, String searchDoccollection) {
    return FirebaseFirestore.instance
        .collection(searchDoccollection)
        .where('searchKey',
            isEqualTo: searchField.trim().substring(0, 1).toUpperCase())
        .where('searchKey', isNotEqualTo: null)
        .limit(20)
        .get();
  }
}

class SearchUserByName extends StatefulWidget {
  @override
  _SearchUserByNameState createState() => new _SearchUserByNameState();
}

class _SearchUserByNameState extends State<SearchUserByName> {
  bool isEmpty = true;
  bool issearching = true;
  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(inputvalue, String dbkeysField) async {
    if (issearching == false) {
      setState(() {
        issearching = true;
      });
    }

    if (inputvalue.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    var capitalizedValue = inputvalue.toString().trim().length == 1
        ? inputvalue.toString().toUpperCase()
        : inputvalue.substring(0, 1).toUpperCase() + inputvalue.substring(1);

    if (queryResultSet.length == 0 && inputvalue.length == 1) {
      print('searching');
      SearchService()
          .searchByName(inputvalue, DbPaths.collectionusers)
          .then((QuerySnapshot docs) {
        if (docs.docs.length > 0) {
          for (int i = 0; i < docs.docs.length; ++i) {
            queryResultSet.add(docs.docs[i].data());
            tempSearchStore = [];
            queryResultSet.forEach((element) {
              if (element[dbkeysField].startsWith(capitalizedValue)) {
                setState(() {
                  tempSearchStore.add(element);
                });
              }
            });
            print('result added');
            setState(() {});
          }
        }
      });
    } else {
      print('not searching');
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element[dbkeysField].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Search by name',
      body: ListView(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            onChanged: (val) {
              if (val.isEmpty) {
                setState(() {
                  isEmpty = true;

                  queryResultSet = [];
                  tempSearchStore = [];
                });
              } else {
                setState(() {
                  isEmpty = false;
                });
                initiateSearch(val, Dbkeys.uSERfullname);
              }
            },
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: IconButton(
                  color: Colors.black,
                  icon: Icon(Icons.search),
                  iconSize: 20.0,
                  onPressed: () {},
                ),
                contentPadding: EdgeInsets.only(left: 25.0),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Mycolors.secondary, width: 1.5),
                    borderRadius: BorderRadius.circular(4.0)),
                hintText: 'Type user full name ...',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Mycolors.primary, width: 1.5),
                    borderRadius: BorderRadius.circular(4.0))),
          ),
        ),
        SizedBox(height: 10.0),
        isEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 5.0,
                  ),
                  SizedBox(
                    height: 60.0,
                  ),
                  Icon(
                    Icons.person_search_rounded,
                    size: 120,
                    color: Mycolors.grey.withOpacity(0.2),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              )
            : ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  tempSearchStore.length > 0
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(18, 10, 18, 13),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Search results :',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                tempSearchStore.length == 20
                                    ? '20+ results found. Continue typing '
                                    : '${tempSearchStore.length} users found',
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),
                  ListView(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      primary: false,
                      shrinkWrap: true,
                      children: tempSearchStore.map((element) {
                        return buildResultCard(context, element);
                      }).toList()),
                ],
              )
      ]),
    );
  }

  Widget buildResultCard(context, data) {
    return UserCard(
      isProfileFetchedFromProvider: false,
      docMap: data,
      isswitchshow: false,
    );
  }
}
