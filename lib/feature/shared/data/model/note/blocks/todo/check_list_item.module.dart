// ignore_for_file: must_be_immutable

import 'package:hive/hive.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/check_list_item.dart';

part 'check_list_item.module.g.dart';

@HiveType(typeId: 5)
class ChecklistItemModel extends ChecklistItem with HiveObjectMixin {
  ChecklistItemModel({
    required super.id,
    super.title = "",
    super.isChecked = false,
  });

  factory ChecklistItemModel.fromEntity(ChecklistItem item) {
    return ChecklistItemModel(
      id: item.id,
      title: item.title,
      isChecked: item.isChecked,
    );
  }

  factory ChecklistItemModel.fromJson(Map<String, dynamic> json) {
    return ChecklistItemModel(
      id: json['id'] as num,
      title: json['title'] as String? ?? "",
      isChecked: json['isChecked'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isChecked': isChecked,
    };
  }

  @override
  List<Object?> get props => [id, title, isChecked];
}
