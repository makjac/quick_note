import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/feature/notebook/presentation/bloc/notebook_bloc.dart';
import 'package:quick_note/feature/notebook/presentation/cubit/text_block_cubit/text_block_cubit.dart';
import 'package:quick_note/feature/notebook/presentation/cubit/todo_block_cubit/todo_block_cubit.dart';
import 'package:quick_note/feature/notebook/presentation/widget/note_block/block_settings/note_block_settings.dart';
import 'package:quick_note/feature/notebook/presentation/widget/note_block/block_settings/todo/todo_block_settings_dialog.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/check_list_item.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';
import 'package:quick_note/l10n/l10n.dart';

part 'note_block_builder.main.dart';
part 'note_block_widget.dart';

part "blocks/text/text_block_widget.dart";
part "blocks/todo/todo_block_widget.dart";
part "blocks/todo/todo_block_title.dart";
part "blocks/todo/todo_block_list.dart";
part "blocks/todo/todo_block_check_list_item.dart";
part "blocks/todo/todo_block_add_task_button.dart";
