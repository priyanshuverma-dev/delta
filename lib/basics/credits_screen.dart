import 'package:delta/utils/colors.dart';
import 'package:delta/utils/global_vars.dart';
import 'package:delta/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class CreditsScreen extends StatelessWidget {
  static route() => MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => const CreditsScreen(),
      );
  const CreditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colours.darkScaffoldColor,
        title: Text(
          'Credits',
          style: TextStyle(
            color: Colours.textColor,
          ),
        ),
      ),
      backgroundColor: Colours.darkScaffoldColor.withOpacity(0.5),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Text(
            'Made by ❤ by Priyanshu.',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colours.textColor,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'Share This Application With Friends...',
            style: TextStyle(
              fontSize: 14,
              color: Colours.textColor.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 15),
          Column(
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
                'Delta'.toUpperCase(),
                style: TextStyle(
                  color: Colours.textColor.withOpacity(0.7),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildSocialIcon(
                    icon: Icons.deblur_outlined,
                    onPressed: () async {
                      Uri url = Uri.parse('https://github.com/codebyps/');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      } else {
                        if (context.mounted) {
                          showSnackBar(context, 'Can.t load the url !');
                        }
                      }
                    },
                  ),
                  buildSocialIcon(
                    icon: Icons.style_outlined,
                    onPressed: () async {
                      Uri url =
                          Uri.parse('https://www.youtube.com/@antrikshdevs');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      } else {
                        if (context.mounted) {
                          showSnackBar(context, 'Can.t load the url !');
                        }
                      }
                    },
                  ),
                  buildSocialIcon(
                    icon: Icons.web_stories_outlined,
                    onPressed: () async {
                      Uri url = Uri.parse('https://antrikshdev.tech');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      } else {
                        if (context.mounted) {
                          showSnackBar(context, 'Can.t load the url !');
                        }
                      }
                    },
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
          const SizedBox(height: 15),
          OutlinedButton(
            onPressed: () {
              Share.share(
                'check out all new app solves all questions answer with the help of AI. https://github.com/codebyps/delta/releases',
                subject: 'Delta App',
              );
            },
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              maximumSize: const Size(100, 80),
              side: const BorderSide(
                width: 0,
              ),
              backgroundColor: Colours.darkScaffoldColor.withOpacity(0.7),
            ),
            child: Text(
              'Share',
              style: TextStyle(color: Colours.textColor.withOpacity(0.7)),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildSocialIcon({
  required VoidCallback onPressed,
  required IconData icon,
  Color? color,
}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: color ?? Colours.textColor.withOpacity(0.7),
      ),
    ),
  );
}
