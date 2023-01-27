import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/view/explore.dart';
import 'package:testapp/view/homepage.dart';
import 'package:testapp/view/profile.dart';
import 'package:testapp/view/tvshow.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'model/local_storage_model.dart';

// Error Builder
void setErrorBuilder() {
  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
    return const Scaffold(
        body:
            Center(child: Text("Unexpected error. See console for details.")));
  };
}

// Pages List
List<Widget> Pages = [
  const HomePage(key: PageStorageKey("homeScreen")),
  const Explore(key: PageStorageKey("exploreScreen")),
  const TVshow(key: PageStorageKey("tvshowScreen")),
  // const Downloads(),
  const Profile()
];

// Background Color
Color backgroundColor = const Color(0xff0B091C);

// Box Color
Color boxColor = const Color(0xff1F1D33);

// Active Color
Color isActiveColor = const Color(0xffF5A754).withOpacity(0.5);

// Secure Local Storage

var secureStorage = const FlutterSecureStorage();

// Writing Value in Enabling getAndroid Options

AndroidOptions getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

// Writing Value in local Storage

Future<void> writeSecureData(StorageItem item) async {
  await secureStorage.write(
      key: item.key, value: item.value, aOptions: getAndroidOptions());
}

// Delete Value from Storage

Future<void> deleteSecureData() async {
  await secureStorage.deleteAll();
}

// Error Snackbar
ErrorSnackBar(String text) {
  Get.snackbar("Error", text,
      colorText: Colors.white,
      icon: const Icon(
        Icons.error_outline,
        color: Colors.red,
      ));
}

// Success Snackbar

CompletionSnackBar(String text) {
  Get.snackbar("Success", text,
      colorText: Colors.white,
      icon: const Icon(
        Icons.done,
        color: Colors.green,
      ));
}

// Alert SnackBar

alertSnackBar(String text) {
  Get.snackbar("Alert", text,
      colorText: Colors.white,
      icon: const Icon(
        Icons.warning_amber,
        color: Colors.red,
      ));
}

///////////////Testing Episode Names//////////////////////////////////
String subtitleUrl = '';
String episodeName = '';
String episodevideoUrl = '';
///////////////////////////////////////////////////////////////////////
// Read Storage data
Future<String?> readSecureData(String key) async {
  var readData =
      await secureStorage.read(key: key, aOptions: getAndroidOptions());
  return readData;
}

// Website url
String siteurl = "https://portal.nuclearhomevideo.com/api";
String mainsiteurl = "https://portal.nuclearhomevideo.com/";

String? userId;
String? Usertoken;
String? Username;
String? useremail;
String? userImage;
String? subscribed;
String? userphone;
String? useraddress;

// Movie subtitle Language Array

Map<String, String> subtitlelanguageArray = {
  'en': 'English',
  'af': 'Afrikaans',
  'sq': 'Albanian',
  'am': 'Amharic',
  'ar': 'Arabic',
  'hy': 'Armenian',
  'az': 'Azerbaijani',
  'ba': 'Bashkir',
  'be': 'Belarusian',
  'bn': 'Bengali',
  'bs': 'Bosnian',
  'bg': 'Bulgarian',
  'Bu': 'Bu-Ninkada',
  'km': 'Central Khmer',
  'zh': 'Chinese',
  'hr': 'Croatian',
  'cs': 'Czech',
  'da': 'Danish',
  'nl': 'Dutch',
  'et': 'Estonian',
  'fa': 'Persian',
  'fi': 'Finnish',
  'fr': 'French',
  'gd': 'Gaelic',
  'ka': 'Georgian',
  'de': 'German',
  'el': 'Greek',
  'gu': 'Gujarati',
  'he': 'Hebrew',
  'hi': 'Hindi',
  'hu': 'Hungarian',
  'is': 'Icelandic',
  'id': 'Indonesian',
  'it': 'Italian',
  'ja': 'Japanese',
  'jv': 'Javanese',
  'kn': 'Kannada',
  'kk': 'Kazakh',
  'ko': 'Korean',
  'ku': 'Kurdish',
  'lv': 'Latvian',
  'lt': 'Lithuanian',
  'mk': 'Macedonian',
  'ms': 'Malay',
  'ml': 'Malayalam',
  'ma': 'Morocco',
  'mr': 'Marathi',
  'mn': 'Mongolian',
  'ro': 'Romanian',
  'nb': 'Norwegian Bokm책l',
  'or': 'Oriya',
  'ps': 'Pashto',
  'pl': 'Polish',
  'pt': 'Portuguese',
  'pa': 'Panjabi',
  'ru': 'Russian',
  'sm': 'Samoan',
  'sr': 'Serbian',
  'sk': 'Slovak',
  'sl': 'Slovenian',
  'so': 'Somali',
  'es': 'Spanish',
  'sw': 'Swahili',
  'sv': 'Swedish',
  'tl': 'Tagalog',
  'tg': 'Tajik',
  'ta': 'Tamil',
  'te': 'Telugu',
  'th': 'Thai',
  'tr': 'Turkish',
  'tk': 'Turkmen',
  'uk': 'Ukrainian',
  'ur': 'Urdu',
  'uz': 'Uzbek',
  'vi': 'Vietnamese',
  'xh': 'Xhosa',
  'yi': 'Yiddish',
  'yo': 'Yoruba',
  'zu': 'Zulu',
};

