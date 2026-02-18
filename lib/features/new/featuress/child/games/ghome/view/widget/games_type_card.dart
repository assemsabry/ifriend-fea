import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GamesTypeCard extends StatelessWidget {
  final String title, imagePath;
  final Color? color, textColor, containerColor;
  final void Function()? onTap;
  const GamesTypeCard({
    super.key,
    required this.title,
    this.color,
    this.containerColor,
    this.textColor,
    required this.imagePath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: EdgeInsets.only(top: 40.h),
          width: double.infinity,
          decoration: BoxDecoration(
            color: color ?? Color(0xFFEEECFF),
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(12.w, 90.h, 12.w, 12.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: textColor ?? Colors.white,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Baloo2",
                        fontSize: 20.sp,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.monetization_on,
                          color: Colors.orange,
                          size: 16.sp,
                        ),
                        Text(
                          " 5",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Row(
                  spacing: 3.w,
                  children: [
                    Text(
                      'Lv.2',
                      style: TextStyle(
                        color: textColor ?? Colors.white.withOpacity(0.9),
                        fontSize: 14.sp,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 17.h,
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: LinearProgressIndicator(
                            borderRadius: BorderRadius.circular(15.r),
                            value: 40 / 100,
                            backgroundColor: Colors.white,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              color ?? const Color(0xFF868497),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),

        Positioned(
          top: 0,
          child: Container(
            height: 120.h,
            width: 125.w,
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Image.asset(
                "assets/images/$imagePath",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 20.h,
          child: InkWell(
            onTap: onTap,
            child: Container(
              width: 150.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: Center(
                child: Text(
                  "Play",
                  style: TextStyle(
                    color: color ?? Color(0xFF868497),
                    fontWeight: FontWeight.w900,
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
