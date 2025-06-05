import 'package:flutter/material.dart';

class TelaDashboard extends StatelessWidget {
  final List<_DashboardOption> options = [
    _DashboardOption('VideoAula', Icons.play_circle_fill, Colors.blue),
    _DashboardOption('Aluno', Icons.person, Colors.green),
    _DashboardOption('Fabricante', Icons.factory, Colors.orange),
    _DashboardOption('Sala', Icons.meeting_room, Colors.purple),
    _DashboardOption('TipoManutencao', Icons.build, Colors.red),
    _DashboardOption('CategoriaMusica', Icons.music_note, Colors.teal),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: options.map((option) {
            return GestureDetector(
              onTap: () {
                // Navegação ou ação ao clicar
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: option.color.withOpacity(0.15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: option.color,
                      radius: 30,
                      child: Icon(option.icon, color: Colors.white, size: 32),
                    ),
                    SizedBox(height: 16),
                    Text(
                      option.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: option.color,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        items: [
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
  final Color color;

  _DashboardOption(this.title, this.icon, this.color);
}