import 'dart:async';
import 'package:flutter/material.dart';

class DebounceTextField extends StatefulWidget {
  const DebounceTextField({
    required this.onDebounceChange,
    super.key,
    this.controller,
    this.debounceDuration = const Duration(milliseconds: 300),
    this.onChanged,
    this.focusNode,
    this.minLines,
    this.maxLines,
    this.textCapitalization = TextCapitalization.none,
    this.scrollPhysics,
    this.decoration,
    this.style,
    this.keyboardType,
  });

  final TextEditingController? controller;
  final Duration debounceDuration;
  final void Function(String) onDebounceChange;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;
  final int? minLines;
  final int? maxLines;
  final TextCapitalization textCapitalization;
  final ScrollPhysics? scrollPhysics;
  final InputDecoration? decoration;
  final TextStyle? style;
  final TextInputType? keyboardType;

  @override
  State<DebounceTextField> createState() => _DebounceTextFieldState();
}

class _DebounceTextFieldState extends State<DebounceTextField> {
  late TextEditingController _controller;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onTextChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }

    _debounce = Timer(widget.debounceDuration, () {
      widget.onDebounceChange(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: widget.focusNode,
      onChanged: _onTextChanged,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      textCapitalization: widget.textCapitalization,
      scrollPhysics: widget.scrollPhysics,
      keyboardType: widget.keyboardType,
      style: widget.style ?? Theme.of(context).textTheme.bodyMedium,
      decoration: widget.decoration ?? const InputDecoration(),
    );
  }
}
