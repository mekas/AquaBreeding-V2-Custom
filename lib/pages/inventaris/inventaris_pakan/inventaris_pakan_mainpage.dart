import 'package:fish/pages/inventaris/inventaris_pakan/pakan_alami_page.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/pakan_campuran_page.dart';
import 'package:fish/pages/inventaris/inventaris_pakan/pakan_industri_page.dart';
import 'package:fish/theme.dart';
import 'package:flutter/material.dart';

class InventarisPakanMainpage extends StatelessWidget {
  const InventarisPakanMainpage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: backgroundColor1,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.history),
            ),
          ],
          title: const Text('Pakan'),
          bottom: TabBar(
            indicator: BoxDecoration(
              color: primaryColor,
            ),
            tabs: const [
              Tab(
                child: Text(
                  'Industri',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text(
                  'Alami',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text(
                  'Campuran',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PakanIndustriPage(),
            PakanAlamiPage(),
            PakanCampuranPage(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green.shade600,
          onPressed: () {},
          child: const Icon(
            Icons.add,
            size: 32,
          ),
        ),
      ),
    );
  }
}
