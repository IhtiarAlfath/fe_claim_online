// import 'package:flutter/material.dart';
// import 'dart:math' as math show pi;
// import 'package:collapsible_sidebar/collapsible_sidebar.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:claim_online/features/User/presentation/bloc/user_preference_bloc.dart';
// import 'package:claim_online/features/User/presentation/bloc/user_role/user_role_bloc.dart';
// import 'package:claim_online/features/User/presentation/pages/user_preference_page.dart';
// import 'package:claim_online/features/User/presentation/pages/user_role_page.dart';
// import 'package:claim_online/features/application/presentation/bloc/application/application_bloc.dart';
// import 'package:claim_online/features/application/presentation/bloc/apps/apps_bloc.dart';
// import 'package:claim_online/features/application/presentation/pages/application_page.dart';
// import 'package:claim_online/features/customer/presentation/bloc/client/client_bloc.dart';
// import 'package:claim_online/features/customer/presentation/bloc/customer/customer_bloc.dart';
// import 'package:claim_online/features/customer/presentation/bloc/license/license_bloc.dart';
// import 'package:claim_online/features/customer/presentation/pages/customer_page.dart';
// import 'package:claim_online/features/customer/presentation/pages/license_page.dart';
// import 'package:claim_online/features/external/presentation/bloc/external/external_bloc.dart';
// import 'package:claim_online/features/external/presentation/bloc/external_service/external_service_bloc.dart';
// import 'package:claim_online/features/external/presentation/pages/external_page.dart';
// import 'package:claim_online/features/home/presentation/bloc/home_bloc.dart';
// import 'package:claim_online/features/mapping/presentation/bloc/api_mapping/api_mapping_bloc.dart';
// import 'package:claim_online/features/mapping/presentation/bloc/mapping_service/mapping_service_bloc.dart';
// import 'package:claim_online/features/mapping/presentation/pages/api_mapping_page.dart';
// import 'package:claim_online/features/mapping/presentation/pages/mapping_service_page.dart';
// import 'package:claim_online/features/security/presentation/bloc/security_bloc.dart';
// import 'package:claim_online/features/security/presentation/pages/security_page.dart';
// import 'package:claim_online/features/source/presentation/bloc/source/source_bloc.dart';
// import 'package:claim_online/features/source/presentation/bloc/source_service/source_service_bloc.dart';
// import 'package:claim_online/features/source/presentation/pages/source_page.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Sidebar(context: context),
//     );
//   }
// }

// class Sidebar extends StatelessWidget {
//   Sidebar({super.key, required this.context});
//   BuildContext context;

//   String _headline = 'Dashboard';

//   AssetImage avatarImg = const AssetImage('images/asabri_icon.png');

//   List<CollapsibleItem> _generateItems() {
//     return [
//       // CollapsibleItem(
//       //   text: 'Dashboard',
//       //   icon: Icons.dashboard,
//       //   onPressed: () {
//       //     _headline = 'Dashboard';
//       //     context
//       //         .read<HomeBloc>()
//       //         .add(HomeEventChangeHeadline(headline: _headline));
//       //   },
//       //   isSelected: true,
//       // ),
//       CollapsibleItem(
//           text: 'Customer',
//           icon: Icons.list_alt_rounded,
//           onPressed: () {
//             _headline = 'Customer Menu';
//             context
//                 .read<HomeBloc>()
//                 .add(HomeEventChangeHeadline(headline: _headline));
//             context
//                 .read<CustomerBloc>()
//                 .add(const CustomerEventGetAllCustomer());

