import 'package:flutter/material.dart';

const String url = 'http://localhost:63258/api';
const String loginPath = '/authentication/login';
const String registerpath = '/authentication/register';
const String getAllUserRolePath = '/user/get-all-role';
const String getAllUserPath = '/user/get-all';
const String updateUserPath = '/user/update';
const String getAllClaimStatusPath = '/claim-status/get-all';
const String getAllClaimCategoryPath = '/claim-category/get-all';
const String getAllClaimPath = '/claim/get-all';
const String getClaimByUserIDPath = '/claim/get-by-user-id';
const String getClaimByClaimIDPath = '/claim/get-by-claim-id';
const String addClaimDocumentPath = '/claim/create-file';
const String deleteClaimDocumentPath = '/claim/delete-file';
const String addClaimPath = '/claim/create';
const String updateClaimPath = '/claim/update';
const String updateClaimStatusPath = '/claim/update-status';

const pathGenerateUserToken = '/UserToken/GenerateUserToken';
const pathRetrieveUserTokenByToken = '/UserToken/RetrieveUserTokenByToken';
const pathDeleteUserTokenByToken = '/UserToken/DeleteUserTokenByToken';
const String customerPath = '/Customer';
const String activateCustomerPath = '/Customer/Activate';
const String deleteCustomerPath = '/Customer/Delete';
const String customerUserPath = '/CustomerUser';
const String errorDictionaryPath = '/ErrorDictionary';
const String customerUserByCustomerIdPath = '/CustomerUser/Customer';
const String customerUserByAppCustomerIdPath =
    '/CustomerUser/RetrieveCustomerUserByApplicationCustomerId';
const String applicationPath = '/Application';
const String applicationCustomerPath = '/ApplicationCustomer';
const String applicationCustomerByCustomerIdPath =
    '/ApplicationCustomer/Customer';
const String licensePath = '/License';
const String activateLicensePath = '/License/Activate';
const String deactivateLicensePath = '/License/Deactivate';
const String licensePathByCustomerIdPath = '/License/Customer';
const String licensePathByAppCustomerIdPath =
    '/License/RetrieveLicenseByAppCustomer';
const String featurePath = '/Feature';
const String featureCustomerPath = '/FeatureCustomer';
const String featureCustomerByApplicationCustomerIdPath =
    '/FeatureCustomer/RetrieveByApplicationCustomerId';
const String featureByAppsIdPath = '/Feature/apps';
const String sourceServicePath = '/SourceService';
const String sourceServiceCustomerPath = '/SourceService/Customer';
const String sourceServiceApplicationCustomerPath =
    '/SourceService/ApplicationCustomer';
const String sourceServiceFeatureCustomerPath =
    '/SourceService/FeatureCustomer';
const String externalServicePath = '/ExternalService';
const String externalServiceCustomerPath = '/ExternalService/Customer';
const String externalServiceApplicationCustomerPath =
    '/ExternalService/ApplicationCustomer';
const String externalServiceFeatureCustomerPath =
    '/ExternalService/FeatureCustomer';
const String sourceAttributePath = '/SourceAttributeMapping';
const String externalAttributePath = '/ExternalAttributeMapping';
const String sourceAttributebyServicePath = '/SourceAttributeMapping/Service';
const String externalAttributebyServicePath =
    '/ExternalAttributeMapping/Service';
const String securityPath = '/Security';
const String userPreferencePath = '/UserPreference';

const String mappingServicePath = '/MappingService';
const String apiMappingPath = '/ApiMapping';
const String masterServicePath = '/MasterService';
const String methodPath = '/Method';
const String dataTypePath = '/DataType';
const customerUserpath = '/CustomerUser';
const customerDevicepath = '/CustomerDevice';

const primaryColor = Color.fromARGB(255, 102, 187, 252);
const canvasColor = Color.fromARGB(255, 103, 103, 245);
const accentCanvasColor = Color.fromARGB(255, 176, 176, 242);
const white = Colors.white;
final actionColor = const Color.fromARGB(255, 127, 163, 195).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);

String getCurrentRouteOption(BuildContext context) {
  var isEmpty = ModalRoute.of(context) != null &&
          ModalRoute.of(context)!.settings.arguments != null &&
          ModalRoute.of(context)!.settings.arguments is String
      ? ModalRoute.of(context)!.settings.arguments as String
      : '';

  return isEmpty;
}
