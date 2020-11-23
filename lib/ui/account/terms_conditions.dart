/*
This is terms and conditions page

install plugin in pubspec.yaml
- flutter_html => to show toast (https://pub.dev/packages/flutter_html)

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';

class TermsConditionsPage extends StatefulWidget {
  @override
  _TermsConditionsPageState createState() => _TermsConditionsPageState();
}

class _TermsConditionsPageState extends State<TermsConditionsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0,
          title: Text(
            AppLocalizations.of(context).translate('terms_conditions'),
            style: GlobalStyle.appBarTitle,
          ),
          backgroundColor: Colors.white,
          bottom: PreferredSize(
              child: Container(
                color: Colors.grey[100],
                height: 1.0,
              ),
              preferredSize: Size.fromHeight(1.0)),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(8),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
            child: Html(
              data: """
              
              <p><h2>Installmental Policy</h2></p>
              <p><h3>Introduction</h3></p>
              <p>This app is operated by MainMart. The terms "we", "us", and "our" refer to MainMart. The use of our app is subject to the following terms and conditions of use, as amended from time to time (the "Terms"). The Terms are to be read together by you with any terms, conditions or disclaimers provided in the pages of our app. Please review the Terms carefully. The Terms apply to all users of our app, including without limitation, users who are browsers, customers, merchants, vendors and/or contributors of content. If you access and use this app, you accept and agree to be bound by and comply with the Terms and our Privacy Policy. If you do not agree to the Terms or our Privacy Policy, you are not authorized to access our app, use any of our app’s services or place an order on our app.</p>
              <p><h3>Use of Our App</h3></p>
              <p>You agree to use our app for legitimate purposes and not for any illegal or unauthorized purpose, including without limitation, in violation of any intellectual property or privacy law. By agreeing to the Terms, you represent and warrant that you are at least the age of majority in your state or province of residence and are legally capable of entering into a binding contract. You agree to not use our app to conduct any activity that would constitute a civil or criminal offence or violate any law. You agree not to attempt to interfere with our app’s network or security features or to gain unauthorized access to our systems. You agree to provide us with accurate personal information, such as your email address, mailing address and other contact details in order to complete your order or contact you as needed. You agree to promptly update your account and information. You authorize us to collect and use this information to contact you in accordance with our Privacy Policy.</p>
              <p><h3>General Conditions</h3></p>
              <p>We reserve the right to refuse service to anyone, at any time, for any reason. We reserve the right to make any modifications to the app, including terminating, changing, suspending or discontinuing any aspect of the app at any time, without notice. We may impose additional rules or limits on the use of our app. You agree to review the Terms regularly and your continued access or use of our app will mean that you agree to any changes. You agree that we will not be liable to you or any third party for any modification, suspension or discontinuance of our app or for any service, content, feature or product offered through our app.</p>
              <p><h3>Products or Services</h3></p>
              <p>All purchases through our app are subject to product availability. We may, in our sole discretion, limit or cancel the quantities offered on our app or limit the sales of our products or services to any person, household, geographic region or jurisdiction. Prices for our products are subject to change, without notice. Unless otherwise indicated, prices displayed on our app are quoted in Naira. We reserve the right, in our sole discretion, to refuse orders, including without limitation, orders that appear to be placed by distributors or resellers. If we believe that you have made a false or fraudulent order, we will be entitled to cancel the order and inform the relevant authorities. We do not guarantee the accuracy of the colour or design of the products on our app. We have made efforts to ensure the colour and design of our products are displayed as accurately as possible on our app.</p>
              <p><h3>Links to Third-Party apps</h3></p>
              <p>Links from or to apps outside our app are meant for convenience only. We do not review, endorse, approve or control, and are not responsible for any sites linked from or to our app, the content of those sites, the third parties named therein, or their products and services. Linking to any other site is at your sole risk and we will not be responsible or liable for any damages in connection with linking. Links to downloadable software sites are for convenience only and we are not responsible or liable for any difficulties or consequences associated with downloading the software. Use of any downloaded software is governed by the terms of the license agreement, if any, which accompanies or is provided with the software.</p>
              <p><h3>Use Comments, Feedback, and Other Submissions</h3></p>
              <p>You acknowledge that you are responsible for the information, profiles, opinions, messages, comments and any other content (collectively, the “Content”) that you post, distribute or share on or through our app or services available in connection with our app. You further acknowledge that you have full responsibility for the Content, including but limited to, with respect to its legality, and its trademark, copyright and other intellectual property ownership. You agree that any Content submitted by you in response to a request by us for a specific submission may be edited, adapted, modified, recreated, published, or distributed by us. You further agree that we are under no obligation to maintain any Content in confidence, to pay compensation for any Content or to respond to any Content. You agree that you will not post, distribute or share any Content on our app that is protected by copyright, trademark, patent or any other proprietary right without the express consent of the owner of such proprietary right. You further agree that your Content will not be unlawful, abusive or obscene nor will it contain any malware or computer virus that could affect our app’s operations. You will be solely liable for any Content that you make and its accuracy. We have no responsibility and assume no liability for any Content posted by you or any third-party. We reserve the right to terminate your ability to post on our app and to remove and/or delete any Content that we deem objectionable. You consent to such removal and/or deletion and waive any claim against us for the removal and/or deletion of your Content.</p>
              <p><h3>Your Personal Information</h3></p>
              <p>Please see our Privacy Policy to learn about how we collect, use, and share your personal information</p>
              <p><h3>Errors and Omissions</h3></p>
              <p>Please note that our app may contain typographical errors or inaccuracies and may not be complete or current. We reserve the right to correct any errors, inaccuracies or omissions and to change or update information at any time, without prior notice (including after an order has been submitted). Such errors, inaccuracies or omissions may relate to product description, pricing, promotion and availability and we reserve the right to cancel or refuse any order placed based on incorrect pricing or availability information, to the extent permitted by applicable law. We do not undertake to update, modify or clarify information on our app, except as required by law</p>
              <p><h3>Disclaimer and Limitation of Liability</h3></p>
              <p>You assume all responsibility and risk with respect to your use of our app, which is provided “as is” without warranties, representations or conditions of any kind, either express or implied, with regard to information accessed from or via our app, including without limitation, all content and materials, and functions and services provided on our app, all of which are provided without warranty of any kind, including but not limited to warranties concerning the availability, accuracy, completeness or usefulness of content or information, uninterrupted access, and any warranties of title, non-infringement, merchantability or fitness for a particular purpose. We do not warrant that our app or its functioning or the content and material of the services made available thereby will be timely, secure, uninterrupted or error-free, that defects will be corrected, or that our apps or the servers that make our app available are free of viruses or other harmful components. The use of our app is at your sole risk and you assume full responsibility for any costs associated with your use of our app. We will not be liable for any damages of any kind related to the use of our app. In no event will we, or our affiliates, our or their respective content or service providers, or any of our or their respective directors, officers, agents, contractors, suppliers or employees be liable to you for any direct, indirect, special, incidental, consequential, exemplary or punitive damages, losses or causes of action, or lost revenue, lost profits, lost business or sales, or any other type of damage, whether based in contract or tort (including negligence), strict liability or otherwise, arising from your use of, or the inability to use, or the performance of, our app or the content or material or functionality through our app, even if we are advised of the possibility of such damages. Certain jurisdictions do not allow limitation of liability or the exclusion or limitation of certain damages. In such jurisdictions, some or all of the above disclaimers, exclusions, or limitations, may not apply to you and our liability will be limited to the maximum extent permitted by law.</p>
              <p><h3>Indemnification</h3></p>
              <p>You agree to defend and indemnify us, and hold us and our affiliates harmless,, and our and their respective directors, officers, agents, contractors, and employees against any losses, liabilities, claims, expenses (including legal fees) in any way arising from, related to or in connection with your use of our app, your violation of the Terms, or the posting or transmission of any materials on or through the app by you, including but not limited to, any third party claim that any information or materials provided by you infringe upon any third party proprietary rights.</p>
              <p><h3>Entire Agreement</h3></p>
              <p>The Terms and any documents expressly referred to in them represent the entire agreement between you and us in relation to the subject matter of the Terms and supersede any prior agreement, understanding or arrangement between you and us, whether oral or in writing. Both you and we acknowledge that, in entering into these Terms, neither you nor we have relied on any representation, undertaking or promise given by the other or implied from anything said or written between you and us prior to such Terms, except as expressly stated in the Terms.</p>
              <p><h3>Waiver</h3></p>
              <p>Our failure to exercise or enforce any right or provision of the Terms will not constitute a waiver of such right or provision. A waiver by us of any default will not constitute a waiver of any subsequent default. No waiver by us is effective unless it is communicated to you in writing.</p>
              <p><h3>Headings</h3></p>
              <p>Any headings and titles herein are for convenience only.</p>
              <p><h3>Severability</h3></p>
              <p>Any headings and titles herein are for convenience only.</p>
              <p><h3>Governing Law</h3></p>
              <p>Any disputes arising out of or relating to the Terms, the Privacy Policy, use of our app, or our products or services offered on our app will be resolved in accordance with the laws of The Federal Republic of Nigeria. The place of jurisdiction shall be exclusively in Lagos, Nigeria.</p>
              <p><h3>Questions or Concerns</h3></p>
              <p>Please send all questions, comments and feedback to us at Support@mainmart.com.ng.</p>
              
              
              """,
              style: {
                "p": Style(
                  fontSize: FontSize(12),
                  color: CHARCOAL,
                ),
              },
            ),
          ),
        ));
  }
}
