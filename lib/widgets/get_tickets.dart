import 'package:flutter/material.dart';

class GetTickets extends StatefulWidget {
  const GetTickets({
    super.key,
  });

  @override
  State<GetTickets> createState() => _GetTicketsState();
}

class _GetTicketsState extends State<GetTickets> {
  int _selectedSeatNumber = 1;

  void _showSeatSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          title: const Text('Select Seat Number'),
          content: Center(
            heightFactor: 0.7,
            child: DropdownButton<int>(
              value: _selectedSeatNumber,
              onChanged: (int? newValue) {
                setState(() {
                  _selectedSeatNumber = newValue!;
                  print(_selectedSeatNumber);
                });
              },
              items: List.generate(
                100,
                (index) => DropdownMenuItem<int>(
                  value: index + 1,
                  child: Text('${index + 1}'),
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // do something with the selected seat number

                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            Colors.blue.shade300,
          ),
        ),
        onPressed: () {
          _showSeatSelectionDialog(context);
        },
        child: const Text(
          'Get Tickets',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
