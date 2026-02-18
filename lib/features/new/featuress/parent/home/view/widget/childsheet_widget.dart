import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';
import 'package:ifriend_app/features/new/featuress/parent/home/controller/parenthome_cubit.dart';
import 'package:ifriend_app/features/new/featuress/parent/home/model/parenthome_model.dart';

class SwitchDeviceWidget extends StatefulWidget {
  const SwitchDeviceWidget({super.key, required this.children});

  final List<AllChildren> children;

  @override
  State<SwitchDeviceWidget> createState() => _SwitchDeviceWidgetState();
}

class _SwitchDeviceWidgetState extends State<SwitchDeviceWidget> {
  String selectedChild = "";

  @override
  void initState() {
    super.initState();
    selectedChild = widget.children.first.firstName!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ParentHomeCubit(),
      child: BlocBuilder<ParentHomeCubit, ParentHomeState>(
        builder: (context, state) {
          ParentHomeCubit cubit = ParentHomeCubit.get(context);
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // العنوان وزر الإغلاق
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Switch Child Device",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const CircleAvatar(
                        backgroundColor: Color(0xFFE8F0FE),
                        child: Icon(
                          Icons.close,
                          color: ColorsManager.primary,
                          size: 20,
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // قائمة الأطفال
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.children.length,
                  itemBuilder: (context, index) {
                    final child = widget.children[index];
                    bool isSelected = selectedChild == child.firstName;

                    return GestureDetector(
                      onTap: () {
                        setState(() => selectedChild = child.firstName!);
                        ParentHomeCubit.get(
                          context,
                        ).getHomeParent(childId: child.id!);
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFE8F0FE)
                              : const Color(0xFFF7F8FA),
                          borderRadius: BorderRadius.circular(50),
                          border: isSelected
                              ? Border.all(
                                  color: ColorsManager.primary,
                                  width: 2,
                                )
                              : null,
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundImage: NetworkImage(child.avatarUrl!),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    title: child.firstName!,
                                    fontFamily: "Poppins",
                                    color: isSelected
                                        ? ColorsManager.baseBlack
                                        : ColorsManager.neutral700,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  CustomText(
                                    fontFamily: "Poppins",
                                    title: child.id!,
                                    color: ColorsManager.neutral500,
                                    fontSize: 14.sp,
                                  ),
                                ],
                              ),
                            ),
                            if (isSelected)
                              const CircleAvatar(
                                radius: 12,
                                backgroundColor: ColorsManager.primary,
                                child: Icon(
                                  Icons.check,
                                  size: 15,
                                  color: Colors.white,
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                // زر إضافة جهاز جديد
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F8FA),
                    border: Border.all(color: Colors.grey.shade300),

                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.grey[200],
                        child: const Icon(
                          Icons.add,
                          color: Colors.grey,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 15),
                      CustomText(
                        fontFamily: "Poppins",
                        title: "Add Device child’s",
                        color: ColorsManager.neutral500,
                        fontSize: 14.sp,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}
