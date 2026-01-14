
///This is RO/BM branch only

class BaseUrl{
  ///Local Server
  //static const String baseUrl = 'http://192.168.29.70:98/api/';

  ///UAT Server RO/BM app
/* static const String mainBaseUrl = 'https://devapi.kanchaneshver.com';
static const String baseUrl = '$mainBaseUrl/api/';
static const String imageBaseUrl = 'https://devksdpl-uploads.s3.ap-south-1.amazonaws.com/';
static const String tutorialVideoBaseUrl = 'https://devksdpl-uploads.s3.ap-south-1.amazonaws.com/';
 static const String salesPanel = 'https://devsales.kanchaneshver.com';*/

  ///Live Server RO/BM app
  static const String mainBaseUrl = 'https://api.kanchaneshver.com';
  static const String baseUrl = '$mainBaseUrl/api/';
  static const String imageBaseUrl = 'https://ksdpl-uploads.s3.ap-south-1.amazonaws.com/';
  static const String tutorialVideoBaseUrl = 'https://ksdpl-uploads.s3.ap-south-1.amazonaws.com/';
  static const String salesPanel = 'https://sales.kanchaneshver.com';


  ///🚨⚠️ ALERT / WARNING
  ///Do change below devVersion also according to Live or UAT apk other wise it will give error in apk
 static const String devVersion = 'LIVE';
//static const String devVersion = 'UAT';
  //static const String devVersion = 'LOCAL';
  static const String buildDate = 'Build Date : 13 Jan 2026';
static const String appType = 'Access: RO/BM and AIC';


}

