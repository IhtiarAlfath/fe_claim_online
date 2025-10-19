import 'package:claim_online/core/utils/constant.dart';
import 'package:claim_online/features/user/data/models/data_user_role_model.dart';
import 'package:claim_online/features/user/domain/entities/data_user.dart';
import 'package:claim_online/features/user/domain/entities/data_user_role.dart';
import 'package:claim_online/features/user/presentation/bloc/user_bloc.dart';
import 'package:claim_online/features/user/presentation/widgets/edit_user_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

class UserTable extends StatelessWidget {
  UserTable({
    super.key,
    required this.userRoleList,
    required this.usersInfo,
    required this.isAscending,
    required this.sortIndex,
  });

  List<DataUserRole> userRoleList;
  List<DataUser> usersInfo;
  int sortIndex;
  bool isAscending;

  int sortUserId = 1;
  int sortUsername = 2;
  int sortRole = 3;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: HorizontalDataTable(
        leftHandSideColumnWidth: 80,
        rightHandSideColumnWidth: MediaQuery.of(context).size.width,
        isFixedHeader: true,
        headerWidgets: _getTitleCustomerWidget(context),
        leftSideItemBuilder: _generateFirstCustomerColumnRow,
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: usersInfo.length,
        rowSeparatorWidget: const Divider(
          color: Colors.black54,
          height: 1.0,
          thickness: 0.0,
        ),
        leftHandSideColBackgroundColor: const Color(0xFFFFFFFF),
        rightHandSideColBackgroundColor: const Color(0xFFFFFFFF),
      ),
    );
  }

  Widget _getTitleCustomerItemWidget(String label, double width) {
    return Container(
      width: width,
      height: 56,
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: SelectableText(label,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black)),
    );
  }

  Widget _generateFirstCustomerColumnRow(BuildContext context, int index) {
    return Container(
      width: 80,
      height: 52,
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: SelectableText((index + 1).toString()),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Material(
      color: Colors.transparent,
      child: Row(
        children: <Widget>[
          Container(
            width: 180,
            height: 52,
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: SelectableText(usersInfo[index].userId),
          ),
          Container(
            width: 250,
            height: 52,
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: SelectableText(usersInfo[index].username),
          ),
          Container(
            width: 250,
            height: 52,
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: SelectableText(usersInfo[index].email),
          ),
          Container(
            width: 150,
            height: 52,
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: SelectableText(
              userRoleList
                  .firstWhere(
                      (e) => e.userRoleId.toString() == usersInfo[index].roleId,
                      orElse: () => DataUserRoleModel(
                          userRoleId_: usersInfo[index].roleId,
                          userRoleName_: usersInfo[index].roleId))
                  .userRoleName,
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            width: 150,
            height: 52,
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: () {
                editUserDialog(
                  context,
                  datauser: usersInfo[index],
                  roleList: userRoleList,
                  onSubmit: (updatedUser) {
                    // kirim ke Bloc
                    context
                        .read<UserBloc>()
                        .add(UserEventUpdateUser(datauser:updatedUser));
                  },
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
              child: const Text('Edit', style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _getTitleCustomerWidget(BuildContext context) {
    return [
      _getTitleCustomerItemWidget('No', 80),
      TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.transparent,
          padding: EdgeInsets.zero,
        ),
        child: _getTitleCustomerItemWidget(
            'User Id${sortIndex == sortUserId ? (isAscending ? '↓' : '↑') : ''}',
            180),
        onPressed: () {
          sortIndex = sortUserId;
          isAscending = !isAscending;
          context.read<UserBloc>().add(UserEventSortUser(
              user: _sortUserId(isAscending),
              isAscending: isAscending,
              sortIndex: sortIndex));
        },
      ),
      TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.transparent,
          padding: EdgeInsets.zero,
        ),
        child: _getTitleCustomerItemWidget(
            'Username${sortIndex == sortUsername ? (isAscending ? '↓' : '↑') : ''}',
            250),
        onPressed: () {
          sortIndex = sortUsername;
          isAscending = !isAscending;
          context.read<UserBloc>().add(UserEventSortUser(
              user: _sortUsername(isAscending),
              isAscending: isAscending,
              sortIndex: sortIndex));
        },
      ),
      _getTitleCustomerItemWidget('Email', 180),
      TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.transparent,
          padding: EdgeInsets.zero,
        ),
        child: _getTitleCustomerItemWidget(
            'Role${sortIndex == sortRole ? (isAscending ? '↓' : '↑') : ''}',
            250),
        onPressed: () {
          sortIndex = sortRole;
          isAscending = !isAscending;
          context.read<UserBloc>().add(UserEventSortUser(
              user: _sortRole(isAscending),
              isAscending: isAscending,
              sortIndex: sortIndex));
        },
      ),
      _getTitleCustomerItemWidget('Edit', 150),
    ];
  }

  List<DataUser> _sortUsername(bool isAscending) {
    if (isAscending) {
      usersInfo.sort(
        (a, b) {
          String val1 = a.username;
          String val2 = b.username;
          return val1.compareTo(val2);
        },
      );
      return usersInfo;
    } else {
      return usersInfo.reversed.toList();
    }
  }

  List<DataUser> _sortUserId(bool isAscending) {
    if (isAscending) {
      usersInfo.sort(
        (a, b) {
          String val1 = a.userId;
          String val2 = b.userId;
          return val1.compareTo(val2);
        },
      );
      return usersInfo;
    } else {
      return usersInfo.reversed.toList();
    }
  }

  List<DataUser> _sortRole(bool isAscending) {
    if (isAscending) {
      usersInfo.sort(
        (a, b) {
          String val1 = a.roleId;
          String val2 = b.roleId;
          return val1.compareTo(val2);
        },
      );
      return usersInfo;
    } else {
      return usersInfo.reversed.toList();
    }
  }
}
