const _baseUrl = "baseUrl";
const _oAuthBaseUrl = "oAuthBaseUrl";

enum Environment { dev, stage, prod }

Map<String, dynamic> _config;

void setEnvironment(Environment env) {
  switch (env) {
    case Environment.dev:
      _config = devConstants;
      break;
    case Environment.stage:
      _config = stageConstants;
      break;
    case Environment.prod:
      _config = prodConstants;
      break;
  }
}

dynamic get apiBaseUrl {
  print('_config $_config');
  return _config[_baseUrl];
}

dynamic get apiOAuthBaseUrl {
  print('_config $_config');
  return _config[_oAuthBaseUrl];
}

Map<String, dynamic> devConstants = {
  _baseUrl: "http://10.0.2.2:8080/v1/api",
  _oAuthBaseUrl: "http://localhost:7071/users"
};

Map<String, dynamic> stageConstants = {
  _baseUrl: "http://localhost:8080/v1/api",
  _oAuthBaseUrl: "http://localhost:7071/users"
};

Map<String, dynamic> prodConstants = {
  _baseUrl: "http://localhost:8080/v1/api",
  _oAuthBaseUrl: "http://localhost:7071/users"
};
