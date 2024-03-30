import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavQuotes extends StatefulWidget {
  const FavQuotes({super.key});

  @override
  State<FavQuotes> createState() => _FavQuotesState();
}

class _FavQuotesState extends State<FavQuotes> {
  List? favQuotes;

  void deleteQuote(int ind) async {
    setState(() {
      favQuotes!.removeAt(ind);
    });
    var pref = await SharedPreferences.getInstance();
    var str = jsonEncode(favQuotes);
    await pref.setString('quotesString', str);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inItExtended();
  }

  inItExtended() async {
    var pref = await SharedPreferences.getInstance();
    String? str = pref.getString('quotesString');
    List tempList = [];
    str != null ? tempList = json.decode(str) : null;
    setState(() {
      favQuotes = tempList;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text('My Favourite Quotes'),
        ),
        backgroundColor: Colors.amber[100],
        body: favQuotes!.isNotEmpty
            ? ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(30)),
                    padding: EdgeInsets.all(width * 0.03),
                    margin: EdgeInsets.only(
                        top: height * 0.03,
                        left: width * 0.05,
                        right: width * 0.05),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: height * 0.02),
                            child: Text(favQuotes![index][0]),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: height * 0.03),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    favQuotes![index][1],
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  )
                                ]),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                  onPressed: () => deleteQuote(index),
                                  child: Text('Delete this Quote')),
                            ],
                          )
                        ]),
                  );
                },
                itemCount: favQuotes!.length,
              )
            : Center(
                child: Text('Nothing to show'),
              ));
  }
}
