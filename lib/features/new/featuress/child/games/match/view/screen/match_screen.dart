import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ifriend_app/features/new/featuress/child/games/match/controller/mach_cubit.dart';
import 'package:ifriend_app/features/new/featuress/child/games/match/controller/match_state.dart';

class MatchScreen extends StatelessWidget {
  const MatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MatchCubit()..setupLevel(),
      child: BlocBuilder<MatchCubit, MatchState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(title: Text("Choose out and match")),
            body: Column(
              children: [
                // 1. شبكة المربعات الملونة (الأهداف)
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.all(15),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: state.colorNames.length,
                    itemBuilder: (context, index) {
                      String colorName = state.colorNames[index];
                      bool isMatched = state.matches.containsKey(colorName);

                      return DragTarget<String>(
                        onAcceptWithDetails: (data) => context
                            .read<MatchCubit>()
                            .matchColor(colorName, data.data),
                        builder: (context, candidateData, rejectedData) {
                          return Container(
                            decoration: BoxDecoration(
                              color: context
                                  .read<MatchCubit>()
                                  .colorData[colorName],
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              isMatched ? "✅" : colorName,
                              style: TextStyle(
                                color:
                                    colorName == "white" ||
                                        colorName == "yellow"
                                    ? Colors.black
                                    : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

                // 2. منطقة التفاحات (العناصر القابلة للسحب)
                Container(
                  padding: EdgeInsets.all(20),
                  child: Wrap(
                    spacing: 15,
                    runSpacing: 15,
                    children: state.shuffledApples.map((appleColor) {
                      // إذا تم مطابقة هذه التفاحة، لا تظهرها هنا
                      if (state.matches.containsKey(appleColor)) {
                        return SizedBox.shrink();
                      }

                      return Draggable<String>(
                        data: appleColor,
                        feedback: AppleWidget(
                          colorName: appleColor,
                          isDragging: true,
                        ),
                        childWhenDragging: Opacity(
                          opacity: 0.3,
                          child: AppleWidget(colorName: appleColor),
                        ),
                        child: AppleWidget(colorName: appleColor),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ويدجت التفاحة الملونة
class AppleWidget extends StatelessWidget {
  final String colorName;
  final bool isDragging;
  const AppleWidget({
    super.key,
    required this.colorName,
    this.isDragging = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color appleColor = context.read<MatchCubit>().getColorFromName(
      colorName,
    );
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
          style: BorderStyle.solid,
        ), // هنا البوردر المقطع dashed كما في الصورة
        borderRadius: BorderRadius.circular(10),
      ),
      child: SvgPicture.asset(
        "assets/svg/apple.svg",
        width: 40,
        color: appleColor, // دالة لتحويل الاسم إلى لون
      ),
    );
  }
}
