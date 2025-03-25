import 'package:flutter/material.dart';

class Onboarding2 extends StatelessWidget {
  const Onboarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 60,
        ),
        Container(
            width: double.infinity,
            color: Colors.transparent,
            child: Image.asset(
              "assets/onboarding/At work-cuate (2).png",
            )),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Column(            spacing: 8,

            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "DISCOVERY",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 40),
              ),
              Text(
                textAlign: TextAlign.end,
                "DISCOVER TASKS\n& TRACK PROGRESS",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
