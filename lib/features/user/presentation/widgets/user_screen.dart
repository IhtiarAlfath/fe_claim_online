import 'package:claim_online/core/utils/constant.dart';
import 'package:claim_online/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:claim_online/features/user/domain/entities/data_user.dart';
import 'package:claim_online/features/user/domain/entities/data_user_role.dart';
import 'package:claim_online/features/user/presentation/bloc/user_bloc.dart';
import 'package:claim_online/features/user/presentation/widgets/add_user_dialog.dart';
import 'package:claim_online/features/user/presentation/widgets/user_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/function.dart';

class UserScreen extends StatelessWidget {
  UserScreen({
    super.key,
  });

  List<DataUser> user = [];
  List<DataUserRole> userRole = [];
  String customerName = '';
  String appCustomerName = '';

  TextEditingController searchUserC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.read<AuthenticationBloc>().add(AuthenticationEventEmpty());
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("User management"),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserStateSearchUser) {
            user = state.user;
          } else if (state is UserStateLoading) {
            return const LoadingWidget(
              color: primaryColor,
            );
          } else if (state is UserStateGetAllUser) {
            user = state.user;
          } else if (state is UserStateGetAllUserRole) {
            userRole = state.userRole;
            context.read<UserBloc>().add(const UserEventGetAllUser());
          }
          return BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, authstate) {
              if (authstate is AuthenticationStateRegister) {
                context.read<UserBloc>().add(const UserEventGetAllUser());
                context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationEventEmpty());
              }
            },
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: ElevatedButton(
                        onPressed: () {
                          addUserDialog(
                            context,
                            userRole, // dari Bloc atau state kamu
                            (request) {
                              // Kirim ke Bloc / API
                              context.read<AuthenticationBloc>().add(
                                  AuthenticationEventRegister(
                                      dataRegister: request));
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                        ),
                        child: const Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(right: 20),
                        child: TextField(
                          controller: searchUserC,
                          autocorrect: false,
                          onChanged: (value) =>
                              _searchUser(value, user, context),
                          style: const TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide.none),
                            hintText: 'Search...',
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: IconButton(
                                onPressed: () => _searchUser(
                                    searchUserC.text, user, context),
                                icon: const Icon(Icons.search_outlined)),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 25),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 234, 229, 229),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(10),
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state is UserStateLoading) {
                      return Text(
                        "Loading...",
                        style: theme.textTheme.headlineSmall,
                      );
                    } else if (state is UserStateGetAllUser) {
                      return UserTable(
                          userRoleList: userRole,
                          usersInfo: state.user,
                          isAscending: false,
                          sortIndex: 0);
                    } else if (state is UserStateSortUser) {
                      return UserTable(
                        userRoleList: userRole,
                        usersInfo: state.user,
                        isAscending: state.isAscending,
                        sortIndex: state.sortIndex,
                      );
                    } else if (state is UserStateAddUser) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        context
                            .read<UserBloc>()
                            .add(const UserEventGetAllUserRole());
                        context.pop();
                      });
                      return const LoadingWidget(color: primaryColor);
                    } else if (state is UserStateUpdateUser) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        context
                            .read<UserBloc>()
                            .add(const UserEventGetAllUserRole());
                        context.pop();
                      });
                      return const LoadingWidget(color: primaryColor);
                    } else if (state is UserStateSearchUser) {
                      return UserTable(
                        userRoleList: userRole,
                        usersInfo: state.user,
                        isAscending: false,
                        sortIndex: 0,
                      );
                    } else if (state is UserStateError) {
                      return Text(
                        state.message,
                        style: theme.textTheme.headlineSmall,
                      );
                    } else if (state is UserStateEmpty) {
                      return Text(
                        "empty",
                        style: theme.textTheme.headlineSmall,
                      );
                    } else {
                      return Text(
                        "$state",
                        style: theme.textTheme.headlineSmall,
                      );
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _searchUser(String text, List<DataUser> myUsers, BuildContext context) {
    List<DataUser> results = [];
    String nText = text.toLowerCase();

    if (text.isEmpty) {
      context.read<UserBloc>().add(const UserEventGetAllUser());
    } else {
      results = myUsers.where((customer) {
        String nName = customer.username.toLowerCase();
        String nUserId = customer.userId.toLowerCase();
        String nEmail = customer.email.toLowerCase();

        return nName.contains(nText) ||
            nUserId.contains(nText) ||
            nEmail.contains(nText);
      }).toList();

      context
          .read<UserBloc>()
          .add(UserEventSearchUser(inputSearch: nText, user: results));
    }
  }
}
