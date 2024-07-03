import 'package:flutter/material.dart';
import 'package:melodia_audioplayer/Screens/about_screen.dart';
// import 'package:melodia_audioplayer/Screens/audiorecording_screen.dart';
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
          _buildAppBar(context),
          _buildHeader(),
          // _buildMenuItem(
          //   icon: Icons.mic_rounded,
          //   title: 'AUDIO RECORDER',
          //   onTap: () => _navigateTo(context, const ScreenAudioRecord()),
          // ),
          const SizedBox(height: 15),
          const Center(
            child: Text(
              'SETTINGS',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                
              ),
            ),
          ),
          const SizedBox(height: 15),
          _buildMenuItem(
            icon: Icons.auto_stories_outlined,
            title: 'ABOUT US',
            onTap: () => _navigateTo(context, const AboutScreen()),
          ),
          const SizedBox(height: 19),
          _buildMenuItem(
            icon: Icons.privacy_tip_outlined,
            title: 'PRIVACY POLICY',
            onTap: () => _navigateTo(context, const PrivacyPolicyScreen()),
          ),
          const SizedBox(height: 15),
          _buildMenuItem(
            icon: Icons.info_outline,
            title: 'TERMS & CONDITION',
            onTap: () => _navigateTo(context, const TermsAndConditionScreen()),
          ),
          const SizedBox(height: 15),
          _buildMenuItem(
            icon: Icons.star_border,
            title: 'RATE US',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
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
    );
  }

  Widget _buildHeader() {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            width: 120,
            height: 105,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 50,
              child: Image.asset(
                'asset/images/MelodiaLogo.png',
                fit: BoxFit.cover,
                height: 70,
              ),
            ),
          ),
          Image.asset(
            'asset/images/MelodiafontLogo.png',
            height: 70,
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
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
                child: Icon(
                  icon,
                  size: 35,
                ),
              ),
            ),
          ),
        ],
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      onTap: onTap,
    );
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => screen,
    ));
  }
}
