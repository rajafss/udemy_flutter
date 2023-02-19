

import 'package:flutter/material.dart';

class ArchiveTasksScreen extends StatelessWidget {
  const ArchiveTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
            'Archived Tasks',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.w600
          ),
        ),
    );
  }
}
