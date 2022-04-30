String? validateTitle(String title) {
  if (title.isEmpty) {
    return 'Campo obbligatorio';
  }
  return null;
}

String? validateNumber(String number) {
  if (number.isEmpty) {
    return 'Campo obbligatorio';
  } else {
    RegExp num = RegExp(r'^\d{4,5}');
    if (!num.hasMatch(number)) {
      return 'Sono ammessi solo numeri';
    }
    if (number.length < 4) {
      return 'La lunghezza minima è 4';
    }
  }
  return null;
}

String? validateDescription(String description) {
  if (description.isEmpty) {
    return 'Campo obbligatorio';
  }
  return null;
}

String? validateDate(String date) {
  if (date.isEmpty) {
    return 'Campo obbligatorio';
  }
  return null;
}
