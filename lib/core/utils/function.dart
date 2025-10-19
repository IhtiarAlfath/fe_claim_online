import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:intl/intl.dart';

int userRole = 0;

void logInfo(String? logInfo) {
  if (kDebugMode) {
    print(logInfo);
  }
}

String getTitleByIndex(int index) {
  switch (index) {
    case 0:
      return 'Claim';
    case 1:
      return 'User Management';
    default:
      return 'Not found page';
  }
}

void showPopupNotification(BuildContext context, String message) {
  final snackBar = SnackBar(
    backgroundColor: Colors.white,
    elevation: 10,
    margin: const EdgeInsets.all(20.0),
    padding: const EdgeInsets.all(15.0),
    behavior: SnackBarBehavior.floating,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15),
        bottom: Radius.circular(15),
      ),
    ),
    content: Text(
      message,
      style: const TextStyle(
        color: Color.fromARGB(255, 30, 11, 124),
        fontSize: 16,
      ),
    ),
    duration:
        const Duration(seconds: 3), // Durasi tampilan notifikasi (opsional)
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.progressiveDots(
        color: color,
        size: 60,
      ),
    );
  }
}

Future<dynamic> alertDialogDropdown(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Empty Dropdown value!',
          style: TextStyle(
            color: Colors.red,
            fontSize: 28,
          ),
        ),
        content: const Text(
          'Dropdown cannot be empty',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }
  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  if (!emailRegex.hasMatch(value)) {
    return 'Enter a valid email';
  }
  return null;
}

String convDateTaskAssignmentyyyyMMdd(String date) {
  var splitDate = date.split(' ');
  late DateTime newDateTime;

  if (splitDate[0].length == 8) {
    int year = int.parse(date.substring(0, 4));
    int month = int.parse(date.substring(4, 6));
    int day = int.parse(date.substring(6, 8));
    newDateTime = DateTime(year, month, day);
  } else {
    throw const FormatException("Invalid date format");
  }

  String stringDate = DateFormat('dd/MM/yyyy').format(newDateTime);
  return '$stringDate ${splitDate[1]}';
}
