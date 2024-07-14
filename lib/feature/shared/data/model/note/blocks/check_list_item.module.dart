// ignore_for_file: must_be_immutable

import 'package:hive/hive.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/check_list_item.dart';

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

  @override
  List<Object?> get props => [id, title, isChecked];
}
