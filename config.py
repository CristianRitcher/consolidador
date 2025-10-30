import os

class BaseConfig:
    APP_NAME = "Volcado Web - Tokyo Sushi"
    SECRET_KEY = os.getenv("SECRET_KEY", "tokyo_sushi_secret")
    DEBUG = True
    JSON_AS_ASCII = False

class DevelopmentConfig(BaseConfig):
    ENV = "development"

class ProductionConfig(BaseConfig):
    ENV = "production"
    DEBUG = False

config = {
    "development": DevelopmentConfig,
    "production": ProductionConfig,
    "default": DevelopmentConfig
}
