import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maktrack/domain/entities/color.dart';

class ProjectUpdateTextField extends StatefulWidget {
  const ProjectUpdateTextField({
    super.key,
    required this.hintText,
    required this.controller,
  });

  final String hintText;
  final TextEditingController controller;

  @override
  State<ProjectUpdateTextField> createState() => _ProjectUpdateTextFieldState();
}

class _ProjectUpdateTextFieldState extends State<ProjectUpdateTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.hintText == 'Comment' ? 100 : 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: RColors.smallFontColor,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.hintText == 'Progress Percentage'
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.multiline,
        inputFormatters: widget.hintText == 'Progress Percentage'
            ? [
                FilteringTextInputFormatter.allow(
                  RegExp(r'^\d*[\.,]?\d*$'),
                ), // ✅ Restricts input
              ]
            : null,
        maxLines: widget.hintText == 'Comment' ? null : 1,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontWeight: FontWeight.w700,
          ),
          enabled: true,
          contentPadding: const EdgeInsets.only(
            bottom: 5,
            left: 15,
          ),
        ),
      ),
    );
  }
}
