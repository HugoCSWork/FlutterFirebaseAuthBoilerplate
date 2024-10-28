import 'package:auth_boilerplate/app/extensions/form_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void useFormValidation({
  required GlobalKey<FormState> formKey,
  List<TextEditingController> controllers = const [],
  required ValueNotifier<bool> hasSubmitted,
}) {
  final isValid = useState<bool>(false);

  useEffect(() {
    void validateForm() => Future.microtask(() => isValid.value = formKey.isFormValid);

    if (hasSubmitted.value) {
      for (var controller in controllers) {
        controller.addListener(validateForm);
      }

      validateForm();
    }

    return () {
      for (var controller in controllers) {
        controller.removeListener(validateForm);
      }
    };
  }, [formKey, controllers, hasSubmitted.value]);

  useEffect(() {
    return () {
      for (var controller in controllers) {
        controller.dispose();
      }
    };
  }, []);
}
