import 'package:flutter/material.dart';

class NumberSlider extends StatelessWidget {
  final String title;
  final int min;
  final int max;
  final int currentValue;
  final ValueChanged<int>
  onChanged; // This is the function passed from the parent

  const NumberSlider({
    super.key,
    required this.title,
    required this.min,
    required this.max,
    required this.currentValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // The dynamic label (e.g., "Players: 5")
        Text(
          '$title: $currentValue',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        // The actual slider
        Slider(
          value: currentValue.toDouble(),
          min: min.toDouble(),
          max: max.toDouble(),
          divisions: max - min, // This makes it snap to whole numbers
          label: currentValue.toString(),
          activeColor: Colors.deepPurple,
          onChanged: (double newValue) {
            // Convert the double back to an int and trigger the parent's function
            onChanged(newValue.toInt());
          },
        ),
      ],
    );
  }
}
