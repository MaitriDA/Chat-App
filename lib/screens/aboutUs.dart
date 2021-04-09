import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Hello from team ‘BAATEIN’!",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Text(
            "Hey there! We are so glad to see you :) We are a team of self learned passionate developers who aspire to perk up ordinary apps and websites and revamp our users’ life!  As our name goes, we are here to have some ‘Baatein’ with you. Unlike other tangible chat applications available, ‘Baatein' not only brings about communication but also has a lot more in store. It is available on android devices as well as on the web, so you can find and access it whether you are on your desk or on the go!",
            overflow: TextOverflow.visible,
            style: TextStyle(height: 2),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: new Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 3,
                          )
                        ]),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/images/abhay.jpeg"),
                    ),
                  ),
                  Text("Abhay Ubhale",
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 10,
                    height: 2
                  ),),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: new Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 3,
                          )
                        ]),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/images/asavari.jpeg"),
                    ),
                  ),
                  Text(
                    "Asavari Ambavane",overflow: TextOverflow.visible,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 10,
                      height: 2
                    ),)
                ],
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: new Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 3,
                          )
                        ]),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/images/maitri.jpeg"),
                    ),
                  ),
                  Text("Maitri Amin",
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 10,
                      height: 2
                    ),),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: new Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 3,
                          )
                        ]),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/images/ruchika.jpeg"),
                    ),
                  ),
                  Text(
                    "Ruchika Wadhwa",overflow: TextOverflow.visible,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 10,
                      height: 2
                    ),)
                ],
              ),
            ],
          ),
        ],
      ),
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Features and Future Scope',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Chatting with your friends.',
            style: TextStyle(
                color: Colors.amber[800],
              height: 3
            ),),
            Text(
                'Make the best of your time here with us with our beautiful UI and flawless user experience. Fast messaging on both website and app simultaneously never looked so easy! Join us to streamline all your conversations and much more coming soon.',
              style: TextStyle(
                  height: 2
              ),)
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('To-Do list.' ,style: TextStyle(
                color: Colors.amber[800],
            height: 3
        ),),
            Text(
                'Tick off your editable ToDo list and make progress on your projects, assignments or any other tasks. Delete and edit them as you like it! Boost your productivity and organize your tasks in one place with ‘Baatein’!',
              style: TextStyle(
                height: 2
            ),)],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How do we aspire to grow?',style: TextStyle(
              color: Colors.amber[800],
            height: 3
        ),
            ),
            Text(
                'Baatein may be the simplest of applications right now but we assure you a bright future of this application. We will be looking to implement additional features like group chats, peer to peer audio and video calling etc. Scheduling messages will also be a part of the future development process. Stay tuned!',
              style: TextStyle(
                  height: 2
              ),
            )
          ],
        ),
      ],
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Our Team',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps_outlined),
            label: 'Features',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