// Movie country Array

Map<String, String> countriesArray = {
  "": "All Country",
  "US": "United States",
  "IT": "Italy",
  "DE": "Germany",
  "AU": "Australia",
  "PH": "Philippines",
  "GB": "United Kingdom",
  "TZ": "Tanzania",
  "CN": "China",
  "BR": "Brazil",
  "ES": "Spain",
  "MX": "Mexico",
  "CY": "Cyprus",
  "IN": "India",
  "AT": "Austria",
  "NL": "Netherlands",
  "AE": "United Arab Emirates",
  "GT": "Guatemala",
  "NZ": "New Zealand",
  "AG": "Antigua",
  "GY": "Guyana",
  "OM": "Oman",
  "AR": "Argentina",
  "HK": "Hong Kong",
  "PA": "Panama",
  "HN": "Honduras",
  "PE": "Peru",
  "HR": "Croatia",
  "AW": "Aruba",
  "HT": "Haiti",
  "PK": "Pakistan",
  "BB": "Barbados",
  "HU": "Hungary",
  "PL": "Poland",
  "BD": "Bangladesh",
  "ID": "Indonesia",
  "PR": "Puerto Rico",
  "BE": "Belgium",
  "IE": "Ireland",
  "PT": "Portugal",
  "BF": "Burkina Faso",
  "IL": "Israel",
  "PY": "Paraguay",
  "BG": "Bulgaria",
  "QA": "Qatar",
  "BH": "Bahrain",
  "IQ": "Iraq",
  "RO": "Romania",
  "BJ": "Benin",
  "IR": "Iran",
  "RU": "Russian Federation",
  "BM": "Bermuda",
  "IS": "Iceland",
  "SA": "Saudi Arabia",
  "BN": "Brunei Darussalam",
  "SC": "Seychelles",
  "BO": "Bolivia",
  "JM": "Jamaica",
  "SD": "Sudan",
  "JO": "Jordan",
  "SE": "Sweden",
  "BS": "Bahamas",
  "JP": "Japan",
  "SG": "Singapore",
  "BZ": "Belize",
  "KE": "Kenya",
  "SI": "Slovenia",
  "CH": "Switzerland",
  "KR": "Korea",
  "SK": "Slovakia",
  "KW": "Kuwait",
  "SL": "Sierra Leone",
  "CL": "Chile",
  "KY": "Cayman Islands",
  "SN": "Senegal",
  "LB": "Lebanon",
  "SO": "Somalia",
  "CO": "Colombia",
  "LC": "Saint Lucia",
  "SR": "Suriname",
  "CR": "Costa Rica",
  "LI": "Liechtenstein",
  "SV": "El Salvador",
  "CU": "Cuba",
  "LK": "Sri Lanka",
  "SY": "Syrian Arab Republic",
  "LR": "Liberia",
  "TC": "Turks",
  "CZ": "Czech Republic",
  "LT": "Lithuania",
  "TH": "Thailand",
  "LU": "Luxembourg",
  "TN": "Tunisia",
  "DK": "Denmark",
  "LV": "Latvia",
  "TR": "Turkey",
  "DO": "Dominican Republic",
  "LY": "Libyan Arab Jamahiriya",
  "TT": "Trinidad and Tobago",
  "EC": "Ecuador",
  "MA": "Morocco",
  "TW": "Taiwan",
  "EE": "Estonia",
  "MC": "Monaco",
  "EG": "Egypt",
  "ML": "Mali",
  "UA": "Ukraine",
  "MR": "Mauritania",
  "UG": "Uganda",
  "ET": "Ethiopia",
  "MT": "Malta",
  "UY": "Uruguay",
  "FI": "Finland",
  "MU": "Mauritius",
  "FR": "France",
  "MW": "Malawi",
  "VE": "Venezuela",
  "VN": "Viet Nam",
  "GD": "Grenada",
  "MY": "Malaysia",
  "WS": "Samoa",
  "GH": "Ghana",
  "NE": "Niger",
  "YE": "Yemen",
  "GL": "Greenland",
  "NG": "Nigeria",
  "ZA": "South Africa",
  "GM": "Gambia",
  "NI": "Nicaragua",
  "ZM": "Zambia",
  "GN": "Guinea",
  "ZW": "Zimbabwe",
  "GR": "Greece",
  "NO": "Norway"
};
