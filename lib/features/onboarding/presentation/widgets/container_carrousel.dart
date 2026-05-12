import 'package:flutter/material.dart';

class ContainerCarrousel extends StatefulWidget {
  const ContainerCarrousel({
    super.key,
    required this.pages,
    required this.controller,
    this.onPageChanged,
  });

  final List<Map<String, String>> pages;
  final PageController controller;
  final void Function(int)? onPageChanged;

  @override
  State<ContainerCarrousel> createState() => _ContainerCarrouselState();
}

class _ContainerCarrouselState extends State<ContainerCarrousel> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // las lineas cuando muevo el carrousel
        Row(
          children: List.generate(
            widget.pages.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(right: 6),
              width: currentPage == index ? 20 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: currentPage == index
                    ? Colors.blue
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // el texto deslizable
        Expanded(
          child: PageView.builder(
            controller: widget.controller,
            itemCount: widget.pages.length,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
              widget.onPageChanged?.call(index);
            },
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.pages[index]["title"]!,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    widget.pages[index]["desc"]!,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
