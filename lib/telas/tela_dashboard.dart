import 'package:flutter/material.dart';
import '../routes.dart';

class TelaDashboard extends StatelessWidget {
  final List<_DashboardOption> options = [
    _DashboardOption('VideoAula', Icons.play_circle_fill, Colors.blue, null),
    _DashboardOption('Aluno', Icons.person, Colors.green, AppRoutes.aluno),
    _DashboardOption('Fabricante', Icons.factory, Colors.orange, null),
    _DashboardOption('Sala', Icons.meeting_room, Colors.purple, AppRoutes.sala),
    _DashboardOption('TipoManutencao', Icons.build, Colors.red, AppRoutes.manutencao),
    _DashboardOption('CategoriaMusica', Icons.music_note, Colors.teal, null),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.indigo.shade700,
        elevation: 6,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3E6F3), Color(0xFFF8F8FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
            children: options.map((option) {
              return GestureDetector(
                onTap: option.route != null
                    ? () => Navigator.pushNamed(context, option.route!)
                    : null,
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: option.color.withOpacity(0.18),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: option.color,
                          radius: 34,
                          child: Icon(option.icon, color: Colors.white, size: 36),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          option.title,
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                            color: option.color.shade700,
                            letterSpacing: 1.1,
                          ),
                        ),
                        if (option.route != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Icon(Icons.arrow_forward_ios, size: 18, color: option.color.shade700),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.indigo.shade700,
        unselectedItemColor: Colors.grey.shade500,
        backgroundColor: Colors.white,
        elevation: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
      ),
    );
  }
}

class _DashboardOption {
  final String title;
  final IconData icon;
  final MaterialColor color;
  final String? route;

  _DashboardOption(this.title, this.icon, this.color, this.route);
}