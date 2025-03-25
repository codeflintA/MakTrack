import 'package:flutter/material.dart';

class Onboarding3 extends StatelessWidget {
  const Onboarding3({super.key});

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
              "assets/onboarding/Team work-cuate.png",
            )),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "GET STARTED",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 40),
              ),
              Text(
                  maxLines: 2,
                  textAlign: TextAlign.end,
                  "BEGIN YOUR\nJOURNEY TODAY",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.black54)),
            ],
          ),
        )
      ],
    );
  }
}
