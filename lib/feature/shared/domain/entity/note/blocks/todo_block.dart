import 'package:hive/hive.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/check_list_item.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';

class TodoBlock extends NoteBlock {
  const TodoBlock({
    required super.id,
    super.title = "",
    super.hasTitle = true,
    super.type = NoteBlockType.todo,
    required this.items,
    this.showCompleteTasks = false,
    this.showProgressBar = false,
    this.maxVisibleTasks,
    this.dedline,
  });

  final List<ChecklistItem> items;

  @HiveField(30, defaultValue: false)
  final bool showCompleteTasks;

  @HiveField(40, defaultValue: false)
  final bool showProgressBar;

  @HiveField(50, defaultValue: null)
  final int? maxVisibleTasks;

  @HiveField(60, defaultValue: null)
  final DateTime? dedline;

  TodoBlock copyWith({
    num? id,
    String? title,
    bool? hasTitle,
    List<ChecklistItem>? items,
    bool? showCompleteTasks,
    bool? showProgressBar,
    int? maxVisibleTasks,
    DateTime? dedline,
  }) {
    return TodoBlock(
      id: id ?? this.id,
      title: title ?? this.title,
      hasTitle: hasTitle ?? this.hasTitle,
      items: items ?? this.items,
      showCompleteTasks: showCompleteTasks ?? this.showCompleteTasks,
      showProgressBar: showProgressBar ?? this.showProgressBar,
      maxVisibleTasks: maxVisibleTasks ?? this.maxVisibleTasks,
      dedline: dedline ?? this.dedline,
      type: type,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        hasTitle,
        type,
        items,
        showCompleteTasks,
        showProgressBar,
        maxVisibleTasks,
        dedline,
      ];
}
