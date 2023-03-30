import 'package:flutter/material.dart';

class CommonTextFieldPasswordWidget extends StatefulWidget {
  final TextEditingController controller;

  const CommonTextFieldPasswordWidget({
    super.key,
    required this.controller,
  });

  @override
  State<CommonTextFieldPasswordWidget> createState() =>
      _CommonTextFielPasswordWidgetState();
}

class _CommonTextFielPasswordWidgetState
    extends State<CommonTextFieldPasswordWidget> {
  bool isInvisible = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          " Contraseña:",
        ),
        const SizedBox(
          height: 8.0,
        ),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(4, 4),
              ),
            ],
          ),
          child: TextFormField(
            controller: widget.controller,
            obscureText: isInvisible,
            decoration: InputDecoration(
              hintText: "Tu contraseña",
              hintStyle: const TextStyle(
                fontSize: 14.0,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14.0,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  isInvisible
                      ? Icons.remove_red_eye
                      : Icons.remove_red_eye_outlined,
                  color: const Color(0xff605AF8),
                ),
                onPressed: () {
                  isInvisible = !isInvisible;
                  setState(() {});
                },
              ),
              filled: true,
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.0),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.0),
                borderSide: BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.0),
                borderSide: BorderSide.none,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.0),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (String? value) {
              if (value != null && value.isEmpty) {
                return "Campo obligatorio";
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
