import 'package:flutter/material.dart';
import 'package:social/shared/components/components.dart';

class AddPost extends StatelessWidget {
  const AddPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: 'Add Post',
        whatLeading: true,
      ),
    );
  }
}
