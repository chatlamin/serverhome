"""
Django settings for webvirtcloud project.

"""

from pathlib import Path

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent

SECRET_KEY = "1d0lQnaA&{GKhny}{*y?K,ZpukoHlqLKP&|\<2x)_kPHuT*AW%"

DEBUG = False

ALLOWED_HOSTS = ["*"]

# Application definition
INSTALLED_APPS = [
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    "django_bootstrap5",
    "django_icons",
    "django_otp",
    "django_otp.plugins.otp_totp",
    "accounts",
    "admin",
    "appsettings",
    "computes",
    "console",
    "datasource",
    "networks",
    "instances",
    "interfaces",
    "nwfilters",
    "storages",
    "virtsecrets",
    "logs",
    "qr_code",
]

MIDDLEWARE = [
    "django.middleware.security.SecurityMiddleware",
    "django.contrib.sessions.middleware.SessionMiddleware",
    "django.middleware.locale.LocaleMiddleware",
    "django.middleware.common.CommonMiddleware",
    "django.middleware.csrf.CsrfViewMiddleware",
    "django.contrib.auth.middleware.AuthenticationMiddleware",
    "django_otp.middleware.OTPMiddleware",
    "login_required.middleware.LoginRequiredMiddleware",
    "django.contrib.auth.middleware.RemoteUserMiddleware",
    "django.contrib.messages.middleware.MessageMiddleware",
    "django.middleware.clickjacking.XFrameOptionsMiddleware",
    "appsettings.middleware.AppSettingsMiddleware",
    "webvirtcloud.middleware.ExceptionMiddleware",
]

ROOT_URLCONF = "webvirtcloud.urls"

TEMPLATES = [
    {
        "BACKEND": "django.template.backends.django.DjangoTemplates",
        "DIRS": [
            Path.joinpath(BASE_DIR, "templates"),
        ],
        "APP_DIRS": True,
        "OPTIONS": {
            "context_processors": [
                "django.template.context_processors.debug",
                "django.template.context_processors.request",
                "django.contrib.auth.context_processors.auth",
                "django.contrib.messages.context_processors.messages",
                "appsettings.context_processors.app_settings",
            ],
            "libraries": {
                "common_tags": "webvirtcloud.common_tags",
            },
        },
    },
]

WSGI_APPLICATION = "webvirtcloud.wsgi.application"


# Settings for django-icons
DJANGO_ICONS = {

    'DEFAULTS': {
        'renderer': 'fontawesome4',
    },

    'RENDERERS': {
        'fontawesome4': 'FontAwesome4Renderer',
        'bootstrap3': 'Bootstrap3Renderer',
    },
}


# Database
# https://docs.djangoproject.com/en/3.0/ref/settings/#databases

DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.sqlite3",
        "NAME": Path.joinpath(BASE_DIR, "db.sqlite3"),
    }
}

AUTHENTICATION_BACKENDS = [
    "django.contrib.auth.backends.ModelBackend",
    "webvirtcloud.ldapbackend.LdapAuthenticationBackend",
]

LOGIN_URL = "/accounts/login/"

LOGOUT_REDIRECT_URL = "/accounts/login/"

LANGUAGE_CODE = "en-us"

TIME_ZONE = "UTC"

USE_I18N = True

USE_L10N = True

USE_TZ = True

STATIC_URL = "/static/"

STATICFILES_DIRS = [
    Path.joinpath(BASE_DIR, "static"),
]


# Default primary key field type
# https://docs.djangoproject.com/en/3.2/ref/settings/#default-auto-field

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'


LOCALE_PATHS = [
    "locale/",
]


# Settings for django-icons
DJANGO_ICONS = {

    'DEFAULTS': {
        'renderer': 'fontawesome4',
    },

    'RENDERERS': {
        'fontawesome4': 'FontAwesome4Renderer',
        'bootstrap3': 'Bootstrap3Renderer',
    },
}


LOGGING = {
    "version": 1,
    "disable_existing_loggers": False,
    "handlers": {
        "mail_admins": {"level": "ERROR", "class": "django.utils.log.AdminEmailHandler"}
    },
    "loggers": {
        "django.request": {
            "handlers": ["mail_admins"],
            "level": "ERROR",
            "propagate": True,
        }
    },
}


#
# WebVirtCloud settings
#

# Websock port
WS_PORT = 6080

# Websock host
WS_HOST = "0.0.0.0"

# Websock public port - 80 or 443 if reverse-proxy, else 6080
WS_PUBLIC_PORT = 6080

# Websock public host
WS_PUBLIC_HOST = None

# Websock public path
WS_PUBLIC_PATH = "/novncd/"

# Websock Certificate for SSL
WS_CERT = None

# List of console listen addresses
QEMU_CONSOLE_LISTEN_ADDRESSES = (
    ("127.0.0.1", "Localhost"),
    ("0.0.0.0", "All interfaces"),
)

# List taken from http://qemu.weilnetz.de/qemu-doc.html#sec_005finvocation
QEMU_KEYMAPS = [
    "ar",
    "da",
    "de",
    "de-ch",
    "en-gb",
    "en-us",
    "es",
    "et",
    "fi",
    "fo",
    "fr",
    "fr-be",
    "fr-ca",
    "fr-ch",
    "hr",
    "hu",
    "is",
    "it",
    "ja",
    "lt",
    "lv",
    "mk",
    "nl",
    "nl-be",
    "no",
    "pl",
    "pt",
    "pt-br",
    "ru",
    "sl",
    "sv",
    "th",
    "tr",
]

# Keepalive interval and count for libvirt connections
LIBVIRT_KEEPALIVE_INTERVAL = 5
LIBVIRT_KEEPALIVE_COUNT = 5

ALLOW_EMPTY_PASSWORD = False
NEW_USER_DEFAULT_INSTANCES = []
SHOW_PROFILE_EDIT_PASSWORD = True


# OTP Config
OTP_ENABLED = False

LOGIN_REQUIRED_IGNORE_VIEW_NAMES = ["accounts:login", "accounts:email_otp"]

# LDAP Config
#

LDAP_ENABLED = False
LDAP_URL = ''
LDAP_PORT = 389
USE_SSL = False
## The user with search rights on ldap. (e.g cn=admin,dc=kendar,dc=org)
LDAP_MASTER_DN = ''
LDAP_MASTER_PW = ''
## The root dn (e.g. dc=kendar,dc=org)
LDAP_ROOT_DN = ''
## Queries to identify the users, i use groupOfUniqueNames on openldap

### PLEASE BE SURE memberOf overlay is activated on slapd
## e.g. memberOf=cn=admins,cn=staff,cn=webvirtcloud,ou=groups,dc=kendar,dc=org
LDAP_SEARCH_GROUP_FILTER_ADMINS = ''
## e.g. memberOf=cn=staff,cn=webvirtcloud,ou=groups,dc=kendar,dc=org
LDAP_SEARCH_GROUP_FILTER_STAFF = ''
## e.g. memberOf=cn=webvirtcloud,ou=groups,dc=kendar,dc=org
LDAP_SEARCH_GROUP_FILTER_USERS = ''

## The user name prefix to identify the user name (e.g. cn)
LDAP_USER_UID_PREFIX = ''
