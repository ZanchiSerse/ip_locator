import 'package:flutter/material.dart';
import 'package:myapp/utils/validators.dart';

class IpInputField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSubmitted;


  const IpInputField({super.key, required this.controller, required this.onSubmitted});

  @override
  State<IpInputField> createState() => _IpInputFieldState();
}

class _IpInputFieldState extends State<IpInputField> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: widget.controller,
            decoration: InputDecoration(
              labelText: 'Enter IP Address',
              hintText: 'e.g., 8.8.8.8 or google.com',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onSubmitted(widget.controller.text);
                  }
                },
              ),
            ),
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return null; // Allow empty input (for current IP)
              }
              if (!Validators.isValidIpAddress(value) &&
                  !Validators.isValidHostname(value)) {
                return 'Please enter a valid IP address or hostname';
              }
              return null;
            },
            onFieldSubmitted: (_) {
              if (_formKey.currentState!.validate()) {
                widget.onSubmitted(widget.controller.text);
              }
            },
          ),
        ],
      ),
    );
  }
}