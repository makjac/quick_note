part of '../../note_block_builder.dart';

Future<void> showTextBlockSettings(BuildContext context) async {
  final width = MediaQuery.of(context).size.width;
  final showAlertDialog = AppConstans.mobileSize < width;

  if (showAlertDialog) {
    await _showTextBlockSettingsDialog(context);
  } else {
    await _showTextBlockModalBottomSheet(context);
  }
}

Future<void> _showTextBlockSettingsDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (_) {
      return NoteBlockSettingsDialog(
        title: context.l10n.block_settings_text_title,
        child: _TextBlockSettings(context: context),
      );
    },
  );
}

Future<void> _showTextBlockModalBottomSheet(BuildContext context) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => NoteBlockModalBottomSheet(
      title: context.l10n.block_settings_text_title,
      child: _TextBlockSettings(context: context),
    ),
  );
}

class _TextBlockSettings extends StatelessWidget {
  const _TextBlockSettings({required this.context});

  final BuildContext context;

  @override
  Widget build(BuildContext _) {
    return BlocBuilder<TextBlockCubit, TextBlockState>(
      bloc: BlocProvider.of<TextBlockCubit>(context),
      builder: (_, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CheckboxListTile.adaptive(
              value: state.block.hasTitle,
              activeColor: Colors.white,
              onChanged: (value) => BlocProvider.of<TextBlockCubit>(context)
                  .changeBlockTitleVisibility(value),
              title: Text(context.l10n.block_settings_text_show_header),
            ),
            CheckboxListTile.adaptive(
              value: state.block.hasMaxLineLimit,
              activeColor: Colors.white,
              onChanged: (value) => BlocProvider.of<TextBlockCubit>(context)
                  .setMaxLinesLimitOption(value),
              title: Text(context.l10n.block_settings_text_line_limit),
            ),
            if (state.block.hasMaxLineLimit)
              Padding(
                padding: const EdgeInsets.only(left: Insets.m),
                child: _MaxLinesLimit(
                  initialValue: state.block.maxLines,
                  onChanged: (limit) => BlocProvider.of<TextBlockCubit>(context)
                      .setTextLinecountLimit(limit),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _MaxLinesLimit extends StatefulWidget {
  const _MaxLinesLimit({
    required this.initialValue,
    required this.onChanged,
  });

  final int initialValue;
  final void Function(int limit) onChanged;

  @override
  State<_MaxLinesLimit> createState() => _MaxLinesLimitState();
}

class _MaxLinesLimitState extends State<_MaxLinesLimit> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: _setupInitialValue());
    super.initState();
  }

  String? _setupInitialValue() {
    return widget.initialValue.toString();
  }

  void onChange(String value) {
    final limit = int.tryParse(value);
    widget.onChanged(limit ?? 1);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: Insets.s, right: Insets.xs),
      child: Row(
        children: [
          Text(
            context.l10n.block_settings_text_limit,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const Spacer(),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 100),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white12),
                borderRadius: BorderRadius.circular(Insets.xs),
              ),
              padding: const EdgeInsets.symmetric(horizontal: Insets.s),
              child: TextField(
                controller: _controller,
                maxLines: 1,
                cursorColor: Colors.white38,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  OnlyPositiveIntegerFormatter(),
                ],
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  hintText: "limit",
                ),
                textAlign: TextAlign.right,
                onChanged: onChange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
