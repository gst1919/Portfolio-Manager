import 'package:flutter/material.dart';
import 'FadeAnimation.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  String k = '';
  final _auth = FirebaseAuth.instance;
  final storage = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/background.png'),
                        fit: BoxFit.fill)),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 30,
                      width: 80,
                      height: 200,
                      child: FadeAnimation(
                          1,
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/light-1.png'))),
                          )),
                    ),
                    Positioned(
                      left: 140,
                      width: 80,
                      height: 150,
                      child: FadeAnimation(
                          1.3,
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/light-2.png'))),
                          )),
                    ),
                    Positioned(
                      right: 40,
                      top: 40,
                      width: 80,
                      height: 150,
                      child: FadeAnimation(
                          1.5,
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/clock.png'))),
                          )),
                    ),
                    Positioned(
                      child: FadeAnimation(
                          1.6,
                          Container(
                            margin: EdgeInsets.only(top: 50),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
        floatingActionButton: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 300, left: 30, bottom: 20),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      "Hey, I'm your new\nPortfolio Manager",
                      textStyle: const TextStyle(
                        color: Colors.black45,
                        fontFamily: 'Times',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      speed: const Duration(milliseconds: 200),
                    )
                  ],
                  totalRepeatCount: 1,
                  pause: const Duration(milliseconds: 1000),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 30),
                child: FloatingActionButton.extended(
                  splashColor: Colors.black,
                  onPressed: () {
                    k = 'https://sheltered-stream-96597.herokuapp.com/';
                    _launchURL(context);
                  },
                  heroTag: 'View Portfolio',
                  label: const Text('View Portfolio'),
                  backgroundColor: Colors.pink,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 30),
                child: FloatingActionButton.extended(
                  splashColor: Colors.black,
                  onPressed: () {
                    k = "https://bit.ly/3Kfzv4M";
                    _launchURL(context);
                  },
                  heroTag: 'Edit Portfolio',
                  label: const Text('Edit Portfolio'),
                  backgroundColor: Colors.blue,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 30),
                child: FloatingActionButton.extended(
                  splashColor: Colors.black,
                  onPressed: () async {
                    await _auth.signOut();
                    await storage.delete(key: "uid");
                    Navigator.pushNamed(context, 'login');
                  },
                  heroTag: 'Logout',
                  label: const Text('     Logout     '),
                  backgroundColor: Colors.black12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL(BuildContext context) async {
    try {
      await launch(
        k,
        customTabsOption: CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          extraCustomTabs: const <String>[
            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
            'org.mozilla.firefox',
            // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
            'com.microsoft.emmx',
          ],
        ),
        safariVCOption: SafariViewControllerOption(
          preferredBarTintColor: Theme.of(context).primaryColor,
          preferredControlTintColor: Colors.white,
          barCollapsingEnabled: false,
          entersReaderIfAvailable: false,
          dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        ),
      );
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }
}
