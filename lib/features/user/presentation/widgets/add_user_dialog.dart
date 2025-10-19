import 'package:claim_online/core/utils/function.dart';
import 'package:claim_online/features/user/domain/entities/data_user_role.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:claim_online/features/authentication/domain/entities/data_register.dart';

Future<void> addUserDialog(
  BuildContext context,
  List<DataUserRole> roleList, // list dropdown role
  void Function(DataRegister request) onSubmit,
) async {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  DataUserRole? selectedRole;

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            backgroundColor: Colors.white,
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
                      child: Icon(Icons.person_add_alt_1_rounded,
                          color: Colors.blueAccent, size: 50),
                    ),
                    const SizedBox(height: 8),
                    const Center(
                      child: Text(
                        'Add New User',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    const Gap(20),
                    const Text('Username',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: 'Enter username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const Gap(16),
                    const Text('Email',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: 'Enter email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const Gap(16),
                    const Text('Password',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: 'Enter password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const Gap(16),
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
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                        ),
                        dropdownColor: Colors.grey[100],
                        hint: const Text('Select role'),
                        items: roleList.map((role) {
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
                                passwordController.text.trim().isEmpty ||
                                selectedRole == null) {
                              showPopupNotification(
                                  context, 'Please fill all fields.');
                              return;
                            }

                            final request = DataRegister(
                              username: usernameController.text.trim(),
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              roleId: selectedRole!.userRoleId.toString(),
                            );

                            onSubmit(request);
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
