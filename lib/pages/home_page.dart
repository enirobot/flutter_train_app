import 'package:flutter/material.dart';
import 'station_list_page.dart';
import 'seat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? departureStation;
  String? arrivalStation;

  Future<void> _selectStation(bool isDeparture) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StationListPage(
          title: isDeparture ? '출발역' : '도착역',
          excludeStation: isDeparture ? arrivalStation : departureStation,
        ),
      ),
    );
    
    if (result != null) {
      setState(() {
        if (isDeparture) {
          departureStation = result;
        } else {
          arrivalStation = result;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('기차 예매'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StationSelector(
              departureStation: departureStation,
              arrivalStation: arrivalStation,
              onDeparturePressed: () => _selectStation(true),
              onArrivalPressed: () => _selectStation(false),
            ),
            const SizedBox(height: 20),
            BookingButton(
              departureStation: departureStation,
              arrivalStation: arrivalStation,
              onPressed: () => _navigateToSeatPage(),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToSeatPage() {
    if (departureStation != null && arrivalStation != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SeatPage(
            departureStation: departureStation!,
            arrivalStation: arrivalStation!,
          ),
        ),
      );
    }
  }
}

class StationSelector extends StatelessWidget {
  final String? departureStation;
  final String? arrivalStation;
  final VoidCallback onDeparturePressed;
  final VoidCallback onArrivalPressed;

  const StationSelector({
    super.key,
    this.departureStation,
    this.arrivalStation,
    required this.onDeparturePressed,
    required this.onArrivalPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[800]
            : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStationButton(
            context: context,
            title: '출발역',
            station: departureStation,
            onTap: onDeparturePressed,
          ),
          Container(
            width: 2,
            height: 50,
            color: Colors.grey[400],
          ),
          _buildStationButton(
            context: context,
            title: '도착역',
            station: arrivalStation,
            onTap: onArrivalPressed,
          ),
        ],
      ),
    );
  }

  Widget _buildStationButton({
    required BuildContext context,
    required String title,
    required String? station,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            Text(
              station ?? '선택',
              style: const TextStyle(fontSize: 40),
            ),
          ],
        ),
      ),
    );
  }
}

class BookingButton extends StatelessWidget {
  final String? departureStation;
  final String? arrivalStation;
  final VoidCallback onPressed;

  const BookingButton({
    super.key,
    this.departureStation,
    this.arrivalStation,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: (departureStation != null && arrivalStation != null)
            ? onPressed
            : null,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.purple,
        ),
        child: const Text(
          '좌석 선택',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}