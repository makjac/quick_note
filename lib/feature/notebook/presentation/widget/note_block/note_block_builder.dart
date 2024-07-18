import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/feature/notebook/presentation/bloc/notebook_bloc.dart';
import 'package:quick_note/feature/notebook/presentation/cubit/text_block_cubit/text_block_cubit.dart';
import 'package:quick_note/feature/notebook/presentation/cubit/todo_block_cubit/todo_block_cubit.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/check_list_item.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';
import 'package:quick_note/l10n/l10n.dart';

part 'note_block_builder.main.dart';

part "blocks/text_block_widget.dart";
part "blocks/todo_block_widget.dart";
