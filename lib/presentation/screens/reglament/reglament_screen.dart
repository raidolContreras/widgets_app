import 'package:flutter/material.dart';
import 'package:in_library/presentation/widgets/side_menu.dart';
import 'package:in_library/presentation/widgets/widgets.dart';

class ReglamentScreen extends StatelessWidget {
  static const name = 'reglament_screen';
  const ReglamentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: const Text('Reglamento'),
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
      ),
      
      bottomNavigationBar: const CustomBottonNavigationBar( currentIndex: 0 ),
      endDrawer: SideMenu(scaffoldKey: scaffoldKey),
    );
  }
}