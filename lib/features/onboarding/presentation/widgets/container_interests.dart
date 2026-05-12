import 'package:flutter/material.dart';

class ContainerInterests extends StatefulWidget {
  const ContainerInterests({super.key});

  @override
  State<ContainerInterests> createState() => _ContainerInterestsState();
}

class _ContainerInterestsState extends State<ContainerInterests> {
  final List<String> _interests = [
    'User Interface',
    'User Experience',
    'User Research',
    'UX Writing',
    'User Testing',
    'Service Design',
    'Strategy',
    'Design Systems',
  ];
  
  final Set<int> _selectedIndices = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _interests.asMap().entries.map((entry) {
        int index = entry.key;
        String title = entry.value;
        bool isSelected = _selectedIndices.contains(index);

        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: OutlinedButton(
              onPressed: () {
                setState(() {
                  if (isSelected) {
                    _selectedIndices.remove(index);
                  } else {
                    _selectedIndices.add(index);
                  }
                });
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: isSelected ? const Color(0xFFEDF2FF) : Colors.white,
                side: BorderSide(
                  color: isSelected ? Colors.transparent : const Color(0xFFE2E8F0),
                  width: 1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: const Color(0xFF1E293B),
                      fontSize: 15,
                      fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                    ),
                  ),
                  if (isSelected)
                    const Icon(
                      Icons.check,
                      color: Color(0xFF2563EB),
                      size: 20,
                    ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
