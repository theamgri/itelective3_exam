import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:maghari_flutter/homepage.dart';
import 'package:maghari_flutter/main.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
//import 'package:flutter_application_1/rightnavbar.dart';

void main() {
  runApp(LeftDrawer());
}

class LeftDrawer extends StatelessWidget {
  LeftDrawer({Key? key}) : super(key: key);

  final _controller = SidebarXController(selectedIndex: 0, extended: true);

  final _key = GlobalKey<ScaffoldState>();
  //final _keyScaffold = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomePage',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        canvasColor: Color.fromARGB(255, 78, 78, 78),
        scaffoldBackgroundColor: Color.fromARGB(154, 205, 205, 205),
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            color: Colors.white,
            fontSize: 46,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      home: Builder(
        builder: (context) {
          final isSmallScreen = MediaQuery.of(context).size.width < 800;
          backgroundColor:
          NeumorphicTheme.baseColor(context);
          //final isSmallScreen2 = MediaQuery.of(context).size.width < 600;
          return Scaffold(
            key: _key,
            appBar: isSmallScreen
                ? AppBar(
                    backgroundColor: Color.fromARGB(255, 255, 132, 101),
                    //title: Text(_getTitleByIndex(_controller.selectedIndex)),
                    leading: IconButton(
                      onPressed: () {
                        // if (!Platform.isAndroid && !Platform.isIOS) {
                        //   _controller.setExtended(true);
                        // }
                        _key.currentState?.openDrawer();
                        //_key.currentState?.openEndDrawer();
                      },
                      icon: const Icon(Icons.menu),
                    ),
                  )
                : null,
            drawer: left(controller: _controller),
            // endDrawer: right(
            //   controller: _controller,
            // ),
            body: Row(
              children: [
                if (!isSmallScreen)
                  left(
                    controller: _controller,
                  ),
                Expanded(
                  child: Center(
                    child: _ScreensExample(
                      controller: _controller,
                    ),
                  ),
                ),
                // if (!isSmallScreen)
                //   right(
                //     controller: _controller,
                //   ),
                // Expanded(
                //   child: Container(
                //     child: right(
                //       controller: _controller,
                //     ),
                //   ),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class left extends StatelessWidget {
  const left({
    Key? key,
    required SidebarXController controller,
  })  : _controller = controller,
        super(key: key);

  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.grey.shade50,
                Colors.grey.shade200
              ]), // Colors.grey.shade200,
        ),
        hoverColor: NeumorphicTheme.baseColor(context),
        textStyle:
            TextStyle(color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.7),
          ),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: actionColor.withOpacity(0.37),
          ),
          color: NeumorphicTheme.baseColor(context),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.28),
              blurRadius: 30,
            )
          ],
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.grey.shade50, Colors.grey.shade200]),
        ),
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Color.fromARGB(255, 0, 0, 0),
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: Color.fromARGB(154, 224, 224, 224),
        ),
      ),
      footerDivider: divider,
      headerBuilder: (context, extended) {
        return SizedBox(
            height: 150,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(35),
                  ),
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/logo.png',
                      ),
                      fit: BoxFit.fill),
                ),
              ),
            ));
      },
      items: [
        SidebarXItem(
          icon: Icons.home,
          label: 'Dashboard',
          onTap: () {
            return Scaffold(body: Center(child: Text("Dashboard")));
          },
        ),
        const SidebarXItem(
          icon: Icons.folder,
          label: 'Settings',
        ),
        const SidebarXItem(
          icon: Icons.settings,
          label: 'Profile',
        ),
        SidebarXItem(
          icon: Icons.logout,
          label: 'Logout',
          onTap: () {
            Navigator.pushReplacement(context,
                new MaterialPageRoute(builder: (context) => new MyApp()));
          },
        ),
      ],
    );
  }
}

class _ScreensExample extends StatelessWidget {
  const _ScreensExample({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    final pageTitle = _getTitleByIndex(controller.selectedIndex);
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        switch (controller.selectedIndex) {
          case 0:
            return Scaffold(
              body: Container(
                //child: Text("Dashboard"),
                child: ForData(),
              ),
            );
          case 2:
            return Scaffold(
              body: Center(child: Text("Profile")),
            );

          case 1:
            return Container(
              height: 450.0, //10% of screen height
              //width: 200.0,
              color: Color.fromARGB(255, 255, 255, 255),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(left: 15)),
                        Text(
                          "Iphone",
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontWeight: FontWeight.w100,
                            fontSize: 50,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("iphone-transparent2.png"),
                            fit: BoxFit.fill),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15.0),
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                  ]),
            );
          default:
            return Scaffold(
              body: Container(
                child: LeftDrawer(),
              ),
              //ForData(),
            );
        }
      },
    );
  }
}

String _getTitleByIndex(int index) {
  switch (index) {
    case 0:
      return 'Dashboard';
    case 1:
      return 'Projects';

    case 2:
      return 'About Us';

    default:
      return 'Not found page';
  }
}

const primaryColor = Color.fromARGB(255, 0, 0, 0);
//const canvasColor = Color(0xFF2E2E48);
//const scaffoldBackgroundColor = Color(0xFF464667);
const accentCanvasColor = Color(0xFF3E3E61);
const white = Colors.white;
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);
