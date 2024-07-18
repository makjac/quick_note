import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

class ChecklistItem extends Equatable {
  const ChecklistItem({
    required this.id,
    this.title = "",
    this.isChecked = false,
  });

  @HiveField(0)
  final num id;
  @HiveField(10, defaultValue: "")
  final String title;
  @HiveField(20, defaultValue: false)
  final bool isChecked;

  ChecklistItem copyWith({String? title, bool? isChecked}) {
    return ChecklistItem(
      id: id,
      title: title ?? this.title,
      isChecked: isChecked ?? this.isChecked,
    );
  }

  @override
  List<Object?> get props => [id, title, isChecked];
}
