// main.dart
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '기차 예매',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
      ),
      home: const HomePage(),
    );
  }
}

// home_page.dart
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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('기차 예매'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectStation(true),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '출발역',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            departureStation ?? '선택',
                            style: const TextStyle(fontSize: 40),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 2,
                    height: 50,
                    color: Colors.grey[400],
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectStation(false),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '도착역',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            arrivalStation ?? '선택',
                            style: const TextStyle(fontSize: 40),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (departureStation != null && arrivalStation != null)
                    ? () {
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
            ),
          ],
        ),
      ),
    );
  }
}

// station_list_page.dart
class StationListPage extends StatelessWidget {
  final String title;
  final List<String> stations = [
    "수서",
    "동탄",
    "평택지제",
    "천안아산",
    "오송",
    "대전",
    "김천구미",
    "동대구",
    "경주",
    "울산",
    "부산"
  ];

  StationListPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: stations.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.pop(context, stations[index]);
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  stations[index],
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

// seat_page.dart
class SeatPage extends StatefulWidget {
  final String departureStation;
  final String arrivalStation;

  const SeatPage({
    super.key,
    required this.departureStation,
    required this.arrivalStation,
  });

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  final Set<String> selectedSeats = {};

  void _toggleSeat(String seatId) {
    setState(() {
      if (selectedSeats.contains(seatId)) {
        selectedSeats.remove(seatId);
      } else {
        selectedSeats.add(seatId);
      }
    });
  }

  Widget _buildSeatLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(width: 4),
              const Text('선택됨'),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(width: 4),
              const Text('선택안됨'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSeatRow(int rowNumber) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...['A', 'B'].map((seat) {
          final seatId = '$rowNumber$seat';
          return GestureDetector(
            onTap: () => _toggleSeat(seatId),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: selectedSeats.contains(seatId)
                      ? Colors.purple
                      : Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          );
        }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Container(
            width: 50,
            height: 50,
            alignment: Alignment.center,
            child: Text(
              '$rowNumber',
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
        ...['C', 'D'].map((seat) {
          final seatId = '$rowNumber$seat';
          return GestureDetector(
            onTap: () => _toggleSeat(seatId),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: selectedSeats.contains(seatId)
                      ? Colors.purple
                      : Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  void _showBookingConfirmation() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('예매 확인'),
        content: Text(
          '선택하신 ${selectedSeats.join(", ")} 좌석을 예매하시겠습니까?',
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('취소'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            child: const Text('확인'),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('좌석 선택'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    widget.departureStation,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Icon(
                  Icons.arrow_circle_right_outlined,
                  size: 30,
                ),
                Expanded(
                  child: Text(
                    widget.arrivalStation,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _buildSeatLegend(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: ['A', 'B', '', 'C', 'D'].map((label) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Container(
                    width: 50,
                    height: 50,
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      label,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                );
              }).toList(),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: _buildSeatRow(index + 1)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      selectedSeats.isEmpty ? null : _showBookingConfirmation,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.purple,
                  ),
                  child: const Text(
                    '예매 하기',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
