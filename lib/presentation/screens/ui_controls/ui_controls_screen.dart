import 'package:flutter/material.dart';

class UiControlsScreen extends StatelessWidget {

  static const name = 'ui_Controls_screen';
  
  const UiControlsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ui Controls + Tiles'),
      ),
      body: const _UiControlsView(),
    );
  }
}

class _UiControlsView extends StatefulWidget {
  const _UiControlsView();

  @override
  State<_UiControlsView> createState() => _UiControlsViewState();
}

enum Transportation { car, plane, boat, submarine }

class _UiControlsViewState extends State<_UiControlsView> {

  bool isDeveloper = false;
  Transportation selectedTransportation = Transportation.car;
  bool wantsBreakfast = false;
  bool wantsLunch = false;
  bool wantsDinner = false;


  @override
  Widget build(BuildContext context) {
    return ListView( 
      physics: const ClampingScrollPhysics(),
      children: [
        SwitchListTile(
          title: const Text('Developer Mode'),
          subtitle: const Text('Controles adicionales'),
          value: isDeveloper, 
          onChanged: (value) => setState(() {
            isDeveloper = !isDeveloper;
          }),
        ),

        ExpansionTile(
          title: const Text('Vehiculo de transporte'),
          subtitle: const Text('Selected Transportation'),
          
          children: [
            
            RadioListTile(
              title: const Text('By Car'),
              subtitle: const Text('Viajar por Auto'),
              value: Transportation.car,
              groupValue: selectedTransportation,
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.car;
              }),
            ),

            RadioListTile(
              title: const Text('By plane'),
              subtitle: const Text('Viajar por Avión'),
              value: Transportation.plane,
              groupValue: selectedTransportation,
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.plane;
              }),
            ),

            RadioListTile(
              title: const Text('By Boat'),
              subtitle: const Text('Viajar por Bote'),
              value: Transportation.boat,
              groupValue: selectedTransportation,
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.boat;
              }),
            ),

            RadioListTile(
              title: const Text('By Submarine'),
              subtitle: const Text('Viajar por Submarino'),
              value: Transportation.submarine,
              groupValue: selectedTransportation,
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.submarine;
              }),
            ),
          ],
        ),
        
        CheckboxListTile(
          title: const Text('¿Desea desayuno?'),
          value: wantsBreakfast,
          onChanged: (value) => setState(() {
            wantsBreakfast = !wantsBreakfast;
          }),
        ),
        CheckboxListTile(
          title: const Text('¿Desea almuerzo?'),
          value: wantsLunch,
          onChanged: (value) => setState(() {
            wantsLunch = !wantsLunch;
          }),
        ),
        CheckboxListTile(
          title: const Text('¿Desea cena?'),
          value: wantsDinner,
          onChanged: (value) => setState(() {
            wantsDinner = !wantsDinner;
          }),
        ),

      ],
     );
  }
}