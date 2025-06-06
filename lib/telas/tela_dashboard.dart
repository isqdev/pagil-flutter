import 'package:flutter/material.dart';
import '../routes.dart';

class TelaDashboard extends StatefulWidget {
  @override
  State<TelaDashboard> createState() => _TelaDashboardState();
}

class _TelaDashboardState extends State<TelaDashboard> {
  bool _isDark = false;

  final List<_DashboardOption> options = [
    _DashboardOption(
      'VideoAula',
      Icons.play_circle_fill,
      Colors.blue,
      AppRoutes.videoAula,
    ),
    _DashboardOption('Aluno', Icons.person, Colors.green, AppRoutes.aluno),
    _DashboardOption('Fabricante', Icons.factory, Colors.orange, AppRoutes.fabricante),
    _DashboardOption('Sala', Icons.meeting_room, Colors.purple, AppRoutes.sala),
    _DashboardOption('Banda', Icons.speaker_group_outlined, Colors.pink, AppRoutes.bandaArtista),
    _DashboardOption('Turma', Icons.class_outlined, Colors.yellow, AppRoutes.turma),
    _DashboardOption('TipoManutencao', Icons.build, Colors.red, AppRoutes.manutencao),
    _DashboardOption('CategoriaMusica', Icons.music_note, Colors.teal, AppRoutes.categoriaMusica,),
  ];

  @override
  Widget build(BuildContext context) {
    final backgroundGradient = _isDark
        ? const LinearGradient(
            colors: [Color(0xFF23243A), Color(0xFF181824)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : const LinearGradient(
            colors: [Color(0xFFE3E6F3), Color(0xFFF8F8FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AnimatedColorAppBar(
          isDark: _isDark,
          onThemeToggle: () {
            setState(() {
              _isDark = !_isDark;
            });
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: backgroundGradient,
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
                  color: _isDark
                      ? option.color.shade900.withOpacity(0.7)
                      : null,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: _isDark
                          ? null
                          : LinearGradient(
                              colors: [
                                option.color.shade100,
                                option.color.shade50,
                                Colors.white
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                      color: _isDark
                          ? option.color.shade900.withOpacity(0.7)
                          : null,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: option.color.withOpacity(0.18),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 8,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: option.color,
                            radius: 34,
                            child: Icon(
                              option.icon,
                              color: Colors.white,
                              size: 36,
                            ),
                          ),
                          const SizedBox(height: 18),
                          Text(
                            option.title,
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                              color: _isDark
                                  ? option.color.shade100
                                  : option.color.shade700,
                              letterSpacing: 1.1,
                            ),
                          ),
                          if (option.route != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: SizedBox(
                                width: 110,
                                height: 36,
                                child: ElevatedButton(
                                  onPressed: () => Navigator.pushNamed(
                                    context,
                                    option.route!,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: option.color,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 2,
                                    foregroundColor: Colors.white,
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  child: const Text('Acessar'),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: _isDark ? Colors.indigo.shade200 : Colors.indigo.shade700,
        unselectedItemColor: Colors.grey.shade500,
        backgroundColor: _isDark ? const Color(0xFF23243A) : Colors.white,
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

// Widget para AppBar com fundo animado multicolorido
class AnimatedColorAppBar extends StatefulWidget {
  final bool isDark;
  final VoidCallback onThemeToggle;
  const AnimatedColorAppBar({Key? key, required this.isDark, required this.onThemeToggle}) : super(key: key);

  @override
  State<AnimatedColorAppBar> createState() => _AnimatedColorAppBarState();
}

class _AnimatedColorAppBarState extends State<AnimatedColorAppBar> with SingleTickerProviderStateMixin {
  final List<Color> _colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];
  int _currentIndex = 0;
  late Color _currentColor;
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _currentColor = _colors[_currentIndex];
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _setNextAnimation();
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _currentIndex = (_currentIndex + 1) % _colors.length;
        _setNextAnimation();
        _controller.forward(from: 0);
      }
    });
  }

  void _setNextAnimation() {
    final nextIndex = (_currentIndex + 1) % _colors.length;
    _colorAnimation = ColorTween(
      begin: _colors[_currentIndex],
      end: _colors[nextIndex],
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return Container(
          // Remove padding/margin/borderRadius para evitar "tira" abaixo do AppBar
          child: AppBar(
            title: const Text(
              'Deliquentes',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Colors.white,
                fontSize: 24,
                letterSpacing: 1.2,
              ),
            ),
            backgroundColor: _colorAnimation.value,
            elevation: 6,
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(widget.isDark ? Icons.light_mode : Icons.dark_mode, color: Color(0xFFF8F8FF)),
                tooltip: 'Alternar tema',
                onPressed: widget.onThemeToggle,
              ),
            ],
            // shape: const RoundedRectangleBorder(
            //   borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
            // ),
          ),
        );
      },
    );
  }
}