import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'blinking.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> users = [
    {'name': 'Alice', 'photo': 'assets/Anthony.png'},
    {'name': 'Bob', 'photo': 'assets/Irina.png'},
    {'name': 'Catherine', 'photo': 'assets/Marianne.png'},
    {'name': 'David', 'photo': 'assets/Anthony.png'},
    {'name': 'Eva', 'photo': 'assets/Rectangle 5 (2).png'},
    {'name': 'Frank', 'photo': 'assets/Marianne.png'},
    {'name': 'Grace', 'photo': 'assets/Marianne.png'},
    {'name': 'Henry', 'photo': 'assets/Rectangle 5 (2).png'},
    {'name': 'Isabella', 'photo': 'assets/Marianne.png'},
    {'name': 'Jack', 'photo': 'assets/Rectangle 5 (2).png'},
  ];

  final List<String> cardImages = [
    'assets/movie 1.jpg',
    'assets/movie 3.jpg',
    'assets/movie 1.jpg',
    'assets/movie 2.jpg',
  ];

  String getGreeting() {
    final hour = DateTime.now().hour;
    return hour < 12 ? 'Good Morning' : hour < 17 ? 'Good Afternoon' : 'Good Evening';
  }

  int _currentPage = 0;
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  get bottomSheet => null;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  Future<void> openYouTubeVideo(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        title: Center(
          child: Image.asset('assets/MILES.png', height: 30),
        ),
        actions: [SizedBox(width: 48)],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(getGreeting(), style: TextStyle(color: Colors.white, fontSize: 18)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Prajwal Abbigeri', style: TextStyle(color: Colors.white, fontSize: 12)),
                  BlinkingContainer(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text('Talk to us',
                            style: TextStyle(color: Colors.white, fontSize: 14)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Container(
                height: 104,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          BlinkingStoryCircle(photo: user['photo']!),
                          SizedBox(height: 8),
                          Text(user['name']!, style: TextStyle(color: Colors.white, fontSize: 12)),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 180,
                width: 500,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: cardImages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0,vertical: 0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.grey[850],
                          image: DecorationImage(
                            image: AssetImage(cardImages[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Life in the united states...',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Row(
                    children: List.generate(cardImages.length, (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        width: 20.0,
                        height: 2.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: _currentPage == index ? Colors.yellowAccent : Colors.grey,
                        ),
                      );
                    }),
                  ),
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 450,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 2.0,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Container(margin: EdgeInsets.all(2),
                          height: 250,
                          width: 185,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(45),
                              // Radius for the top-right corner
                            ),
                            image: DecorationImage(
                              image: AssetImage(cardImages[index % cardImages.length]),
                              fit: BoxFit.cover,

                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0), // Add padding if needed
                            child: IconButton(
                              icon: Icon(Icons.play_circle_fill, color: Colors.white, size: 20),
                              onPressed: () {
                                openYouTubeVideo('https://youtu.be/rt7V4C4IYyk?si=Ha-dUDsYG-dvfGr3');
                              },
                            ),
                          ),
                        ),

                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Check out our master class..',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Row(
                    children: List.generate(cardImages.length, (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        width: 20.0,
                        height: 2.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: _currentPage == index ? Colors.yellowAccent : Colors.grey,
                        ),
                      );
                    }),
                  ),
                ],
              ),
              SizedBox(
                height: 200,
                width: double.infinity,
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.all(2),
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        image: DecorationImage(
                          image: AssetImage('assets/movie 1.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(Icons.play_circle_fill, color: Colors.white, size: 20),
                          onPressed: () {
                            openYouTubeVideo('https://youtu.be/rt7V4C4IYyk?si=Ha-dUDsYG-dvfGr3');
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),


              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Explore the us miles path away..',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Row(
                    children: List.generate(cardImages.length, (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        width: 20.0,
                        height: 2.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: _currentPage == index ? Colors.yellowAccent : Colors.grey,
                        ),
                      );
                    }),
                  ),
                ],
              ),
              SizedBox(
                height: 200,
                width: double.infinity,
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.all(2),
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        image: DecorationImage(
                          image: AssetImage('assets/movie 2.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(Icons.play_circle_fill, color: Colors.white, size: 20),
                          onPressed: () {
                            openYouTubeVideo('https://youtu.be/rt7V4C4IYyk?si=Ha-dUDsYG-dvfGr3');
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),


              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Explore the us miles path away..',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Row(
                    children: List.generate(cardImages.length, (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        width: 20.0,
                        height: 2.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: _currentPage == index ? Colors.yellowAccent : Colors.grey,
                        ),
                      );
                    }),
                  ),
                ],
              ),
              SizedBox(
                height: 200,
                width: double.infinity,
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.all(2),
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        image: DecorationImage(
                          image: AssetImage('assets/movie 3.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0), 
                        child: IconButton(
                          icon: Icon(Icons.play_circle_fill, color: Colors.white, size: 20),
                          onPressed: () {
                            openYouTubeVideo('https://youtu.be/rt7V4C4IYyk?si=Ha-dUDsYG-dvfGr3');

                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),


              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'CPAs with varun jain ft.bob dayole.',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Row(
                    children: List.generate(cardImages.length, (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        width: 20.0,
                        height: 2.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: _currentPage == index ? Colors.yellowAccent : Colors.grey,
                        ),
                      );
                    }),
                  ),
                ],
              ),
       BottomNavigationBar(
          backgroundColor: Colors.black,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            _pageController.jumpToPage(index);
          },
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'Education',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events),
              label: 'Trophies',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),

           Container(
          color: Colors.black,
          height: 30,
          alignment: Alignment.center,
          child: Text(
            ["Home", "Education", "Trophies", "Profile"][_currentIndex],
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
            ],
          ),
          

          ),
        ),
      bottomNavigationBar: BottomNavigationBar(

        backgroundColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.jumpToPage(index);
        },
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.black87,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Education',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'Trophies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      bottomSheet: _currentIndex != null
          ? Container(

        color: Colors.black,
        height: 30,
        alignment: Alignment.center,
        child: Text(
          ["Home", "Education", "Trophies", "Profile"][_currentIndex],
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      )
          : null,
    );

  }
}


