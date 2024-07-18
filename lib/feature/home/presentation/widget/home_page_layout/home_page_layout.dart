import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/core/constans/app_constans.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/feature/home/presentation/bloc/app_bloc.dart';
import 'package:quick_note/feature/home/presentation/widget/home_page_layout/home_page_header/home_page_search_bar_header.dart';
import 'package:quick_note/feature/home/presentation/widget/home_page_layout/home_page_header/note_edit_bar.dart';
import 'package:quick_note/feature/home/presentation/widget/home_page_layout/home_page_side_menu.dart';

class HomePageLayout extends StatelessWidget {
  const HomePageLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listenWhen: (previous, current) => current is AppError,
      listener: (context, state) {
        if (state is AppError) _showCustomToast(context, state.errorMessage);
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              if (constraints.maxWidth > AppConstans.mobileSize)
                const HomePageSideMenu(),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<AppBloc, AppState>(
                    builder: (context, state) {
                      return state.isSelecting
                          ? const NoteEditBar()
                          : const HomePageSearchBarHeader(
                              mobileSize: AppConstans.mobileSize);
                    },
                  ),
                  Expanded(child: child),
                ],
              ))
            ],
          );
        },
      ),
    );
  }

  void _showCustomToast(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 90,
        right: Insets.s,
        child: CustomToast(message: message),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }
}

class CustomToast extends StatelessWidget {
  final String message;

  const CustomToast({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: Colors.red.withAlpha(150),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
