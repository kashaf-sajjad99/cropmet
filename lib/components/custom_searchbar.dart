import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final String hintText;
  final VoidCallback onSearch;
  final ValueChanged<String>? onChanged; // Only one declaration here
  final TextEditingController? controller;

  const CustomSearchBar({
    super.key,
    required this.hintText,
    required this.onSearch,
    this.onChanged,
    this.controller,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = widget.controller ?? TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 45,
      child: TextField(
        controller: searchController,
        onSubmitted: (_) => widget.onSearch(),
        onChanged: widget.onChanged, // This handles live filtering
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.search,
              color: Color.fromARGB(255, 137, 137, 137),
            ),
            onPressed: widget.onSearch,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 16,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
