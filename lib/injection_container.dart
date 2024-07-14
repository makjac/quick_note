import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:quick_note/feature/home/data/datasource/app_local_data_source.dart';
import 'package:quick_note/feature/home/data/repository/app_repository_impl.dart';
import 'package:quick_note/feature/home/domain/repository/app_repository.dart';
import 'package:quick_note/feature/home/domain/usecase/create_note_usecase.dart';
import 'package:quick_note/feature/home/domain/usecase/delete_all_notes_usecase.dart';
import 'package:quick_note/feature/home/domain/usecase/delete_miltiple_notes_usecase.dart';
import 'package:quick_note/feature/home/domain/usecase/delete_single_note_usecase.dart';
import 'package:quick_note/feature/home/domain/usecase/load_cached_notes_usecase.dart';
import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/home/domain/usecase/update_note_usecase.dart';
import 'package:quick_note/feature/home/presentation/bloc/app_bloc.dart';
import 'package:quick_note/l10n/bloc/i10n_bloc.bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'injection_container.main.dart';
