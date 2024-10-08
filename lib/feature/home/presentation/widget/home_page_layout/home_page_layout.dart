import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_note/core/constans/app_constans.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/feature/home/presentation/bloc/app_bloc.dart';
import 'package:quick_note/feature/home/presentation/widget/home_page_layout/home_page_header/edit_bar/trash_page_note_edit_bar.dart';
import 'package:quick_note/feature/home/presentation/widget/home_page_layout/home_page_header/search_bar/home_page_search_bar_header.dart';
import 'package:quick_note/feature/home/presentation/widget/home_page_layout/home_page_header/edit_bar/home_page_note_edit_bar.dart';
import 'package:quick_note/feature/home/presentation/widget/home_page_layout/home_page_menu/home_page_side_menu.dart';
import 'package:quick_note/router/app_routes.dart';

class HomePageLayout extends StatelessWidget {
  const HomePageLayout({super.key, required this.child, this.isTrash = false});

  final Widget child;
  final bool isTrash;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listenWhen: (previous, current) =>
          current is AppError || current is AppNoteCreated,
      listener: (context, state) {
        if (!context.mounted) return;
        if (state is AppError) _showCustomToast(context, state.errorMessage);
        if (state is AppNoteCreated) {
          final uri =
              GoRouter.of(context).routeInformationProvider.value.uri.path;
          if (uri.contains(state.createdNoteId.toString())) return;
          context.pushNamed(AppRoutes.notebook.name,
              pathParameters: {"id": state.createdNoteId.toString()});
        }
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
                        return Container(
                          child: state.isSelecting
                              ? _noteEditBar()
                              : const HomePageSearchBarHeader(),
                        );
                      },
                    ),
                    Expanded(
                      child: ShaderMask(
                        shaderCallback: (bounds) {
                          return const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.grey,
                              Colors.transparent,
                              Colors.transparent,
                              Colors.grey
                            ],
                            stops: [0.0, 0.04, 0.97, 1.0],
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode.dstOut,
                        child: child,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _noteEditBar() {
    if (isTrash) return const TrashPageNoteEditBar();
    return const HomePageNoteEditBar();
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
  const CustomToast({super.key, required this.message});

  final String message;

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
