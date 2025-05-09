import 'package:emergency_app/screens/emergency_form.dart';
import 'package:emergency_app/widgets/option_buttons.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

class EmergencyOption extends StatefulWidget {
  const EmergencyOption({super.key});

  @override
  State<EmergencyOption> createState() => _EmergencyOptionState();
}

class _EmergencyOptionState extends State<EmergencyOption> {
  Future<void> _callCrimeEmergency() async {
    const primaryNumber = 'tel:7827170170'; // Primary crime emergency number
    const fallbackNumber = 'tel:1090'; // Fallback number

    // Try calling the primary number
    if (await canLaunchUrl(Uri.parse(primaryNumber))) {
      await launchUrl(Uri.parse(primaryNumber));
    } else {
      // If the primary number fails, try the fallback number
      if (await canLaunchUrl(Uri.parse(fallbackNumber))) {
        await launchUrl(Uri.parse(fallbackNumber));
      } else {
        // If both fail, show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not launch any emergency number.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OptionButton(
                title: 'Fire Emergency',
                color: Colors.orange,
                icon: Icons.local_fire_department,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EmergencyForm(type: 'fire'),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              OptionButton(
                title: 'Crime Emergency',
                color: Colors.red,
                icon: Icons.warning,
                onPressed: _callCrimeEmergency, // Call the function here
              ),
              const SizedBox(
                height: 20,
              ),
              OptionButton(
                title: 'Medical Emergency',
                color: Colors.blue,
                icon: Icons.local_hospital,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EmergencyForm(type: 'medical'),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}