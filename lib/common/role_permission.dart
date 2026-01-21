import 'helper.dart';

class RolePermissions {
  /// Roles that behave like RO / BM
  static const Set<String> juniorLevelLike = {
    AppConstants.independentBusinessManager,
    AppConstants.channelBusinessManager,
    //AppConstants.dsaLevel1,
   // AppConstants.dsaLevel2,
  };

  /// Roles that can mark Doable / Not Doable
  static const Set<String> seniorLevelLike = {
    AppConstants.independentAreaHead,
    AppConstants.channelClusterHead,
    AppConstants.channelRegionalHead,
   /* AppConstants.dsaLevel3,
    AppConstants.dsaLevel4,
    AppConstants.dsaLevel5,*/
  };
}
