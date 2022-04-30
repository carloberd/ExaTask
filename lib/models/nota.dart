class NoteFields {
  static final List<String> values = [
    id,
    title,
    number,
    description,
    priority,
    deadline
  ];

  static const String id = '_id';
  static const String title = 'title';
  static const String number = 'number';
  static const String description = 'description';
  static const String priority = 'priority';
  static const String deadline = 'deadline';
}

class Note {
  final int? id;
  final String title;
  final int number;
  final String description;
  final String priority;
  final DateTime deadline;

  const Note({
    this.id,
    required this.title,
    required this.number,
    required this.description,
    required this.priority,
    required this.deadline,
  });

  Note copy({
    int? id,
    String? title,
    int? number,
    String? description,
    String? priority,
    DateTime? deadline,
  }) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        number: number ?? this.number,
        description: description ?? this.description,
        priority: priority ?? this.priority,
        deadline: deadline ?? this.deadline,
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.title: title,
        NoteFields.number: number,
        NoteFields.description: description,
        NoteFields.priority: priority,
        NoteFields.deadline: deadline.toIso8601String(),
      };

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        title: json[NoteFields.title] as String,
        number: json[NoteFields.number] as int,
        description: json[NoteFields.description] as String,
        priority: json[NoteFields.priority] as String,
        deadline: DateTime.parse(json[NoteFields.deadline] as String),
      );
}
