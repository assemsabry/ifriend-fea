import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';
import 'package:ifriend_app/features/new/featuress/parent/appmanag/controller/modes_cubit.dart';
import 'package:ifriend_app/features/new/featuress/parent/appmanag/view/widget/daysselector_widget.dart';

class DayswarbWidget extends StatefulWidget {
  final Set<int>? selectedDays;
  final bool? isAllDays;
  const DayswarbWidget({super.key, this.selectedDays, this.isAllDays});

  @override
  State<DayswarbWidget> createState() => _DayswarbWidgetState();
}

class _DayswarbWidgetState extends State<DayswarbWidget> {
  late Set<int> selectedDays;
  late bool isAllDays;

  @override
  void initState() {
    super.initState();
    selectedDays = widget.selectedDays ?? {0, 1, 2, 3, 4, 5, 6};
    isAllDays = widget.isAllDays ?? true;
  }

  bool get isAllDaysSelected => selectedDays.length == 7;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModesCubit, ModesState>(
      builder: (context, state) {
        return Column(
          children: [
            if (isAllDaysSelected)
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ColorsManager.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: CustomText(
                  title: "All day",
                  color: ColorsManager.primary,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),

            /// 🟢 Days selector
            if (!isAllDaysSelected)
              DaysselectorWidget(
                selectedIndices: selectedDays,
                onChange: (value) {
                  // setState(() {
                  //   selectedDays
                  //     ..clear()
                  //     ..addAll(value);
                  // });
                },
              ),
          ],
        );
      },
    );
  }
}
