import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: Colors.transparent,

          // Aqui editamos el color de los iconos en el bottom bar
          iconTheme: WidgetStateProperty.resolveWith((states) {
             if (states.contains(WidgetState.selected)) {
              return const IconThemeData(
                color: Color(0xFF0066FF),
              );
            }
            return const IconThemeData(
              color: Color(0xFF9AA0A6),
            );
          }),

        // aqui editamos el texto del bottom bar

          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A),
              );
            }
            return const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: Color(0xFF70757A), // Texto gris sin seleccionar
            );
          }),
        ),
        
        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: (index) {
            navigationShell.goBranch(
              index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_rounded),
            label: 'Categories',
          ),
          NavigationDestination(
            icon: Icon(Icons.store_outlined),
            label: 'Stores',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            label: 'Profile',
          ),
        ],
      ),
      )
    );
  }
}
