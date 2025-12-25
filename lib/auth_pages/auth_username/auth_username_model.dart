import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'auth_username_widget.dart' show AuthUsernameWidget;
import 'package:flutter/material.dart';

class AuthUsernameModel extends FlutterFlowModel<AuthUsernameWidget> {
  ///  Local state fields for this page.

  bool? usernameAlreadyExists = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Firestore Query - Query a collection] action in authUsername widget.
  UsersRecord? userDocument;
  // State field(s) for username widget.
  FocusNode? usernameFocusNode;
  TextEditingController? usernameTextController;
  String? Function(BuildContext, String?)? usernameTextControllerValidator;
  String? _usernameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Username is required';
    }

    if (val.length < 4) {
      return 'username must be atleast 4 characters long.';
    }

    if (!RegExp(kTextValidatorUsernameRegex).hasMatch(val)) {
      return 'Must start with a letter and can only contain letters, digits and - or _.';
    }
    return null;
  }

  // Stores action output result for [Firestore Query - Query a collection] action in username widget.
  UsersRecord? usernameAvailability;
  // Stores action output result for [Custom Action - getUniqueUsername] action in IconButton widget.
  String? uniqueUsername;

  @override
  void initState(BuildContext context) {
    usernameTextControllerValidator = _usernameTextControllerValidator;
  }

  @override
  void dispose() {
    usernameFocusNode?.dispose();
    usernameTextController?.dispose();
  }
}
