import 'package:flutter/material.dart';
import 'package:gestionstock/services/auth_service.dart';
import 'package:gestionstock/services/products_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> products = [];

  // auth variables
  String access = '';
  String refresh = '';
  int expiration = 0;

  @override
  void initState() {
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      access =
          prefs.getString('access') != null ? prefs.getString('access') : '';
      refresh =
          prefs.getString('refresh') != null ? prefs.getString('refresh') : '';
      print('aaaaaaaaaaaaaaaaaaaaa');
      print(refresh);
      print('aaaaaaaaaaaaaaaaaaaaa');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              List<dynamic> l;
              await ProductsService().getProducts(access).then((liste) {
                l = liste;
              });
              setState(() {
                this.products = l;
                print(this.products);
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.setString('access', '');
              prefs.setString('refresh', '');
              prefs.setInt('expiration', 0);
              prefs.setBool('isLogged', false);
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Stack(
            children: <Widget>[
              Center(
                child: Container(
                  height: 300,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: NetworkImage(products[index]['image']),
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 100,
                      color: Colors.white60,
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "${products[index]['titre']}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${products[index]['prix']}DT",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Column(
                          children: <Widget>[
                            Text(
                              "${products[index]['description']}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        // leading: Image(
                        //   image: NetworkImage(products[index]['image']),
                        // ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
