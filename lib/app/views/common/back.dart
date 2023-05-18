import 'package:flutter/material.dart';

import '../../router/screen.dart';

class Back extends IconButton {
  Back(BuildContext context, String route, {super.key})
      : super(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Screen.set(context, route),
        );
}
