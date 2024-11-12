import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SeatPage extends StatefulWidget {
  final String departureStation;
  final String arrivalStation;
  final VoidCallback onBookingComplete;

  const SeatPage({
    super.key,
    required this.departureStation,
    required this.arrivalStation,
    required this.onBookingComplete,
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
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[800]
                      : Colors.grey[300],
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
          return _buildSeat(seatId);
        }),
        _buildRowNumber(rowNumber),
        ...['C', 'D'].map((seat) {
          final seatId = '$rowNumber$seat';
          return _buildSeat(seatId);
        }),
      ],
    );
  }

  Widget _buildSeat(String seatId) {
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
                : Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[800]
                    : Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildRowNumber(int rowNumber) {
    return Padding(
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
              widget.onBookingComplete();
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
            _buildRouteInfo(),
            const SizedBox(height: 10),
            _buildSeatLegend(),
            _buildSeatLabels(),
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: _buildSeatRow(index + 1),
                ),
              ),
            ),
            _buildBookingButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildRouteInfo() {
    return Row(
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
        const Icon(Icons.arrow_circle_right_outlined, size: 30),
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
    );
  }

  Widget _buildSeatLabels() {
    return Row(
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
    );
  }

  Widget _buildBookingButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: selectedSeats.isEmpty ? null : _showBookingConfirmation,
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
    );
  }
}