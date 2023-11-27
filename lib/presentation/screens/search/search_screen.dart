import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:in_library/presentation/providers/providers.dart';
import 'package:in_library/presentation/widgets/side_menu.dart';
import 'package:in_library/presentation/widgets/widgets.dart';

class SearchScreen extends ConsumerStatefulWidget {
  static const name = 'search_screen';

  const SearchScreen({super.key, });

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  
  @override
  void initState() {
    super.initState();
    ref.read(seacherResultsProvider.notifier).searchResults;
  }

  @override
  Widget build(BuildContext context) {

    final scaffoldKey = GlobalKey<ScaffoldState>();
    int total = ref.watch(seacherResultsProvider).length;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Busqueda'),
          centerTitle: true,
          actions: [
            Builder(
                builder: (context) => IconButton(
                      icon: const Icon(Icons.sort),
                      onPressed: () => Scaffold.of(context).openEndDrawer(),
                      tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                    ),
              ),
          ],
      ),
        bottomNavigationBar: const CustomBottonNavigationBar( currentIndex: 1 ),
        endDrawer: SideMenu(scaffoldKey: scaffoldKey),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Campo de búsqueda
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
              onChanged: (query) {
                ref.read(seacherResultsProvider.notifier).searchResultsByQuery(query);
              },
            ),
            const SizedBox(height: 16),
            
            Text('N° de resultados: $total'),
            // Resultados de búsqueda
            Expanded(
              child: Scrollbar( // Agregamos Scrollbar aquí
                child: ListView.separated(
                  itemCount: ref.watch(seacherResultsProvider).length,
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                  itemBuilder: (context, index) {
                    final searchResult = ref.watch(seacherResultsProvider)[index];
                    return buildResultItem(searchResult.paragraph, searchResult.nameArticle, searchResult.cover, searchResult.nameTitle, searchResult.idArticle);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildResultItem(String paragraph, String article, String cover, String title, int idArticle) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          context.push('/Article/$idArticle');
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                  child: ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.network(cover)),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(paragraph)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
