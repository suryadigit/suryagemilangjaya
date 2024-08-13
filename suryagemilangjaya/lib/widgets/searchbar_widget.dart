import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SearchBars extends StatelessWidget {
  final String hintText;

  const SearchBars({
    super.key,
    required this.hintText,
  });

  void onPressed() {}

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              hintText: 'Cari nama barang, barcode, category',
              prefixIcon: PhosphorIcon(PhosphorIcons.magnifyingGlass()),
              suffixIcon: PhosphorIcon(PhosphorIcons.fadersHorizontal()),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: onPressed,
          icon: PhosphorIcon(PhosphorIcons.barcode()),
        ),
      ],
    );
  }
}
