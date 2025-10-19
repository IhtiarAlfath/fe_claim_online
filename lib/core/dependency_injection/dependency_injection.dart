import 'package:claim_online/features/authentication/domain/usecases/register.dart';
import 'package:claim_online/features/claim/claim/data/datasources/claim_datasource_remote.dart';
import 'package:claim_online/features/claim/claim/data/repositories/claim_repositories_impl.dart';
import 'package:claim_online/features/claim/claim/domain/repositories/claim_repositories.dart';
import 'package:claim_online/features/claim/claim/domain/usecases/add_claim.dart';
import 'package:claim_online/features/claim/claim/domain/usecases/add_claim_document.dart';
import 'package:claim_online/features/claim/claim/domain/usecases/delete_claim_document.dart';
import 'package:claim_online/features/claim/claim/domain/usecases/get_all_claim.dart';
import 'package:claim_online/features/claim/claim/domain/usecases/get_all_claim_category.dart';
import 'package:claim_online/features/claim/claim/domain/usecases/get_claim_by_claim_id.dart';
import 'package:claim_online/features/claim/claim/domain/usecases/update_claim.dart';
import 'package:claim_online/features/claim/claim/domain/usecases/update_claim_status.dart';
import 'package:claim_online/features/claim/claim/presentation/bloc/claim/claim_bloc.dart';
import 'package:claim_online/features/claim/claim/presentation/bloc/claim_general/claim_general_bloc.dart';
import 'package:claim_online/features/claim/claim_category/data/datasources/claim_category_datasource_remote.dart';
import 'package:claim_online/features/claim/claim_category/data/repositories/claim_status_repositories_impl.dart';
import 'package:claim_online/features/claim/claim_category/domain/repositories/claim_category_repositories.dart';
import 'package:claim_online/features/claim/claim_category/domain/usecases/get_all_claim_category.dart';
import 'package:claim_online/features/claim/claim_category/presentation/bloc/claim_category_bloc.dart';
import 'package:claim_online/features/claim/claim_status/data/datasources/claim_status_datasource_remote.dart';
import 'package:claim_online/features/claim/claim_status/data/repositories/claim_status_repositories_impl.dart';
import 'package:claim_online/features/claim/claim_status/domain/repositories/claim_status_repositories.dart';
import 'package:claim_online/features/claim/claim_status/domain/usecases/get_all_claim_status.dart';
import 'package:claim_online/features/claim/claim_status/presentation/bloc/claim_status_bloc.dart';
import 'package:claim_online/features/user/data/repositories/user_repositories_impl.dart';
import 'package:claim_online/features/user/domain/repositories/user_repositories.dart';
import 'package:claim_online/features/user/domain/usecases/get_all_user.dart';
import 'package:claim_online/features/user/domain/usecases/get_all_user_role.dart';
import 'package:claim_online/features/user/domain/usecases/update_user.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:claim_online/features/authentication/data/datasources/authentication_datasource_remote.dart';
import 'package:claim_online/features/authentication/data/repositories/authentication_repositories_impl.dart';
import 'package:claim_online/features/authentication/domain/repositories/authentication_repositories.dart';
import 'package:claim_online/features/authentication/domain/usecases/login.dart';
import 'package:claim_online/features/authentication/presentation/bloc/authentication_bloc.dart';
import '../../features/user/data/datasources/user_datasource_remote.dart';
import '../../features/user/presentation/bloc/user_bloc.dart';
import '../services/network_services.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependecyInjection() async {
  serviceLocator.registerFactory(
    () => AuthenticationBloc(
      login: serviceLocator.call(),
      register: serviceLocator.call(),
    ),
  );

  serviceLocator.registerLazySingleton<Login>(() => Login(
        authenticationRepositories: serviceLocator.call(),
      ));
  serviceLocator.registerLazySingleton<Register>(() => Register(
        authenticationRepositories: serviceLocator.call(),
      ));

  serviceLocator.registerLazySingleton<AuthenticationRepositories>(
      () => AuthenticationRepositoriesImpl(
            authenticationDatasourceRemote: serviceLocator.call(),
            networkServices: serviceLocator.call(),
          ));
  serviceLocator.registerLazySingleton<AuthenticationDatasourceRemote>(
      () => AuthenticationDatasourceRemoteImpl(
            client: serviceLocator.call(),
          ));

  serviceLocator.registerFactory(() => UserBloc(
        getAllUserRole: serviceLocator.call(),
        getAllUser: serviceLocator.call(),
        updateUser: serviceLocator.call(),
      ));

  serviceLocator.registerLazySingleton<GetAllUserRole>(
      () => GetAllUserRole(userRepositories: serviceLocator.call()));
  serviceLocator.registerLazySingleton<GetAllUser>(
      () => GetAllUser(userRepositories: serviceLocator.call()));
  serviceLocator.registerLazySingleton<UpdateUser>(
      () => UpdateUser(userRepositories: serviceLocator.call()));

  serviceLocator.registerLazySingleton<UserRepositories>(() =>
      UserRepositoriesImpl(
          networkServices: serviceLocator.call(),
          userDatasourceRemote: serviceLocator.call()));

  serviceLocator.registerLazySingleton<UserDatasourceRemote>(
      () => UserDatasourceRemoteImpl(client: serviceLocator.call()));

  serviceLocator.registerFactory(() => ClaimStatusBloc(
        getAllClaimStatus: serviceLocator.call(),
      ));

  serviceLocator.registerLazySingleton<GetAllClaimStatus>(
      () => GetAllClaimStatus(claimStatusRepositories: serviceLocator.call()));

  serviceLocator.registerLazySingleton<ClaimStatusDatasourceRemote>(
      () => ClaimStatusDatasourceRemoteImpl(client: serviceLocator.call()));

  serviceLocator.registerLazySingleton<ClaimStatusRepositories>(() =>
      ClaimStatusRepositoriesImpl(
          claimStatusDatasourceRemote: serviceLocator.call(),
          networkServices: serviceLocator.call()));

  serviceLocator.registerFactory(() => ClaimCategoryBloc(
        getAllClaimCategory: serviceLocator.call(),
      ));

  serviceLocator.registerLazySingleton<GetAllClaimCategory>(() =>
      GetAllClaimCategory(claimCategoryRepositories: serviceLocator.call()));

  serviceLocator.registerLazySingleton<ClaimCategoryRepositories>(() =>
      ClaimCategoryRepositoriesImpl(
          claimCategoryDatasourceRemote: serviceLocator.call(),
          networkServices: serviceLocator.call()));

  serviceLocator.registerLazySingleton<ClaimCategoryDatasourceRemote>(
      () => ClaimCategoryDatasourceRemoteImpl(client: serviceLocator.call()));

  serviceLocator.registerFactory(() => ClaimBloc(
        getAllClaim: serviceLocator.call(),
        getClaimByuserid: serviceLocator.call(),
        getClaimByClaimId: serviceLocator.call(),
        addClaim: serviceLocator.call(),
        addClaimDocument: serviceLocator.call(),
        deleteClaimDocument: serviceLocator.call(),
        updateClaim: serviceLocator.call(),
        updateClaimStatus: serviceLocator.call(),
      ));

  serviceLocator.registerLazySingleton<GetAllClaim>(
      () => GetAllClaim(claimRepositories: serviceLocator.call()));

  serviceLocator.registerLazySingleton<GetClaimByuserid>(
      () => GetClaimByuserid(claimRepositories: serviceLocator.call()));

  serviceLocator.registerLazySingleton<GetClaimByClaimId>(
      () => GetClaimByClaimId(claimRepositories: serviceLocator.call()));

  serviceLocator.registerLazySingleton<AddClaim>(
      () => AddClaim(claimRepositories: serviceLocator.call()));

  serviceLocator.registerLazySingleton<AddClaimDocument>(
      () => AddClaimDocument(claimRepositories: serviceLocator.call()));
  serviceLocator.registerLazySingleton<DeleteClaimDocument>(
      () => DeleteClaimDocument(claimRepositories: serviceLocator.call()));

  serviceLocator.registerLazySingleton<UpdateClaim>(
      () => UpdateClaim(claimRepositories: serviceLocator.call()));
  serviceLocator.registerLazySingleton<UpdateClaimStatus>(
      () => UpdateClaimStatus(claimRepositories: serviceLocator.call()));

  serviceLocator.registerLazySingleton<ClaimRepositories>(() =>
      ClaimRepositoriesImpl(
          claimDatasourceRemote: serviceLocator.call(),
          networkServices: serviceLocator.call()));

  serviceLocator.registerLazySingleton<ClaimDatasourceRemote>(
      () => ClaimDatasourceRemoteImpl(client: serviceLocator.call()));

  serviceLocator.registerFactory(() => ClaimGeneralBloc());

  serviceLocator.registerLazySingleton(() => http.Client());

  serviceLocator
      .registerLazySingleton<NetworkServices>(() => NetworkServicesImpl(
            connectivity: serviceLocator.call(),
          ));

  serviceLocator.registerLazySingleton(() => Connectivity());
}
