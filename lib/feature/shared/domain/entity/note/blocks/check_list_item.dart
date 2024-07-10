import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'check_list_item.g.dart';

@HiveType(typeId: 5)
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

  @override
  List<Object?> get props => [id, title, isChecked];
}
