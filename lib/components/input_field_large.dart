import 'package:flutter/material.dart';

class InputFieldLarge extends StatefulWidget {
  InputFieldLarge({super.key, this.label = "label name", this.maxLenght = 500});

  final String label;
  final int maxLenght;

  @override
  State<InputFieldLarge> createState() => _InputFieldLargeState();
}

class _InputFieldLargeState extends State<InputFieldLarge> {
  final TextEditingController controller = TextEditingController();
  int charCount = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: TextFormField(
        maxLines: 5,
        maxLength: widget.maxLenght,
        onChanged: (value) => {
          setState(() {
            charCount = value.length;
          })
        },
        decoration: InputDecoration(
          counter: Text("$charCount/${widget.maxLenght}"),
          alignLabelWithHint: true,
          label: Text(widget.label),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(.4),
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.indigo.withOpacity(.4),
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
