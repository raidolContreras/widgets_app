import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_library/presentation/providers/providers.dart';
import 'package:in_library/presentation/widgets/widgets.dart';
import '/presentation/widgets/side_menu.dart';

class ReglamentsScreen extends ConsumerStatefulWidget {
  static const name = 'reglaments_screen';
  const ReglamentsScreen({super.key});

  @override
  ReglamentsScreenState createState() => ReglamentsScreenState();
}

class ReglamentsScreenState extends ConsumerState<ReglamentsScreen> {

  @override
  void initState() {
    super.initState();
    if (ref.read(allTitlesProvider).isEmpty) {
      ref.read(allTitlesProvider.notifier).loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {

    final scaffoldKey = GlobalKey<ScaffoldState>();
    final allTitles = ref.watch(allTitlesProvider);

    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AppBar(
        title: const Text('Reglamentos'),
        centerTitle: true,
      ),
    ),
      body: CustomScrollView(
        slivers: [
          SliverList(delegate: SliverChildBuilderDelegate(
            (context, index) {
              return 
                Column(
                  children: [
                    TitlesSlideshow(titles: allTitles)
                  ],
                );
            },
            childCount: 1
          ))
        ],
      ),
      bottomNavigationBar: const CustomBottonNavigationBar(),
      endDrawer: SideMenu(scaffoldKey: scaffoldKey),
    );
  }
}
