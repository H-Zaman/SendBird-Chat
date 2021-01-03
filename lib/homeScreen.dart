import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffbde0fe),
      appBar: AppBar(
        backgroundColor: Color(0xffcdb4db),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Hero(
            tag: 'logo',
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(
                  'assets/Circular-Logos.png'
              ),
            ),
          ),
        ),
        title: Text(
          'M-Vinx Designs',
          style: TextStyle(
              fontSize: 24,
              letterSpacing: 2
          ),
        ),
        bottom: AppBar(
          elevation: 0,
          backgroundColor: Color(0xffcdb4db),
          title: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search
                    ),
                    fillColor: Color(0xffffc8dd),
                    filled: true,
                    hintText: 'Search for user...',
                    contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15)
                    )
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        )
      ),
    );
  }
}
