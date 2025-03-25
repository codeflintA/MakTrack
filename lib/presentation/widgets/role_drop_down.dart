import 'package:flutter/material.dart';
import 'package:maktrack/domain/entities/color.dart';

class RoleDropdown extends StatefulWidget {
  final List<String> items;
  final String hint;
  final String? selectedValue;
  final Function(String?) onChanged;

  const RoleDropdown({
    super.key,
    required this.items,
    required this.hint,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  _RoleDropdownState createState() => _RoleDropdownState();
}

class _RoleDropdownState extends State<RoleDropdown> {
  bool isDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isDropdownOpen = !isDropdownOpen;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: RColors.smallFontColor, width: 1),
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.selectedValue ?? widget.hint,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: RColors.smallFontColor,
                        fontSize: 12,
                      ),
                ),
                Icon(
                  isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: RColors.smallFontColor,
                ),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: isDropdownOpen ? widget.items.length * 50.0 : 0,
          child: Visibility(
            visible: isDropdownOpen,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                border: Border.all(color: RColors.smallFontColor, width: 1),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      widget.onChanged(widget.items[index]);
                      setState(() {
                        isDropdownOpen = false;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle_outline,
                              size: 16, color: RColors.smallFontColor),
                          SizedBox(width: 10),
                          Text(
                            widget.items[index],
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: RColors.smallFontColor,
                                      fontSize: 12,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
