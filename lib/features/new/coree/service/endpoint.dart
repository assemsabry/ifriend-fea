class EndPoints {
  static const String api = "https://api.i-friend.cloud/api/v1";

  // static const String logInLink = "$api/auth/login";

  //TASK
  static const String createTaskLink = "$api/application/tasks/create-task";

  static String getTasksLink(String childProfileId) =>
      "$api/application/tasks/get-all-tasks/$childProfileId";

  static const String completeProfileLink =
      "$api/application/profile/create-parent-profile";

  static const String completeChildProfileLink =
      "$api/application/profile/create-child-profile";

  static String deleteTaskLink(String taskId) =>
      "$api/application/tasks/delete-task/$taskId";

  static String editTaskLink(String taskId) =>
      "$api/application/tasks/update-task/$taskId";

  static String updateMyTaskLink(String childProfileId) =>
      "$api/application/tasks/get-all-tasks/$childProfileId";

  static String markTaskAsDoneLink(String taskId) =>
      "$api/application/tasks/mark-task-as-done/$taskId";

  static String createLocationLink =
      "$api/application/location/create-safe-zone";
  static String editSafeZoneLink(String safeZoneId) =>
      "$api/application/location/update-safe-zone/$safeZoneId";

  static String deleteSafeZoneLink(String safeZoneId) =>
      "$api//application/location/delete-safe-zone/$safeZoneId";
  //Location
  static String getLocationLink(String childProfileId) =>
      "$api/application/location/get-safe-zones/$childProfileId";

  //CHILD
  static String getChildProfileLink =
      "$api/application/profile/get-child-profile";

  //Link
  static String getLinkStatusChildLink =
      "$api/application/link/get-link-status-child";

  static String getChildDeviceLink = "$api/application/device/user-device";

  ///
  static const String getAllMyChildLink = "$api/application/link/my-children";

  static String getAllMyChildLocationsLink =
      "$api/application/location/get-all-children-locations";

  //Apps

  static String getAllAppsLink(String deviceId) =>
      "$api/application/apps/get-apps/$deviceId";

  static String switchAppLink(String appId) =>
      "$api/application/apps/update-app-status/$appId";

  static String getAllModesLink(String deviceId) =>
      "$api/application/modes/get-all-modes/$deviceId";

  static String updateModeLink(String modeId) =>
      "$api/application/modes/update-mode/$modeId";

  static String switchModeLink(String modeId) =>
      "$api/application/modes/update-mode-status/$modeId";

  //Child
  static const String syncApps = "$api/application/apps/sync-apps";

  static String getHomeParentLink =
      "$api/application/home/get-home-data-parent";
}
