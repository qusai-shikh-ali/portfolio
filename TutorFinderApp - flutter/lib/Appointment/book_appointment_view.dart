import 'package:firebaseconnations/LayoutAppMenu/app_start_menu.dart';
import 'package:flutter/material.dart';

import '../Componet/snackbar.dart';

class BookAppointmentView extends StatelessWidget {
  BookAppointmentView({super.key});
  final _nameController = TextEditingController();
  final _selectedDayController = TextEditingController();
  final _selectedTimeController = TextEditingController();
  final _mobileNumController = TextEditingController();
  final _massageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return AppStartMenu(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: buildColumnChildrenWithPadding(
            [
              Text(
                " Enter or Update your Name :",
                style: textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.inverseSurface),
              ),
              buildTextField(
                controller: _nameController,
                hintText: "Your Name",
              ),
              Text(
                " Select Appointment day :",
                style: textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.inverseSurface),
              ),
              buildTextField(
                controller: _selectedDayController,
                hintText: "Select day",
              ),
              Text(
                " Select Appointment Time :",
                style: textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.inverseSurface),
              ),
              buildTextField(
                controller: _selectedTimeController,
                hintText: "Select Time",
              ),
              Text(
                " Enter or update your Mobile Number :",
                style: textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.inverseSurface),
              ),
              buildTextField(
                controller: _mobileNumController,
                hintText: "Mobile Number",
              ),
              Text(
                " Leave a Massage :",
                style: textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.inverseSurface),
              ),
              buildTextField(
                controller: _massageController,
                hintText: "your Massage",
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/booking');
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.blue[800], // Text color
            backgroundColor: Colors.grey.withOpacity(0.4), // Background color
            padding: const EdgeInsets.symmetric(
                horizontal: 70, vertical: 12), // Padding
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: const Text("Book Now"),
        ),
      ],
    );
  }
}
