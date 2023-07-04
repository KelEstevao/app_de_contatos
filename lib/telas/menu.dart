import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key});

  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      // Trate qualquer erro que possa ocorrer durante o logout
      print('Erro ao fazer logout: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("App de Contatos"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(15.0, 0.0, 20.0, 0.0),
        child: Column(
          children: [
            SizedBox(
              height: 50.0,
            ),
            Image.asset('img/ifpi.png', width: 170.0),
            SizedBox(height: 150.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 180.0,
                  width: 180.0,
                  child: Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        backgroundColor: Colors.amber,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/contatos',
                        );
                      },
                      child: Text('Contatos'),
                    ),
                  ),
                ),
                Container(
                  height: 180.0,
                  width: 180.0,
                  child: Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        backgroundColor: Colors.amber,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/maps',
                        );
                      },
                      child: Text('Mapas'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 180.0,
                  height: 180.0,
                  child: Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        backgroundColor: Colors.amber,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/extra1',
                        );
                      },
                      child: Text('EXTRA1'),
                    ),
                  ),
                ),
                Container(
                  width: 180.0,
                  height: 180.0,
                  child: Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        backgroundColor: Colors.amber,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/extra2',
                        );
                      },
                      child: Text('EXTRA2'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
