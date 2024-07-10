import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/feature/home/presentation/widget/note_tile.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/check_list_item.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Card(
              color: Colors.grey[850],
              margin: const EdgeInsets.only(
                left: Insets.s,
                right: Insets.s,
                top: Insets.s,
              ),
              child: Padding(
                padding: const EdgeInsets.all(Insets.xxs),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white.withAlpha(180),
                      ),
                    ),
                    const Text(
                      "Search...",
                      style: TextStyle(
                        color: Colors.white38,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(Insets.s),
            sliver: SliverMasonryGrid.count(
              crossAxisCount: width > 200 ? width ~/ 200 : 1,
              childCount: notes.length,
              crossAxisSpacing: Insets.xs,
              mainAxisSpacing: Insets.xs,
              itemBuilder: (context, index) => NoteTile(note: notes[index]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

final List<Note> notes = [
  Note(
      id: 1,
      created: DateTime.now(),
      modified: DateTime.now(),
      colorHex: "fe453a",
      content: const [
        TodoBlock(
          id: 1,
          items: [
            ChecklistItem(id: 1, title: "Chleb", isChecked: false),
            ChecklistItem(id: 2, title: "Jajka", isChecked: true),
            ChecklistItem(id: 3, title: "Ser", isChecked: false),
            ChecklistItem(id: 3, title: "Pomidory", isChecked: false),
            ChecklistItem(id: 3, title: "Jabłka", isChecked: false),
            ChecklistItem(id: 3, title: "Mleko", isChecked: false),
            ChecklistItem(id: 3, title: "Gruszka", isChecked: false),
          ],
        ),
      ],
      title: "Lista zakupów"),
  Note(
    id: 2,
    created: DateTime.now(),
    modified: DateTime.now(),
    title: "Spotkanie z klientem",
    content: const [
      TextBlock(id: 1, text: "Czwartek, 10:00, sala konferencyjna B.")
    ],
  ),
  Note(
      id: 3,
      created: DateTime.now(),
      modified: DateTime.now(),
      title: "Empty Note"),
  Note(
      id: 5,
      created: DateTime.now(),
      modified: DateTime.now(),
      title: "Urodziny Ani",
      colorHex: "#28a6e0",
      content: const [
        TodoBlock(
          id: 1,
          items: [
            ChecklistItem(id: 1, title: "Kupić prezent", isChecked: false),
            ChecklistItem(
                id: 2, title: "Wysłać kartkę urodzinową", isChecked: true),
          ],
        ),
      ]),
  Note(
    id: 4,
    created: DateTime.now(),
    modified: DateTime.now(),
    colorHex: "#28e038",
    title: "Przypomnienie o rachunkach",
    content: const [
      TextBlock(
        id: 1,
        text: "Opłacić rachunki za prąd i internet.",
      )
    ],
  ),
  Note(
      id: 1,
      created: DateTime.now(),
      modified: DateTime.now(),
      content: const [
        TextBlock(
          id: 1,
          text: "Poniedziałek, 15:00, przychodnia na ul. Zielonej.",
        )
      ],
      title: "Wizyta u lekarza"),
  Note(
    id: 2,
    created: DateTime.now(),
    modified: DateTime.now(),
    colorHex: "#8f48db",
    title: "Obiad z rodziną",
    content: const [
      TextBlock(id: 1, text: "Sobota, 13:00, restauracja „Pod Dębem”.")
    ],
  ),
  Note(
      id: 3,
      created: DateTime.now(),
      modified: DateTime.now(),
      title: "Trening na siłowni"),
  Note(
    id: 4,
    created: DateTime.now(),
    modified: DateTime.now(),
    colorHex: "#ff0f57",
    title: "Plan na weekend",
    content: const [
      TextBlock(
        id: 1,
        text:
            "W sobotę planuję wycieczkę rowerową po lesie z przyjaciółmi. Po południu odwiedzę babcię i pomogę jej w ogrodzie. W niedzielę wybiorę się na basen, a wieczorem pójdę do kina na nowy film. Chcę też znaleźć czas na czytanie książki i relaks w domu.",
      )
    ],
  ),
  Note(
      id: 1,
      created: DateTime.now(),
      modified: DateTime.now(),
      title: "Spotkanie z nauczycielem"),
  Note(
    id: 5,
    created: DateTime.now(),
    modified: DateTime.now(),
    title: "Note Extra",
    colorHex: "#94623a",
    content: const [
      TodoBlock(
        id: 1,
        items: [
          ChecklistItem(
              id: 1,
              title: "todo 1 todo 1 todo 1 todo 1 todo 1 ",
              isChecked: false),
          ChecklistItem(id: 2, title: "todo 2", isChecked: true),
          ChecklistItem(id: 3, title: "todo 3", isChecked: false),
        ],
      ),
      TextBlock(
          id: 2,
          text:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
    ],
  ),
  Note(
    id: 2,
    created: DateTime.now(),
    modified: DateTime.now(),
    title: "Spotkanie z nauczycielem",
    colorHex: "#d4f70c",
    content: const [
      TextBlock(id: 1, text: "Piątek, 14:00, omówienie postępów w nauce.")
    ],
  ),
  Note(
    id: 4,
    created: DateTime.now(),
    modified: DateTime.now(),
    colorHex: "#76f5d3",
    title: "Spotkanie zespołu projektowego",
    content: const [
      TextBlock(
        id: 1,
        text:
            "W poniedziałek odbędzie się spotkanie zespołu projektowego o godzinie 10:00 w sali konferencyjnej. Omówimy postępy prac, podzielimy się zadaniami na nadchodzący tydzień oraz zaplanujemy działania mające na celu przyspieszenie realizacji projektu. Proszę o przygotowanie raportów i notatek z ostatnich tygodni.",
      )
    ],
  ),
];
