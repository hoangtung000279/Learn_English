import 'package:flutter/material.dart';

class SwitchItem extends StatefulWidget {
  final String title;
  final bool value;

  const SwitchItem({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  State<SwitchItem> createState() => _SwitchItemState();
}

class _SwitchItemState extends State<SwitchItem> {
  late bool isOn;

  @override
  void initState() {
    isOn = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.title, style: const TextStyle(color: Colors.white)),
          Switch(
            value: isOn,
            activeColor: Colors.blue,
            onChanged: (val) {
              setState(() => isOn = val);
            },
          )
        ],
      ),
    );
  }
}