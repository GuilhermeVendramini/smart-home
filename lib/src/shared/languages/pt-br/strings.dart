class Strings {
  Strings._();

  // Generic
  static const String save = "Salvar";
  static const String name = "Nome";
  static const String icon = "Ícone";

  // App
  static const String appName = "SMART HOME";

  // Auth
  static const String authName = "Nome do usuário";
  static const String authPassword = "Senha";
  static const String authLogout = "Sair";
  static const String authLogin = "Login";
  static const String authRegister = "Register";
  static const String authLoginMessageWarning = "Nome ou senha inválidos";
  static const String authLoginMessageError =
      "Erro ao logar. Por favor, tente mais tarde";
  static const String authRequiredName = "Nome é obrigatório";
  static const String authRequiredPassword = "Senha é obrigatória";
  static const String authUserAlreadyExists = "Esse nome já existe";
  static const String authRegisterMessageError =
      "Erro ao logar. Por favor, tente mais tarde";

  // Devices
  static const String devicesTitle = "Devices";

  // Places
  static const String placesAdd = "Adicionar local";
  static const String placesRequiredName = "Nome é obrigatório";
  static const String placesRequiredIcon = "Ícone é obrigatório";
  static const String placesLoadingMessageError = "Erro ao carregar os locais";
  static const String placesSavedSuccessfully = "Local salvo com sucesso";
  static const String placesErrorSaving = "Erro ao salvar local";

  // Devices
  static const String devicesAdd = "Adicionar device";
  static const String devicesRequiredName = "Nome é obrigatório";
  static const String devicesRequiredIcon = "Ícone é obrigatório";
  static const String devicesLoadingMessageError = "Erro ao carregar devices";
  static const String devicesSavedSuccessfully = "Device salvo com sucesso";
  static const String devicesErrorSaving = "Erro ao salvar device";

  // Icon Picker
  static const String iconPickerTitleBox = "Selecione um ícone";

  // Plugins
  static const String pluginsTitle = "Plugins";
  static const String pluginsLoadingMessageError = "Erro ao carregar plugins";

  // Mqtt
  static const String mqttRequiredUser = "Usuário é obrigatório";
  static const String mqttRequiredPassword = "Senha é obrigatória";
  static const String mqttRequiredBroker = "Broker é obrigatório";
  static const String mqttRequiredClientIdentifier =
      "Client Identifier é obrigatório";
  static const String mqttRequiredPort = "Porta é obrigatória";
  static const String mqttBroker = "Broker";
  static const String mqttPassword = "Senha";
  static const String mqttUser = "Usuário";
  static const String mqttPort = "Porta";
  static const String mqttClientIdentifier = "Client Identifier";
  static const String mqttSaveMessageError = "Erro ao salvar MQTT";
  static const String mqttConnect = "Conectar";
  static const String mqttConnectMessageError = "Erro ao conectar MQTT";

  // PLUGINS

  // Switch ON/OFF
  static const String switchPluginTitle = "ON/OFF";
  static const String switchPluginDescription = "Switch the energy ON and OFF";
  static const String switchPluginRequiredTopic = "Tópico é obrigatório.";
  static const String switchPluginRequiredMessageOn =
      "Mensagem ON é obrigatória";
  static const String switchPluginRequiredMessageOff =
      "Mensagem OFF é obrigatória";
  static const String switchPluginRequiredTopicResult =
      "Tópico do resultado é obrigatório.";
  static const String switchPluginRequiredResultOn =
      "Resultado ON é obrigatório";
  static const String switchPluginRequiredResultOff =
      "Resultado OFF é obrigatório";
  static const String switchTopic = "Tópico";
  static const String switchMessageOn = "Mensagem ON";
  static const String switchMessageOff = "Mensagem OFF";
  static const String switchTopicResult = "Tópico de resultado";
  static const String switchResultOn = "Resultado ON";
  static const String switchResultOff = "Resultado de OFF";
  static const String switchSavedSuccessfully = "Salvo com sucesso";
  static const String switchErrorSaving = "Erro ao salvar";
  static const String switchStatus = "Habilitar/Desabilitar";
  static const String switchErrorSendingMessage = "Erro ao enviar mensagem";

  // Slider
  static const String sliderPluginTitle = "Slider";
  static const String sliderPluginDescription =
      "Regulate the energy using slider";
}
