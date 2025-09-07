import 'package:flutter/material.dart';

class BookingsPreviewCard extends StatelessWidget {
  const BookingsPreviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        // First Container
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [colorScheme.primary, colorScheme.tertiary],
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 100,
                child: Center(
                  child: Text(
                    "No Bookings yet !!",
                    style: textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Second Container
        Container(
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 12.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: colorScheme.primary.withOpacity(0.50),
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(8.0),
            ),
          ),
        ),
        //Third Container
        Container(
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 24.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: colorScheme.primary.withOpacity(0.30),
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(8.0),
            ),
          ),
        ),
      ],
    );
  }
}
