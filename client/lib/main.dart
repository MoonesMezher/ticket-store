import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'Ticket Store';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  // Sample list of tickets
  final List<Ticket> tickets = [
    Ticket(title: "Concert", price: 50, from: "New York", to: "Los Angeles"),
    Ticket(title: "Football Match", price: 30, from: "Chicago", to: "Miami"),
    Ticket(title: "Theater", price: 40, from: "San Francisco", to: "Seattle"),
    Ticket(title: "Movie", price: 15, from: "Boston", to: "Houston"),
    Ticket(title: "Festival", price: 70, from: "Las Vegas", to: "Orlando"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ticket Store",
            style: TextStyle(
              color: Colors.white,
            )),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: tickets.length,
        itemBuilder: (context, index) {
          final ticket = tickets[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(ticket.title, style: const TextStyle(fontSize: 20)),
              subtitle: Text("From: ${ticket.from} To: ${ticket.to}"),
              trailing: Text("\$${ticket.price}",
                  style: const TextStyle(fontSize: 18)),
              onTap: () => _showEmailDialog(context, ticket.title),
            ),
          );
        },
      ),
    );
  }

  void _showEmailDialog(BuildContext context, String ticketTitle) {
    final TextEditingController emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Purchase for $ticketTitle"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Please enter your email:"),
              TextField(
                controller: emailController,
                decoration: InputDecoration(hintText: "Email"),
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Handle the confirmation action
                String email = emailController.text;
                if (email.isNotEmpty) {
                  // You can add your confirmation logic here

                  Navigator.of(context).pop(); // Close the dialog

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SuccessScreen()),
                  );
                } else {
                  // Show a message if the email is empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please enter a valid email.")),
                  );
                }
              },
              child: const Text("Confirm"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}

// Ticket model
class Ticket {
  final String title;
  final double price;
  final String from;
  final String to;

  Ticket(
      {required this.title,
      required this.price,
      required this.from,
      required this.to});
}

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Success Confirm'),
      ),
      body: Center(
          child: Column(
        children: [
          const Center(
              child: Text(
            "Congratulations, you confiremd your ticket, check your email",
            style: TextStyle(
              fontSize: 30,
            ),
          )),
          ElevatedButton(
            onPressed: () {
              // Navigate to the second screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
            child: const Text('Go Back To Store'),
          ),
        ],
      )),
    );
  }
}
