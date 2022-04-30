import 'package:exa_task/models/nota.dart';
import 'package:exa_task/services/note.service.dart';
import 'package:exa_task/services/validator.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'package:exa_task/utils/toast.util.dart';

class NewNote extends StatefulWidget {
  const NewNote({Key? key}) : super(key: key);

  @override
  State<NewNote> createState() => _NewNoteState();
}

enum PrioritiesEnum { low, medium, high, asap }

class _NewNoteState extends State<NewNote> {
  static final priorities = ['Low', 'Medium', 'High', 'ASAP'];
  PrioritiesEnum? priority = PrioritiesEnum.low;
  DateTime? newDate;
  int? id;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  String? titleError;
  String? numberError;
  String? descriptionError;
  String? dateError;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      try {
        final nota = ModalRoute.of(context)?.settings.arguments as Note;
        titleController.text = nota.title;
        numberController.text = nota.number.toString();
        descriptionController.text = nota.description;
        dateController.text = nota.deadline.toIso8601String().substring(0, 10);

        setState(() => priority = PrioritiesEnum.values.firstWhere(
              (e) => e.name == nota.priority.toLowerCase(),
            ));
        setState(() => id = nota.id);
      } catch (e) {
        print('Null');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff353334),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: Row(
                  children: const [
                    Text(
                      'Nuova nota',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              GridView.count(
                scrollDirection: Axis.vertical,
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 20,
                shrinkWrap: true,
                childAspectRatio: (10 / 2),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: TextField(
                      controller: titleController,
                      style: const TextStyle(color: Colors.white),
                      onChanged: (e) => validateTitle(titleController.text),
                      decoration: InputDecoration(
                        fillColor: const Color(0xff26292b),
                        filled: true,
                        labelText: 'Titolo',
                        errorText: titleError,
                        errorStyle: const TextStyle(
                          color: Color.fromARGB(255, 239, 95, 85),
                        ),
                        labelStyle: const TextStyle(
                          color: Color(0x64ffffff),
                        ),
                        hintStyle: const TextStyle(
                          color: Color(0x24ffffff),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 239, 95, 85),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Color(0x46079be3),
                            width: 2,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: TextField(
                      controller: numberController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      onChanged: (e) => validateNumber(numberController.text),
                      decoration: InputDecoration(
                        prefix: const Text('#'),
                        fillColor: const Color(0xff26292b),
                        filled: true,
                        labelText: 'Numero issue',
                        errorText: numberError,
                        errorStyle: const TextStyle(
                          color: Color.fromARGB(255, 239, 95, 85),
                        ),
                        labelStyle: const TextStyle(
                          color: Color(0x64ffffff),
                        ),
                        hintStyle: const TextStyle(
                          color: Color(0x24ffffff),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 239, 95, 85),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Color(0x46079be3),
                            width: 2,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  TextField(
                    controller: descriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                    style: const TextStyle(color: Colors.white),
                    onChanged: (e) =>
                        validateDescription(descriptionController.text),
                    decoration: InputDecoration(
                      fillColor: const Color(0xff26292b),
                      filled: true,
                      labelText: 'Descrizione',
                      errorText: descriptionError,
                      errorStyle: const TextStyle(
                        color: Color.fromARGB(255, 239, 95, 85),
                      ),
                      labelStyle: const TextStyle(
                        color: Color(0x64ffffff),
                      ),
                      hintStyle: const TextStyle(
                        color: Color(0x24ffffff),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 239, 95, 85),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: Color(0x46079be3),
                          width: 2,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  TextField(
                    controller: dateController,
                    style: const TextStyle(color: Colors.white),
                    onChanged: (e) => validateDate(dateController.text),
                    readOnly: true,
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return SingleChildScrollView(
                            child: AlertDialog(
                              content: SizedBox(
                                height: 400,
                                width: 400,
                                child: SfDateRangePicker(
                                  onSelectionChanged: _onSelectionChanged,
                                  selectionMode:
                                      DateRangePickerSelectionMode.single,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Chiudi',
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      dateController.text =
                                          DateFormat('yyyy-MM-dd')
                                              .format(newDate!);
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Conferma',
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                    decoration: InputDecoration(
                      fillColor: const Color(0xff26292b),
                      filled: true,
                      labelText: 'Deadline',
                      errorText: dateError,
                      errorStyle: const TextStyle(
                        color: Color.fromARGB(255, 239, 95, 85),
                      ),
                      labelStyle: const TextStyle(
                        color: Color(0x64ffffff),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 239, 95, 85),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: Color(0x46079be3),
                          width: 2,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      suffixIcon: const MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Icon(
                          CupertinoIcons.calendar,
                          color: Color(0xff079be3),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.2,
                    child: ListTile(
                      title: Text(
                        priorities[0],
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      leading: Radio(
                        value: PrioritiesEnum.low,
                        groupValue: priority,
                        onChanged: (PrioritiesEnum? value) {
                          setState(() {
                            priority = value;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.2,
                    child: ListTile(
                      title: Text(
                        priorities[1],
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      leading: Radio(
                        value: PrioritiesEnum.medium,
                        groupValue: priority,
                        onChanged: (PrioritiesEnum? value) {
                          setState(() {
                            priority = value;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.2,
                    child: ListTile(
                      title: Text(
                        priorities[2],
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      leading: Radio(
                        value: PrioritiesEnum.high,
                        groupValue: priority,
                        onChanged: (PrioritiesEnum? value) {
                          setState(() {
                            priority = value;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.2,
                    child: ListTile(
                      title: Text(
                        priorities[3],
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      leading: Radio(
                        value: PrioritiesEnum.asap,
                        groupValue: priority,
                        onChanged: (PrioritiesEnum? value) {
                          setState(() {
                            priority = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        bool res = validateForm();
                        if (res) {
                          int index = priority!.index;
                          String newPriority = priorities[index];
                          Note nota = Note(
                            id: id,
                            title: titleController.text,
                            number: int.parse(numberController.text),
                            description: descriptionController.text,
                            priority: newPriority,
                            deadline: DateTime.parse(dateController.text),
                          );
                          if (id != null) {
                            int res = await update(nota);
                            if (res != -1) {
                              Navigator.pop(context, true);
                            } else {
                              showErrorToast(context);
                            }
                          } else {
                            int res = await create(nota);
                            if (res == 1) {
                              Navigator.pop(context, true);
                            } else {
                              showErrorToast(context);
                            }
                          }
                        }
                      },
                      child: const Text('Salva'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onSelectionChanged(DateRangePickerSelectionChangedArgs date) {
    setState(() {
      DateTime dateToSelect = DateTime.parse(date.value.toString());
      newDate = dateToSelect;
    });
  }

  bool validateForm() {
    setState(() {
      titleError = null;
      numberError = null;
      descriptionError = null;
      dateError = null;
    });
    titleError = validateTitle(titleController.text);
    numberError = validateNumber(numberController.text);
    descriptionError = validateDescription(descriptionController.text);
    dateError = validateDate(dateController.text);
    if (titleError != null ||
        numberError != null ||
        descriptionError != null ||
        dateError != null) {
      return false;
    } else {
      return true;
    }
  }
}
