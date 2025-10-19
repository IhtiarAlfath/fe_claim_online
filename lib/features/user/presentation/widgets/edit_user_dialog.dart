import 'package:claim_online/features/user/data/models/data_user_role_model.dart';
import 'package:claim_online/features/user/domain/entities/data_user.dart';
import 'package:claim_online/features/user/domain/entities/data_user_role.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:claim_online/features/authentication/domain/entities/data_register.dart';

Future<void> editUserDialog(
  BuildContext context, {
  required DataUser datauser,
  required List<DataUserRole> roleList,
  required void Function(DataUser updatedUser) onSubmit,
}) async {
  final TextEditingController usernameController =
      TextEditingController(text: datauser.username);
  final TextEditingController emailController =
      TextEditingController(text: datauser.email);

  List<DataUserRole> userRole = [];
  for (var role in roleList) {
    userRole.add(DataUserRole(
        userRoleId: role.userRoleId, userRoleName: role.userRoleName));
  }

  DataUserRole? selectedRole = userRole.firstWhere(
    (r) => r.userRoleId.toString() == datauser.roleId,
    orElse: () => userRole.isNotEmpty
        ? userRole.first
        : DataUserRole(
            userRoleId: datauser.roleId,
            userRoleName: datauser.roleId,
          ),
  );

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            insetPadding: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Icon(Icons.edit_rounded,
                          color: Colors.blueAccent, size: 50),
                    ),
                    const SizedBox(height: 8),
                    const Center(
                      child: Text(
                        'Edit User',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    const Gap(20),

                    // Username field
                    const Text('Username',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const Gap(16),

                    // Email field
                    const Text('Email',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const Gap(16),

                    // Role dropdown
                    const Text('Role',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Theme(
                      data:
                          Theme.of(context).copyWith(canvasColor: Colors.white),
                      child: DropdownButtonFormField<DataUserRole>(
                        value: selectedRole,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                        ),
                        dropdownColor: Colors.white,
                        hint: const Text('Select role'),
                        items: userRole.map((role) {
                          return DropdownMenuItem<DataUserRole>(
                            value: role,
                            child: Text(role.userRoleName),
                          );
                        }).toList(),
                        onChanged: (val) => setState(() {
                          selectedRole = val;
                        }),
                      ),
                    ),
                    const Gap(24),

                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel',
                              style: TextStyle(color: Colors.grey)),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            if (usernameController.text.trim().isEmpty ||
                                emailController.text.trim().isEmpty ||
                                selectedRole == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please fill all fields.'),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                              return;
                            }

                            final updatedUser = DataUser(
                              username: usernameController.text.trim(),
                              email: emailController.text.trim(),
                              userId: datauser.userId, // password tidak diubah
                              roleId: selectedRole!.userRoleId.toString(),
                            );

                            onSubmit(updatedUser);
                            Navigator.pop(context);
                          },
                          child: const Text('Submit'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
