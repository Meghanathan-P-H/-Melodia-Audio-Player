import 'package:flutter/material.dart';

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
                  onTap: () {},
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
