import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/notification_entity.dart';

class NotificationItem extends StatelessWidget {
  final NotificationEntity notification;
  final VoidCallback onTap;

  const NotificationItem({
    Key? key,
    required this.notification,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: notification.isRead ? Colors.white : const Color(0xFFF0F9FF), // Light blue for unread
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xFFEAEAEA),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildIcon(),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Expanded(
                         child: Text(
                           notification.title,
                           style: TextStyle(
                             fontSize: 14.sp,
                             fontWeight: FontWeight.bold,
                             color: const Color(0xFF1D2939),
                           ),
                         ),
                       ),
                       Text(
                         _formatTime(notification.createdAt),
                         style: TextStyle(
                           fontSize: 12.sp,
                           color: const Color(0xFF98A2B3),
                         ),
                       ),
                     ],
                   ),
                   SizedBox(height: 4.h),
                   Text(
                     notification.message,
                     style: TextStyle(
                       fontSize: 12.sp,
                       color: const Color(0xFF667085),
                       height: 1.5,
                     ),
                   ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    IconData iconData;
    Color color;
    Color bgColor;

    switch (notification.type) {
      case 'LESSON_COMPLETED':
        iconData = Icons.notifications_none_rounded;
        color = const Color(0xFF2E90FA);
        bgColor = const Color(0xFFEFF8FF);
        break;
      case 'DEVICE_LINKED':
        iconData = Icons.phone_android_rounded;
        color = const Color(0xFF2E90FA);
        bgColor = const Color(0xFFEFF8FF);
        break;
      case 'SAFE_ZONE':
        iconData = Icons.location_on_outlined;
        color = const Color(0xFFF04438);
        bgColor = const Color(0xFFFEF3F2);
        break;
      case 'SCREEN_TIME':
        iconData = Icons.access_time_rounded;
        color = const Color(0xFF2E90FA);
        bgColor = const Color(0xFFEFF8FF);
        break;
      case 'REPORT':
        iconData = Icons.bar_chart_rounded;
        color = const Color(0xFFF79009);
        bgColor = const Color(0xFFFFFAEB);
        break;
      case 'SUBSCRIPTION':
        iconData = Icons.monetization_on_outlined;
        color = const Color(0xFF2E90FA);
        bgColor = const Color(0xFFEFF8FF);
        break;
      default:
        iconData = Icons.notifications_none_rounded;
        color = const Color(0xFF667085);
        bgColor = const Color(0xFFF2F4F7);
    }

    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          iconData,
          color: color,
          size: 20.sp,
        ),
      ),
    );
  }

  String _formatTime(String dateTimeStr) {
    try {
      final dt = DateTime.parse(dateTimeStr).toLocal();
      return DateFormat('h:mm a').format(dt);
    } catch (_) {
      return '';
    }
  }
}
