import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NoItemWidget extends StatelessWidget {
  final String? title;
  const NoItemWidget({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        spacing: 15,
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              height: 100.h,
              child: Skeletonizer(
                child: ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const Text("");
                  },
                ),
              ),
            ),
          ),
          Text(
            title ?? ": ",
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
