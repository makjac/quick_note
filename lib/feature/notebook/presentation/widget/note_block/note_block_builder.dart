import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_note/core/constans/app_constans.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/core/utils/platform_helper.dart';
import 'package:quick_note/core/utils/text_formaters/only_positive_integer_formatter.dart';
import 'package:quick_note/feature/notebook/presentation/bloc/notebook_bloc.dart';
import 'package:quick_note/feature/notebook/presentation/cubit/bookmarks_block_cubit/bookmarks_block_cubit.dart';
import 'package:quick_note/feature/notebook/presentation/cubit/text_block_cubit/text_block_cubit.dart';
import 'package:quick_note/feature/notebook/presentation/cubit/todo_block_cubit/todo_block_cubit.dart';
import 'package:quick_note/feature/notebook/presentation/widget/note_block/blocks/bookmarks/bookmarks_block_widget.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmark_view_mode.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmarks_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/check_list_item.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text/text_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/todo_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';
import 'package:quick_note/feature/shared/presentation/widget/debounce_text_field.dart';
import 'package:quick_note/l10n/l10n.dart';
import 'package:quick_note/preferences/theme/app_custom_colors.dart';
import 'package:quick_note/router/app_routes.dart';

part 'note_block_builder.main.dart';
part 'note_block_widget.dart';

part 'block_settings/shared/note_block_settings_dialog.dart';
part 'block_settings/shared/note_block_modal_bottom_sheet.dart';

part 'block_settings/note_block_settings.dart';
part 'block_settings/text/text_block_settings_dialog.dart';
part 'block_settings/todo/todo_block_settings_dialog.dart';
part 'block_settings/bookmarks/bookmarks_block_settings_dialog.dart';

part 'blocks/shared/note_block_title.dart';

part "blocks/text/text_block_widget.dart";
part "blocks/text/text_block_content.dart";
part "blocks/text/text_block_expand_context_button.dart";

part "blocks/todo/todo_block_widget.dart";
part "blocks/todo/todo_block_list.dart";
part "blocks/todo/todo_block_check_list_item.dart";
part "blocks/todo/todo_block_hidden_items_list.dart";
part "blocks/todo/todo_block_progress_bar.dart";
part "blocks/todo/todo_block_add_task_button.dart";
