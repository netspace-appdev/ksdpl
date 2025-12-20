class BaseUrl{
  ///Local Server
  //static const String baseUrl = 'http://192.168.29.70:98/api/';

  ///UAT Server

static const String baseUrl = 'https://devapi.kanchaneshver.com/api/';
static const String imageBaseUrl = 'https://devksdpl-uploads.s3.ap-south-1.amazonaws.com/';
static const String tutorialVideoBaseUrl = 'https://devksdpl-uploads.s3.ap-south-1.amazonaws.com/';

  ///Live Server
 //static const String baseUrl = 'https://api.kanchaneshver.com/api/';
 //static const String imageBaseUrl = 'https://ksdpl-uploads.s3.ap-south-1.amazonaws.com/';
 //static const String tutorialVideoBaseUrl = 'https://ksdpl-uploads.s3.ap-south-1.amazonaws.com/';


  ///🚨⚠️ ALERT / WARNING
  ///Do change below devVersion also according to Live or UAT apk other wise it will give error in apk
// static const String devVersion = 'LIVE';
 static const String devVersion = 'UAT';
  //static const String devVersion = 'LOCAL';
  static const String buildDate = 'Build Date : 18 Dec 2025';
}

