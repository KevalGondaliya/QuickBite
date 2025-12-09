import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';

class PromoCodeDialog extends StatefulWidget {
  final ValueChanged<String> onApply;

  const PromoCodeDialog({
    super.key,
    required this.onApply,
  });

  @override
  State<PromoCodeDialog> createState() => _PromoCodeDialogState();
}

class _PromoCodeDialogState extends State<PromoCodeDialog> {
  final TextEditingController _controller = TextEditingController();
  String? _errorMessage;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _applyCode() {
    final code = _controller.text.trim().toUpperCase();
    
    if (code.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a promo code';
      });
      return;
    }

    if (AppConstants.promoCodes.containsKey(code)) {
      widget.onApply(code);
      Navigator.pop(context);
    } else {
      setState(() {
        _errorMessage = 'Invalid promo code';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Apply Promo Code'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Enter promo code',
              errorText: _errorMessage,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            textCapitalization: TextCapitalization.characters,
            onChanged: (_) {
              if (_errorMessage != null) {
                setState(() {
                  _errorMessage = null;
                });
              }
            },
          ),
          const SizedBox(height: 16),
          const Text(
            'Available Promo Codes:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          ...AppConstants.promoCodes.values.map((promo) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                '${promo.code}: ${promo.description}',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                ),
              ),
            );
          }),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _applyCode,
          child: const Text('Apply'),
        ),
      ],
    );
  }
}

