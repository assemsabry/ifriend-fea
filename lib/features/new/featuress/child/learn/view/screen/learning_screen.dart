import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ifriend_app/core/widgets/def_appbar.dart';
import 'package:ifriend_app/features/new/featuress/child/games/ghome/view/widget/games_type_card.dart';
import 'package:ifriend_app/features/new/featuress/child/learn/view/screen/letters_screen.dart';
import 'package:ifriend_app/features/new/featuress/child/learn/view/screen/numbers_screen.dart';

class LearningScreen extends StatelessWidget {
  const LearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: DefAppbar(
        title: "Learning",
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
                title: "Numbers",
                imagePath: "number.png",
                containerColor: Color(0xFF4AA6C6),
                color: Color(0xFF81DDFD),
                onTap: () {
                  Get.to(() => NumbersScreen());
                },
              ),
              GamesTypeCard(
                title: "Letters",
                imagePath: "letters.png",

                containerColor: Color(0xFF531F8B),
                textColor: Color(0xFF7A46B2),
                onTap: () {
                  Get.to(() => LettersScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
