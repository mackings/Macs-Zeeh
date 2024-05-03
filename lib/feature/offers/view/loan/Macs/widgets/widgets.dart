import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LoanCard extends StatelessWidget {
  final String imagePath;
  final int minAmount;
  final int maxAmount;
  final int duration;
  final double interest;

  LoanCard({
    required this.imagePath,
    required this.minAmount,
    required this.maxAmount,
    required this.duration,
    required this.interest,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(symbol: '₦', decimalDigits: 0);
    return Card(
  elevation: 0,
  margin: EdgeInsets.all(10.0),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0), // Adjust the border radius as needed
    side: BorderSide(color: Colors.grey, width: 1.0), // Adjust the color and width as needed
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      // Image at the top
 Expanded(
  flex: 3,
  child: Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15.0),
        topRight: Radius.circular(15.0),
      ),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15.0),
        topRight: Radius.circular(15.0),
      ),
      child: Image.network(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          // If an error occurs while loading the image, display a placeholder image
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/rounded_zeeh_logo.png', // replace with your asset image path
              fit: BoxFit.contain,
              height: 50.0,
              width: 50.0,
            ),
          );
        },
      ),
    ),
  ),
),

      // Divider in the center
      Center(
        child: Divider(
          thickness: 1.0,
          color: Colors.grey,
        ),
      ),

      Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'N${minAmount} - ${maxAmount}',
              style: const TextStyle(fontSize: 15.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              '$duration months',
              style: TextStyle(fontSize: 14.0),
            ),
            SizedBox(height: 8.0),
            Text(
              '${interest.toStringAsFixed(2)}% Interest rate',
              style: TextStyle(fontSize: 14.0),
            ),
          ],
        ),
      ),
    ],
  ),
);

  }
}


//Second One 

class LoanCard2 extends StatelessWidget {
  final String imagePath;
  final int minAmount;
  final int maxAmount;
  final int duration;
  final double interest;

  LoanCard2({
    required this.imagePath,
    required this.minAmount,
    required this.maxAmount,
    required this.duration,
    required this.interest,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(symbol: '₦', decimalDigits: 0);
    return Card(
      elevation: 0,
      margin: EdgeInsets.all(5.0), // Reduced margin
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Reduced border radius
        side: BorderSide(color: Colors.grey, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2, // Adjusted flex value
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              child: Image.network(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/finance.jpg',
                      fit: BoxFit.cover,
                      height: 40.0,
                      width: 40.0,
                    ),
                  );
                },
              ),
            ),
          ),
          Divider(
            thickness: 1.0,
            color: Colors.grey,
          ),
          Padding(
            padding: EdgeInsets.all(8.0), // Reduced padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${currencyFormat.format(minAmount)} - ${currencyFormat.format(maxAmount)}',
                  style: const TextStyle(fontSize: 12.0), // Reduced font size
                ),
                const SizedBox(height: 4.0), // Reduced height
                Text(
                  '$duration months',
                  style: TextStyle(fontSize: 12.0), // Reduced font size
                ),
                SizedBox(height: 4.0), // Reduced height
                Text(
                  '${interest.toStringAsFixed(2)}% Interest rate',
                  style: TextStyle(fontSize: 12.0), // Reduced font size
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
