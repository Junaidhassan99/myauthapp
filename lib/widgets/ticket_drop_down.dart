import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TicketDropDown extends StatefulWidget {
  const TicketDropDown({super.key});

  @override
  State<TicketDropDown> createState() => _TicketDropDownState();
}

class _TicketDropDownState extends State<TicketDropDown> {
  int _selectedSeatNumber = 1;

  @override
  Widget build(BuildContext context) {
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

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    'You have selected seat: $_selectedSeatNumber, by ${FirebaseAuth.instance.currentUser!.email}')));
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
