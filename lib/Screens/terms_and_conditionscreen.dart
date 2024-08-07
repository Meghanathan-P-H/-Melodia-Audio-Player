import 'package:flutter/material.dart';
import 'package:melodia_audioplayer/widgets/reusing_widgets.dart';

class TermsAndConditionScreen extends StatefulWidget {
  const TermsAndConditionScreen({super.key});

  @override
  State<TermsAndConditionScreen> createState() => _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
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
        'TERMS & CONDITIONS',
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
                    'By downloading or using the app, these terms will automatically apply to you – you should make sure therefore that you read them carefully before using the app. You are not allowed to copy or modify the app, any part of the app, or our trademarks in any way. You are not allowed to attempt to extract the source code of the app, and you also should not try to translate the app into other languages or make derivative versions. The app itself, and all the trademarks, copyright, database rights, and other intellectual property rights related to it, still belong to Meghanathan.\n\n',
              ),
              TextSpan(
                text: 'Meghanathan is committed to ensuring that the app is as useful and efficient as possible. For that reason, we reserve the right to make changes to the app or to charge for its services, at any time and for any reason. We will never charge you for the app or its services without making it very clear to you exactly what you are paying for.\n\n',
              ),
              TextSpan(
                text:
                    'The Melodia app stores and processes personal data that you have provided to us to provide our Service. It is your responsibility to keep your phone and access to the app secure. We therefore recommend that you do not jailbreak or root your phone, which is the process of removing software restrictions and limitations imposed by the official operating system of your device. It could make your phone vulnerable to malware, viruses, or malicious programs, compromise your phone’s security features, and it could mean that the Melodia app won’t work properly or at all.\n\n',
              ),
              TextSpan(
                text: 'You should be aware that there are certain things that Meghanathan will not take responsibility for. Certain functions of the app will require the app to have an active internet connection. The connection can be Wi-Fi or provided by your mobile network provider, but Meghanathan cannot take responsibility for the app not working at full functionality if you don’t have access to Wi-Fi, and you don’t have any of your data allowance left.\n\n',
              ),
              TextSpan(
                text:
                    'If you are using the app outside of an area with Wi-Fi, you should remember that the terms of the agreement with your mobile network provider will still apply. As a result, you may be charged by your mobile provider for the cost of data for the duration of the connection while accessing the app, or other third-party charges. By using the app, you are accepting responsibility for any such charges, including roaming data charges if you use the app outside of your home territory (i.e. region or country) without turning off data roaming. If you are not the bill payer for the device on which you are using the app, please be aware that we assume that you have received permission from the bill payer for using the app.\n\n',
              ),
              TextSpan(
                text: 'Along the same lines, Meghanathan cannot always take responsibility for the way you use the app, i.e., You need to make sure that your device stays charged – if it runs out of battery and you can’t turn it on to avail the Service, Meghanathan cannot accept responsibility.\n\n',
              ),
              TextSpan(
                text:
                    'With respect to Meghanathan’s responsibility for your use of the app, when you are using the app, it’s important to bear in mind that although we endeavor to ensure that it is updated and correct at all times, we do rely on third parties to provide information to us so that we can make it available to you. Meghanathan accepts no liability for any loss, direct or indirect, you experience as a result of relying wholly on this functionality of the app.\n\n',
              ),
              TextSpan(
                text: 'At some point, we may wish to update the app. The app is currently available on Android – the requirements for the system (and for any additional systems we decide to extend the availability of the app to) may change, and you will need to download the updates if you want to keep using the app. Meghanathan does not promise that it will always update the app so that it is relevant to you and/or works with the Android version that you have installed on your device. However, you promise to always accept updates to the application when offered to you. We may also wish to stop providing the app, and may terminate use of it at any time without giving notice of termination to you. Unless we tell you otherwise, upon any termination, (a) the rights and licenses granted to you in these terms will end; (b) you must stop using the app, and (if needed) delete it from your device.\n\n',
                style: _boldTextStyle,
              ),
              TextSpan(
                text: 'Changes to This Terms and Conditions\n\n',
                style: _boldTextStyle,
              ),
              TextSpan(
                text:
                    'I may update our Terms and Conditions from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Terms and Conditions on this page.\n\nThese terms and conditions are effective as of 2024-07-03.\n\n',
              ),
              TextSpan(
                text: 'Contact Us\n\n',
                style: _boldTextStyle,
              ),
              TextSpan(
                text:
                    'If you have any questions or suggestions about my Terms and Conditions, do not hesitate to contact me at meghanathanph1@gmail.com.\n\n',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
