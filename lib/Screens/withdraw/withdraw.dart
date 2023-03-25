import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/retry.dart';
import 'package:thinkcreative_technologies/Configs/Mycolors.dart';

import '../../Widgets/Buttons.dart';

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({super.key});

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 1,
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          title: Text(
            "WithDraw Requests",
            style: TextStyle(color: Colors.black, fontSize: 16),
          )),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection("withdrawRequest").get(),
        builder: (context, AsyncSnapshot snapshot) {
          List<QueryDocumentSnapshot> withlist = [];
          if (snapshot.hasData) {
            QuerySnapshot withdra = snapshot.data;
            print(withdra.docs.length);
            withlist = withdra.docs;
            return withlist.isNotEmpty && withlist.length != 0
                ? ListView.builder(
                    itemCount: withlist.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          elevation: 1,
                          child: Container(
                            decoration: BoxDecoration(color: Colors.white),
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    height: 120,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              withlist[index].get(
                                                "url",
                                              ),
                                            ),
                                            fit: BoxFit.cover),
                                        color: Mycolors.appbar,
                                        shape: BoxShape.circle),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Doctor Name: ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              withlist[index].get(
                                                "Drname",
                                              ),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Folio No",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              withlist[index].get("foliono"),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Doctor Phone No",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              withlist[index].get("phoneno"),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Account Title",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              withlist[index]
                                                  .get("accountname"),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Withdraw Amount",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              "${withlist[index].get("amount")} ₦",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Account Number ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              withlist[index]
                                                  .get("accountnumber"),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        withlist[index].get("paymentdone") ==
                                                    false ||
                                                withlist[index]
                                                        .get("paymentdone") ==
                                                    null
                                            ? Center(
                                                child: MySimpleButton(
                                                  onpressed: () async {
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection("users")
                                                        .doc(withlist[index]
                                                            .get("phoneno"))
                                                        .get()
                                                        .then((value) async {
                                                      List data = [];
                                                      data = await value.get(
                                                          "withdrawhistory");
                                                      data.add({
                                                        "bank": withlist[index]
                                                            .get("bank"),
                                                        'withdrawdate':
                                                            DateTime.now(),
                                                        "withdrawamount":
                                                            withlist[index]
                                                                .get("amount")
                                                      });

                                                      FirebaseFirestore.instance
                                                          .collection("users")
                                                          .doc(withlist[index]
                                                              .get("phoneno"))
                                                          .update({
                                                        "withdrawhistroy": data
                                                      }).then((value) {
                                                        showModalBottomSheet(
                                                            isScrollControlled:
                                                                true,
                                                            context: context,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.vertical(
                                                                      top: Radius
                                                                          .circular(
                                                                              25.0)),
                                                            ),
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return Container(
                                                                height: 220,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          28.0),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(
                                                                          Icons
                                                                              .check,
                                                                          color: Colors.green[
                                                                              400],
                                                                          size:
                                                                              40),
                                                                      SizedBox(
                                                                        height:
                                                                            30,
                                                                      ),
                                                                      Text(
                                                                        "You send withdraw amount to doctor",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            });
                                                      });
                                                    });
                                                  },
                                                  spacing: 0.3,
                                                  buttontext: 'Pending',
                                                ),
                                              )
                                            : Center(
                                                child: MySimpleButton(
                                                  // onpressed: () {},
                                                  spacing: 0.3,
                                                  buttontext: 'WithDraw Send',
                                                  icon: Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                    size: 18,
                                                  ),
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    })
                : Center(
                    child: Container(
                    child: Text(
                      "No Withdraw Request Found",
                      style: TextStyle(
                          color: Mycolors.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ));
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Mycolors.primary,
              ),
            );
          }
        },
      ),
    );
  }
}
