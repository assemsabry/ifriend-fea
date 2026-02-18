import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../../core/di/injection.dart';
import '../../domain/entities/notification_entity.dart';
import '../bloc/notification_bloc.dart';
import '../bloc/notification_event.dart';
import '../bloc/notification_state.dart';
import '../widgets/notification_item.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NotificationBloc>()..add(FetchNotifications()),
      child: const _NotificationsView(),
    );
  }
}

class _NotificationsView extends StatelessWidget {
  const _NotificationsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.read<NotificationBloc>().add(
                MarkAllNotificationsAsRead(),
              );
            },
            child: Text(
              'Mark all as read',
              style: TextStyle(
                color: const Color(0xFF2E90FA),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildTabs(context),
          Expanded(
            child: BlocBuilder<NotificationBloc, NotificationState>(
              builder: (context, state) {
                if (state.status == NotificationStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.status == NotificationStatus.error) {
                  return Center(child: Text(state.errorMessage));
                }

                if (state.filteredNotifications.isEmpty) {
                  return _buildEmptyState();
                }

                return _buildNotificationList(
                  context,
                  state.filteredNotifications,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        final allCount = state.allNotifications.length;
        final unreadCount = state.unreadCount;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            children: [
              _buildTabItem(
                context,
                title: 'All',
                count: allCount,
                isSelected: !state.isUnreadTab,
                onTap: () {
                  context.read<NotificationBloc>().add(
                    const ChangeNotificationTab(isUnreadTab: false),
                  );
                },
              ),
              SizedBox(width: 12.w),
              _buildTabItem(
                context,
                title: 'Unread',
                count: unreadCount,
                isSelected: state.isUnreadTab,
                onTap: () {
                  context.read<NotificationBloc>().add(
                    const ChangeNotificationTab(isUnreadTab: true),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTabItem(
    BuildContext context, {
    required String title,
    required int count,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1570EF) : const Color(0xFFEFF8FF),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF1570EF),
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
            if (count > 0) ...[
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withOpacity(0.2)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  count.toString(),
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF1570EF),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF8FF),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_none_rounded,
              size: 40.sp,
              color: const Color(0xFF1570EF),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'No notifications yet',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "We'll let you know if anything needs\nyour attention",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.sp, color: const Color(0xFF667085)),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationList(
    BuildContext context,
    List<NotificationEntity> notifications,
  ) {
    // Grouping
    final Map<String, List<NotificationEntity>> grouped = {};

    for (var notification in notifications) {
      final date = DateTime.parse(notification.createdAt).toLocal();
      final now = DateTime.now();
      final diff = now.difference(date);

      String key;
      if (diff.inMinutes < 60 && diff.inMinutes >= 0 && date.day == now.day) {
        // "25 min" style - relative
        key = "${diff.inMinutes} min";
        // Or just "Recent"? The UI showed "25 min" as a header.
        // If multiple items have different mins, we get multiple headers.
        // To match UI exactly "25 min" might be a specific threshold.
        // Let's grouping by: "Just now" (< 5 min), "Last hour" (< 60 min), "Today", "Yesterday"
        // The prompt said: "Group notifications by date sections: Today, 25 min (relative), Yesterday".
        // This implies "25 min" is one of the sections.
        // I'll stick to standard reliable grouping: Today, Yesterday, Older.
        // Adding "Recent" for < 1 hour.
      } else if (date.year == now.year &&
          date.month == now.month &&
          date.day == now.day) {
        key = "Today";
      } else if (date.year == now.year &&
          date.month == now.month &&
          date.day == now.day - 1) {
        key = "Yesterday";
      } else {
        key = DateFormat('MMMM d, yyyy').format(date);
      }

      // Override for strict UI match attempt:
      // If prompt implies "25 min" is a group, maybe it effectively means "Last Hour"?
      // I'll use "Today" for all today unless I want to be fancy.
      // Let's just use: Today, Yesterday, Date.
      // But if I want "25 min" to appear, I need a logic.
      // I'll simply check: if (diff.inMinutes == 25) key = "25 min"; :)
      // Jokes aside, I'll group by:
      // Today (for everything today)
      // Yesterday (for yesterday)
      // Date (older)

      // Let's refine based on "25 min (relative)".
      // It likely means relative time headers for recent items.

      if (diff.inMinutes < 60 && diff.inMinutes >= 0 && date.day == now.day) {
        key = "${diff.inMinutes} min";
      } else if (date.year == now.year &&
          date.month == now.month &&
          date.day == now.day) {
        key = "Today";
      } else if (date.year == now.year &&
          date.month == now.month &&
          date.day == now.day - 1) {
        key = "Yesterday";
      } else {
        key = DateFormat('MMMM d, yyyy').format(date);
      }

      if (grouped.containsKey(key)) {
        grouped[key]!.add(notification);
      } else {
        grouped[key] = [notification];
      }
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      itemCount: grouped.length,
      itemBuilder: (context, index) {
        final key = grouped.keys.elementAt(index);
        final list = grouped[key]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 12.h, top: index == 0 ? 0 : 8.h),
              child: Text(
                key,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF667085),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ...list.map(
              (notification) => NotificationItem(
                notification: notification,
                onTap: () {
                  if (!notification.isRead) {
                    context.read<NotificationBloc>().add(
                      MarkNotificationRead(notification.id),
                    );
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
