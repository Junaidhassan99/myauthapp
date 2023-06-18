import 'package:flutter/material.dart';
import 'package:myauthapp/widgets/ticket_drop_down.dart';

class GetTickets extends StatefulWidget {
  const GetTickets({
    super.key,
  });

  @override
  State<GetTickets> createState() => _GetTicketsState();
}

class _GetTicketsState extends State<GetTickets> {
  void _showSeatSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const TicketDropDown();
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

