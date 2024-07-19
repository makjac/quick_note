import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/feature/home/presentation/cubit/note_search_cubit.dart';
import 'package:quick_note/l10n/l10n.dart';

class HomePageNoteSearchTextField extends StatefulWidget {
  const HomePageNoteSearchTextField({super.key});

  @override
  State<HomePageNoteSearchTextField> createState() =>
      _HomePageNoteSearchTextFieldState();
}

class _HomePageNoteSearchTextFieldState
    extends State<HomePageNoteSearchTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(
        text: context.read<NoteSearchCubit>().state.searchTerm);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.xs),
      child: BlocConsumer<NoteSearchCubit, NoteSearchState>(
        listener: (context, state) {
          _controller.text = state.searchTerm;
        },
        builder: (context, state) {
          return Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  cursorColor: Colors.white38,
                  maxLines: 1,
                  onChanged: (value) {
                    context.read<NoteSearchCubit>().setSearchTerm(value);
                  },
                  decoration: InputDecoration(
                    hintText: context.l10n.search,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white38),
                    border: InputBorder.none,
                  ),
                ),
              ),
              if (state.searchTerm.isNotEmpty)
                IconButton(
                  onPressed: () =>
                      context.read<NoteSearchCubit>().setSearchTerm(""),
                  icon: const Icon(Icons.close),
                ),
            ],
          );
        },
      ),
    );
  }
}
