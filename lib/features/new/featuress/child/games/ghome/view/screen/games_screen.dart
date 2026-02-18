import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ifriend_app/core/widgets/def_appbar.dart';
import 'package:ifriend_app/features/new/featuress/child/games/all/view/screen/gamestask_screen.dart';
import 'package:ifriend_app/features/new/featuress/child/games/ghome/view/widget/games_type_card.dart';
import 'package:ifriend_app/features/new/featuress/child/games/hmany/view/screen/howmany_screen.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: DefAppbar(
        title: "Games",
        textColor: Colors.white,
        backIcon: true,
        color: Colors.transparent,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
              Color(0xCC1C0D38).withOpacity(0.8),
              BlendMode.srcATop,
            ),
            image: AssetImage("assets/images/gamesbg.png"),
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 20.h,
            crossAxisSpacing: 15.w,
            childAspectRatio: 0.68,
            children: [
              GamesTypeCard(
                title: "Picture",
                imagePath: "count.png",
                containerColor: Color(0xFF53A6C8),
                color: Color(0xFF5ABED2),
                onTap: () {
                  Get.to(() => GamestaskScreen());
                },
              ),
              GamesTypeCard(
                title: "Cut & Match",
                imagePath: "frute.png",

                containerColor: Color(0xFFC7C5D8),
                textColor: Color(0xFF868497),
                onTap: () {
                  //    Get.to(() => MatchScreen());
                },
              ),
              GamesTypeCard(
                title: "How Many",
                imagePath: "frute.png",
                onTap: () {
                  Get.to(() => HowManyScreen());
                },

                containerColor: Color(0xFF0093D3),
                color: Color(0xFF00BDFD),
              ),
              GamesTypeCard(
                title: "Draw a line ",
                imagePath: "shape.png",

                containerColor: Color(0xFF06A46B),
                color: Color(0xFF36D49B),
              ),

              // GameCard(
              //   title: "Picture",
              //   level: "Lv.2",
              //   progress: 0.4,
              //   coins: "5",
              //   color: Color(0xFF5ABED2),
              //   imagePath: "assets/images/images.png",
              // ),
              // GameCard(
              //   title: "Cut & Match",
              //   level: "Lv.4",
              //   progress: 0.7,
              //   coins: "5",
              //   color: Color(0xFFD1CBE6),
              //   imagePath: "assets/images/frute.png",
              // ),
              // GameCard(
              //   title: "How Many",
              //   level: "Lv.6",
              //   progress: 0.8,
              //   coins: "5",
              //   color: Color(0xFF00AEEF),
              //   imagePath: "assets/images/shape.png",
              // ),
              // GameCard(
              //   title: "Draw a line",
              //   level: "Lv.1",
              //   progress: 0.1,
              //   coins: "5",
              //   color: Color(0xFF27AE60),
              //   imagePath: "assets/images/count.png",
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
