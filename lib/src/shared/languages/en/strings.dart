class Strings {
  Strings._();

  // Generic
  static const String save = "Save";
  static const String name = "Name";
  static const String icon = "Icon";
  static const String confirm = "Confirm";
  static const String cancel = "Cancel";

  // App
  static const String appName = "Smart Home";

  // Devices
  static const String devicesTitle = "Devices";

  // Places
  static const String placesManager = "Manager Place";
  static const String placesRequiredName = "Name is required";
  static const String placesRequiredIcon = "Icon is required";
  static const String placesLoadingMessageError = "Error loading places";
  static const String placesErrorSaving = "Error saving place";
  static const String placesErrorUpdating = "Error updating place";
  static const String placesErrorDeleting = "Error deleting place";
  static const String placesConfirmDelete = "Delete place?";
  static const String placesConfirmDeleteMessage =
      "All devices and settings tied to the place will be deleted!";

  // Devices
  static const String devicesManager = "Manage device";
  static const String devicesRequiredName = "Name is required";
  static const String devicesRequiredIcon = "Icon is required";
  static const String devicesLoadingMessageError = "Error loading devices";
  static const String devicesErrorSaving = "Error saving device";
  static const String devicesErrorDeleting = "Error deleting device";
  static const String devicesErrorUpdating = "Error updating device";
  static const String devicesConfirmDelete = "Delete device?";
  static const String devicesConfirmDeleteMessage =
      "All settings tied to the device will be deleted!";

  // Icon Picker
  static const String iconPickerTitleBox = "Select an icon";

  // Plugins
  static const String pluginsTitle = "Plugins";
  static const String pluginsLoadingMessageError = "Error loading plugins";
  static const String pluginsEmptyList = "No plugins configured yet";

  // Mqtt
  static const String mqttRequiredUser = "User is required";
  static const String mqttRequiredPassword = "Password is required";
  static const String mqttRequiredBroker = "Broker is required";
  static const String mqttRequiredClientIdentifier =
      "Client Identifier is required";
  static const String mqttRequiredPort = "Port is required";
  static const String mqttBroker = "Broker";
  static const String mqttPassword = "Password";
  static const String mqttUser = "User";
  static const String mqttPort = "Port";
  static const String mqttClientIdentifier = "Client Identifier";
  static const String mqttSaveMessageError = "Error saving MQTT";
  static const String mqttConnect = "Connect";
  static const String mqttConnectMessageError = "Error connecting MQTT";

  // PLUGINS

  // Switch ON/OFF
  static const String switchPluginTitle = "ON/OFF";
  static const String switchPluginDescription = "Turn the switch on and off";
  static const String switchPluginRequiredTopic = "Topic is required";
  static const String switchPluginRequiredMessageOn = "ON message is required";
  static const String switchPluginRequiredMessageOff =
      "OFF message is required";
  static const String switchPluginRequiredTopicResult =
      "Result topic is required";
  static const String switchPluginRequiredResultOn =
      "Result message ON is required";
  static const String switchPluginRequiredResultOff =
      "Result message OFF is required";
  static const String switchTopic = "Topic";
  static const String switchMessageOn = "Message ON";
  static const String switchMessageOff = "Message OFF";
  static const String switchTopicResult = "Result topic";
  static const String switchResultOn = "Result message ON";
  static const String switchResultOff = "Result message OFF";
  static const String switchSavedSuccessfully = "Saved successfully";
  static const String switchErrorSaving = "Error saving";
  static const String switchErrorUpdating = "Error updating";
  static const String switchStatus = "Enable/Disable";
  static const String switchErrorSendingMessage = "Error sending message";
}
