import 'package:flutter/material.dart';
import 'package:ifriend_app/core/widgets/app_image.dart';

class OverimagesWidget extends StatelessWidget {
  const OverimagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 100,
          height: 50,
          child: Stack(
            children: List.generate(3, (index) {
              return Positioned(
                left: index * 25.0, // مقدار التداخل (كلما قل الرقم زاد التداخل)
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ), // الفاصل الأبيض
                  ),
                  child: Center(
                    child: AppImage(path: "assets/images/games.png"),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(width: 5),
        const Text(
          "+2",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
