import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

showSuccessToast(BuildContext context) {
  MotionToast.success(
    title: const Text("Successo"),
    description: const Text(
      "Nota creata correttamente",
    ),
  ).show(context);
}

showEditToast(BuildContext context) {
  MotionToast.success(
    title: const Text("Successo"),
    description: const Text(
      "Nota modificata correttamente",
    ),
  ).show(context);
}

showErrorToast(BuildContext context) {
  MotionToast.error(
    title: const Text("Errore"),
    description: const Text("Errore nella creazione della nota"),
  ).show(context);
}

showDeleteToast(BuildContext context) {
  MotionToast.delete(
    title: const Text("Eliminato"),
    description: const Text("Nota eliminata correttamente"),
  ).show(context);
}
