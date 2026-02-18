// import 'package:board_datetime_picker/board_datetime_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';
// import 'package:ifriend_app/core/dio/dio_helper.dart';
// import 'package:ifriend_app/core/helper/hive_helper.dart';
// import 'package:ifriend_app/core/services/endpoint.dart';
// import 'package:ifriend_app/core/theme/color_manager.dart';
// import 'package:ifriend_app/features/parent/appmanag/model/timepicker_type.dart';

// part 'ai_state.dart';

// class AiCubit extends Cubit<AiState> {
//   AiCubit() : super(AiLoadingStates());

//   static AiCubit get(BuildContext context) => BlocProvider.of(context);

//   AiModel? AiModel;

//   Future<void> getAllAi() async {
//     emit(AiLoadingStates());

//     try {
//       final response = await DioHelper.getData(
//         url: EndPoints.getAllAiLink(HiveHelper.getData("deviceId")),

//         token: HiveHelper.getData("token"),
//       );
//       print(response.data);
//       if (response.statusCode == 200) {
//         AiModel = AiModel.fromJson(response.data);

//         emit(AiSuccessStates(AiModel: AiModel!));
//       } else {
//         print(response.data.toString());
//         emit(AiErrorStates(error: response.data.toString()));
//       }
//     } catch (error) {
//       print(error.toString());
//       emit(AiErrorStates(error: error.toString()));
//     }
//   }

//   Future<void> updateMode({required String modeId}) async {
//     emit(AiUpdateLoadingStates());

//     try {
//       final response = await DioHelper.putData(
//         url: EndPoints.updateModeLink(modeId),
//         data: {
//           "isActive": isAllDay,
//           "startTime": startTime!
//               .format(Get.context!)
//               .replaceAll(' ', '')
//               .toString(),
//           "endTime": endTime!
//               .format(Get.context!)
//               .replaceAll(' ', '')
//               .toString(),
//           "days": selectedDaysAsString,
//         },
//         token: HiveHelper.getData("token"),
//       );
//       print("res: $response");

//       print("modeId: $modeId");
//       print("isAllDay: $isAllDay");
//       print("startTime: ${startTime!.format(Get.context!).toString()}");
//       print("endTime: ${endTime!.format(Get.context!).toString()}");
//       print("days: ${selectedDaysAsString}");
//       print("response: ${response.data}");
//       if (response.statusCode == 200) {
//         getAllAi();
//         Navigator.pop(Get.context!);
//         emit(AiUpdateSuccessStates());
//       } else {
//         print(response.data.toString());
//         emit(AiUpdateErrorStates(error: response.data.toString()));
//       }
//     } catch (error) {
//       print(error.toString());
//       emit(AiErrorStates(error: error.toString()));
//     }
//   }

//   Future<void> switchApp({
//     required String appId,
//     required bool isBlocked,
//   }) async {
//     emit(AiSwitchLoadingStates());

//     try {
//       final response = await DioHelper.putData(
//         url: EndPoints.switchAppLink(appId),
//         data: {"isBlocked": isBlocked},
//         token: HiveHelper.getData("token"),
//       );
//       print(response.data);
//       if (response.statusCode == 200) {
//         getAllAi();
//         emit(AiSwitchSuccessStates());
//       } else {
//         print(response.data.toString());
//         emit(AiSwitchErrorStates(error: response.data.toString()));
//       }
//     } catch (error) {
//       print(error.toString());
//       emit(AiSwitchErrorStates(error: error.toString()));
//     }
//   }

//   final Map<int, String> dayIndexToBackend = {
//     0: "SUN",
//     1: "MON",
//     2: "TUE",
//     3: "WED",
//     4: "THU",
//     5: "FRI",
//     6: "SAT",
//   };
//   Set<int> selectedDays = {};
//   void setSelectedDays(Set<int> days) {
//     selectedDays = days;
//     emit(AiChangeTypeStates());
//   }

//   String get selectedDaysAsString {
//     if (selectedDays.isEmpty) return "";

//     return selectedDays
//         .map((index) => dayIndexToBackend[index])
//         .whereType<String>()
//         .join(", ");
//   }

//   Set<int> selectedDaysFromAi(String? days) {
//     if (days == null || days.isEmpty) return {};

//     final parts = days.split(',');

//     final selected = parts
//         .map((e) => dayIndexMap[e.trim().toUpperCase()])
//         .whereType<int>()
//         .toSet();

//     return selected;
//   }

//   bool isLoading = false;

//   void setLoading(bool value) {
//     isLoading = value;
//     emit(AiChangeTypeStates());
//   }

//   bool isAllDay = false;

//   void setIsAllDay(bool value) {
//     isAllDay = value;
//     emit(AiChangeTypeStates());
//   }

//   int methodId = 0;

//   void changeTapIndex(int index, int withdrawalMethodId) {
//     methodId = withdrawalMethodId;
//     emit(AiChangeTypeStates());
//   }

//   TimeOfDay? startTime;
//   TimeOfDay? endTime;

//   void initTimesFromBackend(Ai Ai) {
//     startTime = parseTime(Ai.startTime);
//     endTime = parseTime(Ai.endTime);
//     emit(AiChangeTypeStates());
//   }

//   TimePickType currentPick = TimePickType.start;
//   void openTimePicker(BuildContext context, TimePickType type) {
//     final TimeOfDay initialTime = type == TimePickType.start
//         ? (startTime ?? TimeOfDay.now())
//         : (endTime ?? TimeOfDay.now());

//     final now = DateTime.now();
//     final initialDate = DateTime(
//       now.year,
//       now.month,
//       now.day,
//       initialTime.hour,
//       initialTime.minute,
//     );

//     showBoardDateTimePickerForTime(
//       context: context,
//       initialDate: initialDate,
//       options: BoardDateTimeOptions(
//         foregroundColor: ColorsManager.borderColor,
//         activeColor: ColorsManager.primary,
//         textColor: ColorsManager.baseBlack,

//         boardTitle: type == TimePickType.start
//             ? "Select Start Time"
//             : "Select End Time",
//       ),
//       onChanged: (date) {
//         final pickedTime = TimeOfDay(hour: date.hour, minute: date.minute);

//         if (type == TimePickType.start) {
//           startTime = pickedTime;
//         } else {
//           endTime = pickedTime;
//         }

//         emit(AiChangeTypeStates());
//       },
//     );
//   }
// }
