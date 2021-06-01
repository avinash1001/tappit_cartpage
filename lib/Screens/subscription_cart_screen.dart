import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubsCartScreen extends StatefulWidget {
  @override
  _SubsCartScreenState createState() => _SubsCartScreenState();
}

class _SubsCartScreenState extends State<SubsCartScreen> {
  int quantity = 1;
  int deliveries = 30;
  DateTime selectedDate = DateTime.now();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late SharedPreferences prefs;
  void afterSub() {
    var orderValue = 531 * quantity * deliveries;
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.cyan)),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Done"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.cyan)),
              ),
            ],
            title: Text("Order value: ₹${orderValue}"),
            //content: Text(orderValue.toString()),
          );
        });
  }

  void showCalender() {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.cyan)),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Done"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.cyan)),
              ),
            ],
            content: Container(
              height: 200,
              // color: Colors.white,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateTime.now(),
                backgroundColor: Colors.white,
                onDateTimeChanged: (DateTime newDateTime) {
                  setState(() {
                    selectedDate = newDateTime;
                  });
                },
              ),
            ),
          );
        });
  }

  void showDelivery() {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text("Choose Recharge"),
            actions: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    deliveries = 10;
                  });
                  prefs.setInt("del", deliveries);
                  Navigator.pop(context);
                },
                child: Text("10"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.cyan)),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    deliveries = 20;
                  });
                  prefs.setInt("del", deliveries);
                  Navigator.pop(context);
                },
                child: Text("20"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.cyan)),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    deliveries = 30;
                  });
                  prefs.setInt("del", deliveries);
                  Navigator.pop(context);
                },
                child: Text("30"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.cyan)),
              ),
            ],
          );
        });
  }

  void getSavedData() async {
    prefs = await _prefs;

    setState(() {
      quantity =
          (prefs.containsKey("quantity") ? prefs.getInt("quantity") : 1)!;
      deliveries = (prefs.containsKey("del") ? prefs.getInt("del") : 30)!;
    });
  }

  @override
  void initState() {
    getSavedData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final availHeight = mq.size.height - mq.padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            color: Colors.cyan,
            height: mq.padding.top,
          ),
          Container(
            color: Colors.white,
            height: availHeight * 0.1,
            child: Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios),
                  Text(
                    "Create subscription",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          Container(
              height: availHeight * 0.8,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: Colors.cyan[50],
                      height: availHeight * 0.2,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                "assets/ttg.jpg",
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Tata Tea Gold (1 kg)",
                                    style: TextStyle(fontSize: 18)),
                                Row(
                                  children: [
                                    Text("₹531  ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      "₹625.00",
                                      style: TextStyle(
                                          fontSize: 12,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: Colors.black45),
                                    ),
                                    Text(" * 1 Pkt",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black45)),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      height: availHeight * 0.12,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.shopping_bag_outlined,
                                  size: 30,
                                  color: Colors.black54,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Quantity\nper day",
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 15),
                                ),
                              ],
                            ),
                            Container(
                              width: mq.size.width / 3,
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: Colors.cyan),
                                  shape: BoxShape.rectangle),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (quantity > 1) {
                                        setState(() {
                                          quantity--;
                                        });
                                        prefs.setInt("quantity", quantity);
                                      }
                                    },
                                    child: Icon(
                                      Icons.remove,
                                      color: quantity == 1
                                          ? Colors.cyan[100]
                                          : Colors.cyan,
                                    ),
                                  ),
                                  Text(
                                    quantity.toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        quantity++;
                                      });
                                      prefs.setInt("quantity", quantity);
                                    },
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.cyan,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      endIndent: 10.0,
                      indent: 10.0,
                    ),
                    Container(
                      height: availHeight * 0.2,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.repeat_rounded,
                                  size: 30,
                                  color: Colors.black54,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Repeat",
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 15),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "DAILY",
                                  style: TextStyle(
                                      color: Colors.cyan, fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: (availHeight * 0.2) * 0.3,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.cyan,
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "M",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: (availHeight * 0.2) * 0.3,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.cyan,
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "T",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: (availHeight * 0.2) * 0.3,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.cyan,
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "W",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: (availHeight * 0.2) * 0.3,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.cyan,
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "T",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: (availHeight * 0.2) * 0.3,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.cyan,
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "F",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: (availHeight * 0.2) * 0.3,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.cyan,
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "S",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: (availHeight * 0.2) * 0.3,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.cyan,
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "S",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 14,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      endIndent: 10.0,
                      indent: 10.0,
                    ),
                    InkWell(
                      onTap: () {
                        showDelivery();
                      },
                      child: Container(
                        height: availHeight * 0.12,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.history_sharp,
                                    size: 30,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Recharge/Top up",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        "${deliveries} Deliveries",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      endIndent: 10.0,
                      indent: 10.0,
                    ),
                    InkWell(
                      onTap: () {
                        showCalender();
                      },
                      child: Container(
                        height: availHeight * 0.12,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.history_sharp,
                                    size: 30,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Start date",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        selectedDate.day.toString() +
                                            '-' +
                                            selectedDate.month.toString() +
                                            '-' +
                                            selectedDate.year.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Container(
            height: availHeight * 0.1,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 0),
              ),
            ]),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "DELIVER ONCE",
                      style: TextStyle(color: Colors.cyan, fontSize: 16),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      afterSub();
                    },
                    child: Text(
                      "SUBSCRIBE",
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.cyan)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
