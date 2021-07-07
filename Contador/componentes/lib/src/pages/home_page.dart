import 'package:componentes/src/providers/menu_provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('components'),
      ),
      body: _lista(),
    );
  }

  Widget _lista() {
    /* menuProvider.cargarData() */

    return FutureBuilder(
      future: menuProvider.cargarData(),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error'));
        }

        if (!snapshot.hasData) {
          return Center(child: Text('No hay data'));
        }

        return ListView(
          children: _listItems(snapshot.data),
        );
      },
    );

/*     return  */
  }

  List<Widget> _listItems(List<dynamic>? data) {
    final List<Widget> opciones = [];
    data?.forEach((opt) {
      final widgetTemp = ListTile(
        title: Text(opt['texto']),
        leading: Icon(Icons.account_circle, color: Colors.blue),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
        onTap: () {},
      );
      opciones.add(widgetTemp);
    });
    return opciones;
  }
}
