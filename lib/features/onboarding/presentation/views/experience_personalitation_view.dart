import 'package:experience_app/features/onboarding/presentation/widgets/container_interests.dart';
import 'package:flutter/material.dart';

class ExperiencePersonalitationView extends StatelessWidget {
  const ExperiencePersonalitationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 25,    
            right: 25,  
            top: 16.0,    
            bottom: 16.0, 
          ), 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              // 1. Indicador de progreso fijo arriba
              SizedBox(
                height: 12.0,
                child: LinearProgressIndicator(
                  value: 0.5,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
              const SizedBox(height: 20.0),
              
              // 2. Textos fijos arriba
              const Text(
                'Personalise your experience',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 12.0),
              const Text(
                'Choose your interests',
                style: TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 20.0),
              
              // 3. El contenedor de intereses ahora puede hacer scroll si no cabe
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(), // Da un efecto suave al deslizar
                  child: const ContainerInterests(),
                ),
              ),
              
              const SizedBox(height: 16.0), // Separación controlada antes del botón fijo
              
              // 4. Botón "Next" siempre visible y fijo abajo
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006FFD),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Next",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
