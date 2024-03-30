import 'dart:convert';
import 'package:quote_of_the_day_app/favQuotes.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void saveQuote(String quote, author) async {
    var pref = await SharedPreferences.getInstance();
    String? str = pref.getString('quotesString');
    List tempList = [];
    str != null ? tempList = json.decode(str) : null;
    tempList.add([quote, author]);
    String sendStr = json.encode(tempList);
    await pref.setString('quotesString', sendStr);
  }

  Future getQuote() async {
    Response response = await get(
        Uri.parse('https://api.api-ninjas.com/v1/quotes'),
        headers: {'X-Api-Key': '+KoocjK3OXn8/+tlEJdHpQ==zzSVfJ3yfNfhSfW2'});
    if (response.statusCode == 200) {
      List body = jsonDecode(response.body);
      return body;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text('Quote of the day App'),
          actions: [
            IconButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavQuotes(),
                    )),
                icon: Icon(Icons.favorite_outline_rounded))
          ],
        ),
        backgroundColor: Colors.amber[100],
        body: SafeArea(
          child: FutureBuilder(
              future: getQuote(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: SizedBox(
                        width: width * 0.1,
                        height: width * 0.1,
                        child: const CircularProgressIndicator()),
                  );
                } else {
                  return Container(
                    margin: EdgeInsets.only(
                        left: width * 0.05, right: width * 0.05),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: height * 0.03),
                            child: Text(snapshot.data[0]['quote']),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: height * 0.03),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    snapshot.data[0]['author'],
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  )
                                ]),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: height * 0.05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomeScreen(),
                                        )),
                                    icon: Icon(Icons.arrow_forward)),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                  onPressed: () => saveQuote(
                                      snapshot.data[0]['quote'],
                                      snapshot.data[0]['author']),
                                  child: Text('Save this Quote')),
                              ElevatedButton(
                                  onPressed: () {},
                                  child: Text('Share this Quote'))
                            ],
                          )
                        ]),
                  );
                }
              }),
        ));
  }
}
