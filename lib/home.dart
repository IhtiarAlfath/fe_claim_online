import 'package:claim_online/features/claim/claim/presentation/bloc/claim/claim_bloc.dart';
import 'package:claim_online/features/claim/claim/presentation/bloc/claim_general/claim_general_bloc.dart';
import 'package:claim_online/features/claim/claim/presentation/pages/claim_page.dart';
import 'package:claim_online/features/user/presentation/bloc/user_bloc.dart';
import 'package:claim_online/features/user/presentation/pages/user_management_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:claim_online/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'core/utils/constant.dart';
import 'core/utils/function.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      key: _key,
      appBar: isSmallScreen
          ? AppBar(
              backgroundColor: canvasColor,
              title: Text(getTitleByIndex(_controller.selectedIndex)),
              leading: IconButton(
                onPressed: () {
                  // if (!Platform.isAndroid && !Platform.isIOS) {
                  //   _controller.setExtended(true);
                  // }
                  _key.currentState?.openDrawer();
                },
                icon: const Icon(Icons.menu),
              ),
            )
          : null,
      drawer: Sidebar(controller: _controller),
      body: Row(
        children: [
          if (!isSmallScreen) Sidebar(controller: _controller),
          Expanded(
            child: Center(
              child: Screens(
                controller: _controller,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class Sidebar extends StatelessWidget {
  const Sidebar({
    super.key,
    required SidebarXController controller,
  }) : _controller = controller;

  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    final List<SidebarXItem> sidebarItems = [
      SidebarXItem(
        icon: Icons.message_outlined,
        label: 'Claim',
        onTap: () {
          if (userRole == 1 || userRole == 2) {
            context.read<ClaimBloc>().add(const ClaimEventGetAllClaim());
          } else {
            context.read<ClaimBloc>().add(const ClaimEventGetClaimByUserId());
          }
          context
              .read<ClaimGeneralBloc>()
              .add(const ClaimGeneralEventClaimSummary());
        },
      ),
    ];

    if (userRole == 1) {
      sidebarItems.add(
        SidebarXItem(
          icon: Icons.person,
          label: 'User Management',
          onTap: () {
            context.read<UserBloc>().add(const UserEventGetAllUserRole());
          },
        ),
      );
    }

    // 🔹 Item Logout selalu muncul
    sidebarItems.add(
      SidebarXItem(
        icon: Icons.logout,
        label: 'Logout',
        onTap: () {
          context
              .read<AuthenticationBloc>()
              .add(const AuthenticationEventLogout());
          context.goNamed('loginpage');
        },
      ),
    );

    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: canvasColor,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: const Color.fromARGB(255, 185, 185, 239),
        textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        hoverTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: canvasColor),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: actionColor.withOpacity(0.37),
          ),
          gradient: const LinearGradient(
            colors: [accentCanvasColor, canvasColor],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: canvasColor,
        ),
      ),
      footerDivider: divider,
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
            child: Image.asset('assets/images/asabri_icon.png'),
          ),
        );
      },
      items: sidebarItems,
    );
  }
}

class Screens extends StatelessWidget {
  const Screens({
    super.key,
    required this.controller,
  });

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final pageTitle = getTitleByIndex(controller.selectedIndex);
        switch (controller.selectedIndex) {
          case 0:
            return const ClaimPage();
          case 1:
            return const UserManagementPage();
          default:
            return Text(
              pageTitle,
              style: theme.textTheme.headlineSmall,
            );
        }
      },
    );
  }
}