//             context.read<ClientBloc>().add(const ClientEventCustomer());
//           },
//           isSelected: true,
//           subItems: [
//             CollapsibleItem(
//               text: 'Customer',
//               icon: Icons.lan_rounded,
//               onPressed: () {
//                 _headline = 'Customer';
//                 context.read<ClientBloc>().add(const ClientEventCustomer());
//                 context
//                     .read<CustomerBloc>()
//                     .add(const CustomerEventGetAllCustomer());
//                 context
//                     .read<HomeBloc>()
//                     .add(HomeEventChangeHeadline(headline: _headline));
//               },
//               isSelected: true,
//             ),
//             CollapsibleItem(
//               text: 'License',
//               icon: Icons.loop_rounded,
//               onPressed: () {
//                 _headline = 'License';
//                 context
//                     .read<CustomerBloc>()
//                     .add(const CustomerEventGetAllCustomer());
//                 context
//                     .read<LicenseBloc>()
//                     .add(const LicenseEventGetAllLicense());
//                 context
//                     .read<HomeBloc>()
//                     .add(HomeEventChangeHeadline(headline: _headline));
//               },
//               isSelected: true,
//             ),
//           ]),
//       CollapsibleItem(
//         text: 'Application',
//         icon: Icons.app_registration_rounded,
//         onPressed: () {
//           context.read<AppsBloc>().add(const AppsEventApplication());
//           context
//               .read<ApplicationBloc>()
//               .add(const ApplicationEventGetAllApplication());
//           _headline = 'Application';
//           context
//               .read<HomeBloc>()
//               .add(HomeEventChangeHeadline(headline: _headline));
//         },
//       ),
//       CollapsibleItem(
//           text: 'Service',
//           icon: Icons.assessment,
//           onPressed: () {
//             context.read<SourceBloc>().add(const SourceEventSourceService());
//             context
//                 .read<SecurityBloc>()
//                 .add(const SecurityEventGetAllSecurity());
//             context
//                 .read<SourceServiceBloc>()
//                 .add(const SourceServiceEventGetAllSourceService());
//             _headline = 'Service';
//             context
//                 .read<HomeBloc>()
//                 .add(HomeEventChangeHeadline(headline: _headline));
//           },
//           isSelected: true,
//           subItems: [
//             CollapsibleItem(
//               text: 'Source Service',
//               icon: Icons.source_rounded,
//               onPressed: () {
//                 context
//                     .read<SourceBloc>()
//                     .add(const SourceEventSourceService());
//                 context
//                     .read<SecurityBloc>()
//                     .add(const SecurityEventGetAllSecurity());
//                 context
//                     .read<SourceServiceBloc>()
//                     .add(const SourceServiceEventGetAllSourceService());
//                 _headline = 'Source Service';
//                 context
//                     .read<HomeBloc>()
//                     .add(HomeEventChangeHeadline(headline: _headline));
//               },
//               isSelected: true,
//             ),
//             CollapsibleItem(
//               text: 'External Service',
//               icon: Icons.extension_rounded,
//               onPressed: () {
//                 context
//                     .read<ExternalBloc>()
//                     .add(const ExternalEventExternalService());
//                 context
//                     .read<SecurityBloc>()
//                     .add(const SecurityEventGetAllSecurity());
//                 context
//                     .read<ExternalServiceBloc>()
//                     .add(const ExternalServiceEventGetAllExternalService());
//                 _headline = 'External Service';
//                 context
//                     .read<HomeBloc>()
//                     .add(HomeEventChangeHeadline(headline: _headline));
//               },
//               isSelected: true,
//             ),
//           ]),
//       CollapsibleItem(
//           text: 'Mapping',
//           icon: Icons.api_rounded,
//           onPressed: () {
//             _headline = 'Mapping';
//             context
//                 .read<MappingServiceBloc>()
//                 .add(const MappingServiceEventGetAllMappingService());
//             context
//                 .read<SourceServiceBloc>()
//                 .add(const SourceServiceEventGetAllSourceService());
//             context
//                 .read<ExternalServiceBloc>()
//                 .add(const ExternalServiceEventGetAllExternalService());
//             context
//                 .read<HomeBloc>()
//                 .add(HomeEventChangeHeadline(headline: _headline));
//           },
//           isSelected: true,
//           subItems: [
//             CollapsibleItem(
//               text: 'Mapping Service',
//               icon: Icons.settings_applications_rounded,
//               onPressed: () {
//                 context
//                     .read<MappingServiceBloc>()
//                     .add(const MappingServiceEventGetAllMappingService());
//                 context
//                     .read<SourceServiceBloc>()
//                     .add(const SourceServiceEventGetAllSourceService());
//                 context
//                     .read<ExternalServiceBloc>()
//                     .add(const ExternalServiceEventGetAllExternalService());
//                 _headline = 'Mapping Service';
//                 context
//                     .read<HomeBloc>()
//                     .add(HomeEventChangeHeadline(headline: _headline));
//               },
//               isSelected: true,
//             ),
//             CollapsibleItem(
//               text: 'API Mapping',
//               icon: Icons.settings_applications_rounded,
//               onPressed: () {
//                 context
//                     .read<ApiMappingBloc>()
//                     .add(const ApiMappingEventGetAllApiMapping());
//                 context
//                     .read<SourceServiceBloc>()
//                     .add(const SourceServiceEventGetAllSourceService());
//                 context
//                     .read<ExternalServiceBloc>()
//                     .add(const ExternalServiceEventGetAllExternalService());
//                 _headline = 'API Mapping';
//                 context
//                     .read<HomeBloc>()
//                     .add(HomeEventChangeHeadline(headline: _headline));
//               },
//               isSelected: true,
//             ),
//           ]),
//       CollapsibleItem(
//           text: 'User',
//           icon: Icons.people_alt_rounded,
//           onPressed: () {
//             context
//                 .read<UserPreferenceBloc>()
//                 .add(const UserPreferenceEventGetAllUserPreference());
//             context
//                 .read<ApplicationBloc>()
//                 .add(const ApplicationEventGetAllApplication());
//             context
//                 .read<UserRoleBloc>()
//                 .add(const UserRoleEventGetAllUserRole());
//             _headline = 'User';
//             context
//                 .read<HomeBloc>()
//                 .add(HomeEventChangeHeadline(headline: _headline));
//           },
//           isSelected: true,
//           subItems: [
//             CollapsibleItem(
//               text: 'User Role',
//               icon: Icons.person,
//               onPressed: () {
//                 context
//                     .read<UserPreferenceBloc>()
//                     .add(const UserPreferenceEventGetAllUserPreference());
//                 context
//                     .read<ApplicationBloc>()
//                     .add(const ApplicationEventGetAllApplication());
//                 context
//                     .read<UserRoleBloc>()
//                     .add(const UserRoleEventGetAllUserRole());
//                 _headline = 'User Role';
//                 context
//                     .read<HomeBloc>()
//                     .add(HomeEventChangeHeadline(headline: _headline));
//               },
//               isSelected: true,
//             ),
//             CollapsibleItem(
//               text: 'User Preference',
//               icon: Icons.face,
//               onPressed: () {
//                 context
//                     .read<UserPreferenceBloc>()
//                     .add(const UserPreferenceEventGetAllUserPreference());
//                 _headline = 'User Preference';
//                 context
//                     .read<HomeBloc>()
//                     .add(HomeEventChangeHeadline(headline: _headline));
//               },
//               isSelected: true,
//             ),
//           ]),
//       CollapsibleItem(
//         text: 'Security',
//         icon: Icons.settings_accessibility_sharp,
//         onPressed: () {
//           _headline = 'Security';
//           context.read<SecurityBloc>().add(const SecurityEventGetAllSecurity());
//           context
//               .read<HomeBloc>()
//               .add(HomeEventChangeHeadline(headline: _headline));
//         },
//       ),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return SafeArea(
//       child: BlocBuilder<HomeBloc, HomeState>(
//         builder: (context, state) {
//           if (state is HomeStateChangeHeadline) {
//             _headline = state.headline;
//           } else {
//             _headline = 'Dashboard';
//           }
//           return CollapsibleSidebar(
//             isCollapsed: MediaQuery.of(context).size.width <= 800,
//             onTitleTap: () {
//               _headline = 'Dashboard';
//               context
//                   .read<HomeBloc>()
//                   .add(HomeEventChangeHeadline(headline: _headline));
//             },
//             items: _generateItems(),
//             collapseOnBodyTap: true,
//             avatarImg: avatarImg,
//             avatarBackgroundColor: Colors.white,
//             title: 'E-Corp Admin',
//             body: _body(size, context),
//             backgroundColor: Colors.black,
//             selectedTextColor: Colors.white,
//             unselectedTextColor: Colors.white,
//             selectedIconColor: Colors.white,
//             unselectedIconColor: Colors.white,
//             selectedIconBox: Colors.transparent,
//             iconSize: 34,
//             toggleTitle: '',
//             textStyle: const TextStyle(fontSize: 15),
//             titleStyle:
//                 const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             toggleTitleStyle:
//                 const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             sidebarBoxShadow: const [
//               BoxShadow(
//                 color: Colors.transparent,
//                 blurRadius: 20,
//                 spreadRadius: 0.01,
//                 offset: Offset(3, 3),
//               ),
//               BoxShadow(
//                 color: Colors.transparent,
//                 blurRadius: 50,
//                 spreadRadius: 0.01,
//                 offset: Offset(3, 3),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   Widget _body(Size size, BuildContext context) {
//     if (_headline == 'Dashboard') {
//       return ListView.builder(
//         padding: const EdgeInsets.only(top: 10),
//         itemBuilder: (context, index) => Container(
//           height: 100,
//           width: double.infinity,
//           margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             color: Theme.of(context).canvasColor,
//             boxShadow: const [BoxShadow()],
//           ),
//         ),
//       );
//     } else if (_headline == 'Customer Menu') {
//       return const CustomerPage();
//     } else if (_headline == 'Customer') {
//       return const CustomerPage();
//     } else if (_headline == 'License') {
//       return const LicensesPage();
//     } else if (_headline == 'Application') {
//       return const ApplicationPage();
//     } else if (_headline == 'Service') {
//       return const SourcePage();
//     } else if (_headline == 'Source Service') {
//       return const SourcePage();
//     } else if (_headline == 'External Service') {
//       return const ExternalPage();
//     } else if (_headline == 'Mapping') {
//       return const MappingServicePage();
//     } else if (_headline == 'Mapping Service') {
//       return const MappingServicePage();
//     } else if (_headline == 'API Mapping') {
//       return const ApiMappingPage();
//     } else if (_headline == 'User') {
//       return const UserRolePage();
//     } else if (_headline == 'User Role') {
//       return const UserRolePage();
//     } else if (_headline == 'User Preference') {
//       return const UserPreferencePage();
//     } else if (_headline == 'Security') {
//       return const SecurityPage();
//     } else {
//       return Container(
//         height: double.infinity,
//         width: double.infinity,
//         color: Colors.blueGrey[50],
//         child: Center(
//           child: Transform.rotate(
//             angle: math.pi / 2,
//             child: Transform.translate(
//               offset: Offset(-size.height * 0.3, -size.width * 0.23),
//               child: SelectableText(
//                 _headline,
//                 style: Theme.of(context).textTheme.displayLarge,
//                 overflow: TextOverflow.visible,
//                 softWrap: false,
//               ),
//             ),
//           ),
//         ),
//       );
//     }
//   }
// }
