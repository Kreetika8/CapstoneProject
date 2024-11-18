import 'package:classico/constants/app_constants.dart';
import 'package:classico/views/common/app_bar.dart';
import 'package:classico/views/common/app_style.dart';
import 'package:classico/views/common/custom_outline_btn.dart';
import 'package:classico/views/common/height_spacer.dart';
import 'package:classico/views/common/reusable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class JobPage extends StatefulWidget {
  const JobPage({super.key, required this.title, required this.id});

  final String title;
  final String id;

  @override
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: widget.title,
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: Icon(Entypo.heart_outlined),
            ),
          ],
          child: GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(CupertinoIcons.arrow_left),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.zero,
              children: [
                const HeightSpacer(size: 30),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.27,
                  color: Color(kLightGrey.value),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage("assets/images/user.png"),
                      ),
                      const HeightSpacer(size: 10),
                      ReusableText(
                        text: "Flutter Developer",
                        style:
                            appstyle(22, Color(kDark.value), FontWeight.w600),
                      ),
                      const HeightSpacer(size: 5),
                      ReusableText(
                        text: "Kathmandu",
                        style: appstyle(
                            16, Color(kDarkGrey.value), FontWeight.normal),
                      ),
                      const HeightSpacer(size: 15),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomOutlineBtn(
                                width: width * 0.26,
                                height: height * 0.04,
                                color2: Color(kLight.value),
                                text: "Full time",
                                color: Color(kOrange.value)),
                            Row(
                              children: [
                                ReusableText(
                                    text: "10k",
                                    style: appstyle(22, Color(kDark.value),
                                        FontWeight.w600)),
                                SizedBox(
                                  width: width * 0.2,
                                  child: ReusableText(
                                      text: "/monthly",
                                      style: appstyle(22, Color(kDark.value),
                                          FontWeight.w600)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const HeightSpacer(size: 20),

                // Email Section
                ReusableText(
                  text: "Email us at:",
                  style: appstyle(22, Color(kDark.value), FontWeight.w600),
                ),
                const HeightSpacer(size: 10),
                GestureDetector(
                  onTap: () async {
                    final Uri emailLaunchUri = Uri(
                      scheme: 'mailto',
                      path: 'support@classico.com',
                      query:
                          'subject=Work Inquiry&body=Hello, I am interested in the work.',
                    );
                    if (await canLaunchUrl(emailLaunchUri)) {
                      await launchUrl(emailLaunchUri);
                    } else {
                      print('Could not launch email client');
                    }
                  },
                  child: Text(
                    "support@classico.com",
                    style: appstyle(16, Color(kOrange.value), FontWeight.w600),
                  ),
                ),
                const HeightSpacer(size: 20),

                // Job Description Section
                ReusableText(
                    text: "Job Description",
                    style: appstyle(22, Color(kDark.value), FontWeight.w600)),
                const HeightSpacer(size: 10),
                Text(
                  desc,
                  textAlign: TextAlign.justify,
                  maxLines: 8,
                  style:
                      appstyle(16, Color(kDarkGrey.value), FontWeight.normal),
                ),
                const HeightSpacer(size: 30),

                // Requirements Section
                ReusableText(
                    text: "Requirements",
                    style: appstyle(22, Color(kDark.value), FontWeight.w600)),
                const HeightSpacer(size: 10),
                SizedBox(
                  height: height * 0.6,
                  child: ListView.builder(
                      itemCount: requirements.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final req = requirements[index];
                        String bullet = "\u2022";
                        return Text(
                          "$bullet $req\n",
                          maxLines: 4,
                          textAlign: TextAlign.justify,
                          style: appstyle(
                              16, Color(kDarkGrey.value), FontWeight.normal),
                        );
                      }),
                ),
                const HeightSpacer(size: 20),
              ],
            ),

            // Bottom Button
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: CustomOutlineBtn(
                  color2: Color(kOrange.value),
                  width: width,
                  height: height * 0.06,
                  text: "Connect Now",
                  color: Color(kLight.value),
                  onTap: () async {
                    final Uri emailLaunchUri = Uri(
                      scheme: 'mailto',
                      path: 'support@classico.com',
                      query:
                          'subject=Work Inquiry&body=Hello, I am interested in connecting for this work.',
                    );
                    if (await canLaunchUrl(emailLaunchUri)) {
                      await launchUrl(emailLaunchUri);
                    } else {
                      print('Could not launch email client');
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
