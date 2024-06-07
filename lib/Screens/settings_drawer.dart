import 'package:flutter/material.dart';
import 'package:melodia_audioplayer/Screens/about_screen.dart';
import 'package:melodia_audioplayer/Screens/audiorecording_screen.dart';
import 'package:melodia_audioplayer/Screens/privacy_policy.dart';
import 'package:melodia_audioplayer/Screens/terms_and_conditionscreen.dart';

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF393939),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 50,
                    child: Image.asset('asset/images/MelodiaLogo.png',
                        fit: BoxFit.cover, height: 80),
                  ),
                ),
                Image.asset(
                  'asset/images/MelodiafontLogo.png',
                  height: 70,
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        padding: const EdgeInsets.all(7.0),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints.tightFor(
                                height: 35, width: 35),
                            child: const Icon(
                              Icons.mic_rounded,
                              size: 35,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  title: const Text(
                    'AUDIO RECORDER',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ScreenAudioRecord()));
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'SETTINGS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.all(9.0),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints.tightFor(
                              height: 34,
                              width: 35,
                            ),
                            child: const Icon(
                              Icons.auto_stories_outlined,
                              size: 35,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  title: const Text(
                    'ABOUT US',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AboutScreen()));
                  },
                ),
                const SizedBox(
                  height: 19,
                ),
                ListTile(
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.all(9.0),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints.tightFor(
                              height: 34,
                              width: 35,
                            ),
                            child: const Icon(
                              Icons.privacy_tip_outlined,
                              size: 35,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  title: const Text(
                    'PRIVACY POLICY',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const PrivacyPolicyScreen()));
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.all(9.0),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints.tightFor(
                              height: 34,
                              width: 35,
                            ),
                            child: const Icon(
                              Icons.info_outline,
                              size: 35,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  title: const Text(
                    'TERMS & CONDITION',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const TermsAndConditionScreen()));
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.all(9.0),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints.tightFor(
                              height: 34,
                              width: 35,
                            ),
                            child: const Icon(
                              Icons.star_border,
                              size: 35,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  title: const Text(
                    'RATE US',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
