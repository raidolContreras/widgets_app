import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '/presentation/widgets/side_menu.dart';
import 'package:in_library/config/mysql/mysql.dart';
import 'package:card_swiper/card_swiper.dart';

class ReglamentsScreen extends StatefulWidget {
  static const name = 'reglaments_screen';
  const ReglamentsScreen({super.key});

  @override
  ReglamentsScreenState createState() => ReglamentsScreenState();
}

class ReglamentsScreenState extends State<ReglamentsScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var db = MySql();
  List reglament = [];
  List idReglament = [];
  List cover = [];

  @override
  void initState() {
    super.initState();
    getReglaments();
  }

  void getReglaments() {
    db.getConnection().then((conn) {

      String sql = "SELECT * FROM app_titles t LEFT JOIN app_covers ac ON t.idTitles = ac.Title_idTitles WHERE t.type_title = 'Reglamento'";
      conn.query(sql).then((results) {
        for(var row in results){
          setState(() {
            idReglament.add(row[0]);
            reglament.add(row[1]);
            cover.add(row[6]);
          });
        }
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return _ViewReglaments(scaffoldKey: scaffoldKey, idReglament: idReglament, reglament: reglament, cover: cover);
  }
}

class _ViewReglaments extends StatelessWidget {
  const _ViewReglaments({
    required this.scaffoldKey,
    required this.idReglament,
    required this.reglament,
    required this.cover,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final List reglament;
  final List idReglament;
  final List cover;

  @override
  Widget build(BuildContext context) {
    
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.black,
          blurRadius: 10,
          offset: Offset(0,10)
        )
      ]
    );

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Center(child: Text('Reglamentos')),
      ),
      endDrawer: SideMenu(scaffoldKey: scaffoldKey), // Utiliza endDrawer en lugar de drawer

      body: Column(
        children: [
          const SizedBox(height: 40),
          const SizedBox(height: 40,
            child: Text(
              'Selecciona un reglamento',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins'
              ),
            )
          ),
          Center(
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: DecoratedBox(
                      decoration: decoration,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                                (cover[index] != null)
                                  ?'https://app-fiscal.inscripcionesccm.online/assets/images/covers/${idReglament[index]}/${cover[index]}'
                                  :'https://publications.iarc.fr/uploads/media/default/0001/02/thumb_1244_default_publication.jpeg', 
                                    fit: BoxFit.fill),
                      ),
                    ),
                  ),
                );
              },
              itemCount: reglament.length,
              itemWidth: MediaQuery.of(context).size.width * 0.9,
              itemHeight: MediaQuery.of(context).size.height * 0.6,
              layout: SwiperLayout.TINDER,
            ),
          )
        ],
      ),
    );
  }
}
