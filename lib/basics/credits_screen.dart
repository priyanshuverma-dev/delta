import 'dart:ui';

import 'package:answer_it/core/toaster.dart';
import 'package:answer_it/utils/colors.dart';
import 'package:answer_it/utils/global_vars.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class CreditsScreen extends StatelessWidget {
  CreditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Colours.darkScaffoldColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colours.textColor,
          ),
        ),
        title: Text(
          'Credits',
          style: TextStyle(
            color: Colours.textColor,
          ),
        ),
      ),
      backgroundColor: Colours.darkScaffoldColor.withOpacity(0.5),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Globals.bg1),
            fit: BoxFit.fill,
          ),
        ),
        width: Get.width,
        height: Get.height,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 15,
            sigmaY: 15,
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Colors.white24,
                  Colors.white10,
                ],
              ),
              color: Colours.primarySwatch.withOpacity(0.5),
            ),
            child: Column(
              children: [
                SizedBox(height: 30),
                Text(
                  'Developed by Priyanshu Verma.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colours.textColor,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Share This Application With Friends...',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colours.textColor.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white12,
                        Colors.white10,
                      ],
                    ),
                    color: Colours.textColor.withOpacity(0.5),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0),
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(118, 118, 118, 0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0,
                      ),
                    ],
                  ),
                  height: 400,
                  width: Get.width - 20,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CircleAvatar(
                          radius: 34,
                          backgroundColor: Colours.darkScaffoldColor,
                          child: Hero(
                            tag: 'ico',
                            child: CircleAvatar(
                              radius: 32,
                              backgroundImage: AssetImage(Globals.ico),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        '@priyanshu.code'.toUpperCase(),
                        style: TextStyle(
                          color: Colours.textColor.withOpacity(0.7),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildSocialIcon(
                            icon: FontAwesomeIcons.youtube,
                            onPressed: () => _launchURLBrowser(
                              'https://www.youtube.com/@priyanshu.coding',
                            ),
                          ),
                          buildSocialIcon(
                            icon: FontAwesomeIcons.github,
                            onPressed: () => _launchURLBrowser(
                              'https://github.com/priyanshu-creator/',
                            ),
                          ),
                          buildSocialIcon(
                            icon: FontAwesomeIcons.instagram,
                            onPressed: () => _launchURLBrowser(
                              'https://www.instagram.com/priyanshu.code/',
                            ),
                          ),
                          buildSocialIcon(
                            icon: FontAwesomeIcons.poop,
                            onPressed: () => _launchURLBrowser(
                              'https://somveers.me/',
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          '🔭 I’m tech enthusiast who is curious new technology, new frameworks and more...',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colours.textColor.withOpacity(0.7),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 15),
                OutlinedButton(
                  onPressed: () {
                    Share.share(
                      'check out all new app solves all questions answer with the help of AI. https://github.com/priyanshu-creator/answer-it/releases',
                      subject: 'New Ai App',
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    fixedSize: Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    side: BorderSide(
                      color: Colours.textColor.withOpacity(0.5),
                      width: 1,
                    ),
                    backgroundColor: Colours.darkScaffoldColor.withOpacity(0.7),
                  ),
                  child: Text(
                    'Share',
                    style: TextStyle(color: Colours.textColor.withOpacity(0.7)),
                  ),
                ),
                Spacer(),
                Text(
                  '..app is in development..',
                  style: TextStyle(
                    fontFamily: 'header',
                    fontSize: 15,
                    color: Colours.textColor.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _launchURLBrowser(url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      toast('Can.t load the url !', Colours.textColor, 18);
    }
  }
}

Widget buildSocialIcon({
  required VoidCallback onPressed,
  required IconData icon,
  Color? color,
}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: color ?? Colours.textColor.withOpacity(0.7),
        ),
      ),
    ),
  );
}
