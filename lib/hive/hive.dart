import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:quick_note/feature/shared/data/model/note/blocks/bookmarks/bookmark_item.module.dart';
import 'package:quick_note/feature/shared/data/model/note/blocks/bookmarks/bookmarks_block.module.dart';
import 'package:quick_note/feature/shared/data/model/note/blocks/todo/check_list_item.module.dart';
import 'package:quick_note/feature/shared/data/model/note/blocks/text/text_block.module.dart';
import 'package:quick_note/feature/shared/data/model/note/blocks/todo/todo_block.module.dart';
import 'package:quick_note/feature/shared/data/model/note/note.module.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmark_view_mode.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_colors.dart';

part 'hive.main.dart';
