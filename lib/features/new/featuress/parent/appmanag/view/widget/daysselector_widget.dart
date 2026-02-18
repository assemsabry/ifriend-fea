import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/features/new/featuress/parent/appmanag/controller/modes_cubit.dart';

class DaysselectorWidget extends StatelessWidget {
  final Set<int> selectedIndices;
  final ValueChanged<Set<int>> onChange;

  DaysselectorWidget({
    super.key,
    required this.selectedIndices,
    required this.onChange,
  });

  final List<String> days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModesCubit, ModesState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(days.length, (index) {
            final isSelected = selectedIndices.contains(index);

            return GestureDetector(
              onTap: () {
                final newSet = Set<int>.from(selectedIndices);

                if (isSelected) {
                  if (newSet.length > 1) {
                    newSet.remove(index);
                  }
                } else {
                  newSet.add(index);
                }

                onChange(newSet);
              },
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? ColorsManager.primary
                      : ColorsManager.primary.withOpacity(0.15),
                  border: !isSelected
                      ? Border.all(
                          color: ColorsManager.primary.withOpacity(0.3),
                        )
                      : null,
                ),
                alignment: Alignment.center,
                child: Text(
                  days[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : ColorsManager.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
