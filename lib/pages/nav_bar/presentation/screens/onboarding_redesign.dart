import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';

class OnboardingRedesign extends StatelessWidget {
  const OnboardingRedesign({super.key});

  static const _primary = Color(0xFFF97316);
  static const _secondary = Color(0xFF6366F1);
  static const _tertiary = Color(0xFF8B5CF6);
  static const _background = Color(0xFFFAFAF9);
  static const _onSurface = Color(0xFF1C1917);
  static const _onSurfaceVariant = Color(0xFF57534E);
  static const _indigo50 = Color(0xFFEEF2FF);
  static const _indigo950 = Color(0xFF1E1B4B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      bottomNavigationBar: _buildBottomNav(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 32,
          children: [
            _buildHero(),
            _buildSteps(),
            _buildInfoCard(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHero() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        color: _indigo50,
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(painter: const _DotPatternPainter()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                spacing: 16,
                children: [
                  const Text(
                    'Crie seu Amigo Secreto\nem Segundos',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 28,
                      color: _indigo950,
                      height: 1.2,
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 16,
                        color: _indigo950.withOpacity(0.7),
                        height: 1.6,
                      ),
                      children: const [
                        TextSpan(
                          text:
                              'Organize sorteios de forma simples e receba os resultados diretamente no ',
                        ),
                        TextSpan(
                          text: 'WhatsApp',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _primary,
                          ),
                        ),
                        TextSpan(text: ' de cada participante.'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primary,
                        foregroundColor: MyColors.neutral100,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: const StadiumBorder(),
                        elevation: 8,
                        shadowColor: _primary.withOpacity(0.35),
                      ),
                      child: const Text(
                        'Criar Meu Grupo Agora',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSteps() {
    const steps = [
      _StepData(
        step: '01',
        icon: Icons.group_add,
        title: 'Crie o seu grupo',
        description: 'Dê um nome criativo para o seu grupo de Amigo Secreto e defina as regras básicas.',
        color: _primary,
      ),
      _StepData(
        step: '02',
        icon: Icons.edit_note,
        title: 'Preencha as informações',
        description: 'Informe a data do evento, o valor sugerido do presente e o local da confraternização.',
        color: _secondary,
      ),
      _StepData(
        step: '03',
        icon: Icons.person_add,
        title: 'Adicione participantes',
        description: 'Insira os nomes e números de telefone dos amigos. Você também pode definir restrições.',
        color: _tertiary,
      ),
      _StepData(
        step: '04',
        icon: Icons.celebration,
        title: 'Realize o Sorteio',
        description: 'Com um clique, o sistema faz a mágica e avisa a todos via WhatsApp instantaneamente.',
        color: _primary,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        const Text(
          'Como funciona?',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 24,
            color: _onSurface,
          ),
        ),
        Row(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                spacing: 16,
                children: [
                  _StepCard(data: steps[0]),
                  _StepCard(data: steps[2]),
                ],
              ),
            ),
            Expanded(
              child: Column(
                spacing: 16,
                children: [
                  _StepCard(data: steps[1]),
                  _StepCard(data: steps[3]),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _indigo950,
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Positioned(
            right: -32,
            bottom: -32,
            child: Container(
              width: 128,
              height: 128,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _primary.withOpacity(0.2),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    const Text(
                      'Totalmente Gratuito',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: MyColors.neutral100,
                      ),
                    ),
                    Text(
                      'Organize quantos grupos quiser sem pagar nada. A diversão é por nossa conta!',
                      style: TextStyle(
                        fontSize: 14,
                        color: MyColors.neutral100.withValues(alpha: 0.75),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: _primary,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: _primary.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.volunteer_activism, color: MyColors.neutral100, size: 36),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      spacing: 12,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 32,
          children: const [
            _FooterLink(label: 'Termos de Uso'),
            _FooterLink(label: 'Privacidade'),
            _FooterLink(label: 'Ajuda'),
          ],
        ),
        const Text(
          '© 2024 Amigo Secreto Aura Pro. Todos os direitos reservados.',
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFFA8A29E),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.neutral100,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _NavItem(icon: Icons.home, label: 'Home', isActive: true),
              _NavItem(icon: Icons.group, label: 'Groups'),
              _NavItem(icon: Icons.celebration, label: 'My Draws'),
              _NavItem(icon: Icons.settings, label: 'Settings'),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Dot pattern painter ──────────────────────────────────────────────────────

class _DotPatternPainter extends CustomPainter {
  const _DotPatternPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF6366F1).withOpacity(0.1)
      ..style = PaintingStyle.fill;
    const spacing = 32.0;
    for (double x = 0; x <= size.width; x += spacing) {
      for (double y = 0; y <= size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1.2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─── Step card ────────────────────────────────────────────────────────────────

class _StepData {
  final String step;
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _StepData({
    required this.step,
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}

class _StepCard extends StatelessWidget {
  final _StepData data;
  const _StepCard({required this.data});

  static const _outlineVariant = Color(0xFFE7E5E4);
  static const _onSurface = Color(0xFF1C1917);
  static const _onSurfaceVariant = Color(0xFF57534E);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MyColors.neutral100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: data.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(data.icon, color: data.color, size: 28),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              Text(
                'PASSO ${data.step}',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                  color: data.color.withOpacity(0.7),
                ),
              ),
              Text(
                data.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: _onSurface,
                ),
              ),
              Text(
                data.description,
                style: const TextStyle(
                  fontSize: 12,
                  color: _onSurfaceVariant,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Footer link ──────────────────────────────────────────────────────────────

class _FooterLink extends StatelessWidget {
  final String label;
  const _FooterLink({required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Color(0xFF57534E),
        ),
      ),
    );
  }
}

// ─── Bottom nav item ──────────────────────────────────────────────────────────

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  const _NavItem({required this.icon, required this.label, this.isActive = false});

  static const _primary = Color(0xFFF97316);
  static const _indigo950 = Color(0xFF1E1B4B);

  @override
  Widget build(BuildContext context) {
    if (isActive) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: _primary,
          borderRadius: BorderRadius.circular(999),
          boxShadow: [
            BoxShadow(
              color: _primary.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 2,
          children: [
            Icon(icon, color: MyColors.neutral100, size: 22),
            Text(
              label.toUpperCase(),
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: MyColors.neutral100,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 2,
        children: [
          Icon(icon, color: _indigo950.withOpacity(0.35), size: 22),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: _indigo950.withOpacity(0.35),
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}
