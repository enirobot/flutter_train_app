import 'package:flutter/material.dart';
import '../models/station.dart';

class StationListPage extends StatelessWidget {
  final String title;
  final String? excludeStation;

  const StationListPage({
    super.key,
    required this.title,
    this.excludeStation,
  });

  @override
  Widget build(BuildContext context) {
    final filteredStations = Station.stations
        .where((station) => station != excludeStation)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: filteredStations.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.pop(context, filteredStations[index]);
            },
            child: Container(
              height: 50,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  filteredStations[index],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}