import 'package:flutter/material.dart';
import 'package:melodia_audioplayer/widgets/reusing_widgets.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  // Constants for reusing styles and colors
  static const _appBarBackgroundColor = Color(0xFF282C28);
  static const _appBarTitleStyle = TextStyle(
    color: Colors.white,
    fontSize: 23,
    fontWeight: FontWeight.bold,
  );
  static const _contentTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
  );
  static const _boldTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: backgroundTheme()),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: _appBarBackgroundColor,
      title: const Text(
        'PRIVACY POLICY',
        style: _appBarTitleStyle,
      ),
      centerTitle: true,
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: RichText(
          text: const TextSpan(
            style: _contentTextStyle,
            children: <TextSpan>[
              TextSpan(
                text:
                    'Meghanathan built the Melodia app as a free app. This SERVICE is provided by Meghanathan at no cost and is intended for use as is.\n\n',
              ),
              TextSpan(
                text:
                    'This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decides to use my Service.\n\n',
                style: _boldTextStyle,
              ),
              TextSpan(
                text:
                    'If you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.\n\n',
              ),
              TextSpan(
                text:
                    'The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at Melodia unless otherwise defined in this Privacy Policy.\n\n',
                style: _boldTextStyle,
              ),
              TextSpan(
                text: 'Information Collection and Use\n\n',
                style: _boldTextStyle,
              ),
              TextSpan(
                text:
                    'For a better experience while using our Service, I may require you to provide us with certain personally identifiable information. The information that I request will be retained on your device and is not collected by me in any way.\n\n',
              ),
              TextSpan(
                text: 'Log Data\n\n',
                style: _boldTextStyle,
              ),
              TextSpan(
                text:
                    'I want to inform you that whenever you use my Service, in case of an error in the app, I collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing my Service, the time and date of your use of the Service, and other statistics.\n\n',
              ),
              TextSpan(
                text: 'Cookies\n\n',
                style: _boldTextStyle,
              ),
              TextSpan(
                text:
                    'Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device\'s internal memory.\n\nThis Service does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.\n\n',
              ),
              TextSpan(
                text: 'Service Providers\n\n',
                style: _boldTextStyle,
              ),
              TextSpan(
                text:
                    'I may employ third-party companies and individuals due to the following reasons:\n- To facilitate our Service;\n- To provide the Service on our behalf;\n- To perform Service-related services; or\n- To assist us in analyzing how our Service is used.\n\nI want to inform users of this Service that these third parties have access to their Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.\n\n',
              ),
              TextSpan(
                text: 'Security\n\n',
                style: _boldTextStyle,
              ),
              TextSpan(
                text:
                    'I value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security.\n\n',
              ),
              TextSpan(
                text: 'Links to Other Sites\n\n',
                style: _boldTextStyle,
              ),
              TextSpan(
                text:
                    'This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. I have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.\n\n',
              ),
              TextSpan(
                text: 'Children’s Privacy\n\n',
                style: _boldTextStyle,
              ),
              TextSpan(
                text:
                    'I do not knowingly collect personally identifiable information from children. I encourage all children to never submit any personally identifiable information through the Application and/or Services. I encourage parents and legal guardians to monitor their children\'s Internet usage and to help enforce this Policy by instructing their children never to provide personally identifiable information through the Application and/or Services without their permission. If you have reason to believe that a child has provided personally identifiable information to us through the Application and/or Services, please contact us. You must also be at least 16 years of age to consent to the processing of your personally identifiable information in your country (in some countries we may allow your parent or guardian to do so on your behalf).\n\n',
              ),
              TextSpan(
                text: 'Changes to This Privacy Policy\n\n',
                style: _boldTextStyle,
              ),
              TextSpan(
                text:
                    'I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page.\n\nThis policy is effective as of 2024-07-03.\n\n',
              ),
              TextSpan(
                text: 'Contact Us\n\n',
                style: _boldTextStyle,
              ),
              TextSpan(
                text:
                    'If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at meghanathanph1@gmail.com\n\n',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
