import 'package:flutter/material.dart';

void main() {
  runApp(const ShamCardApp());
}

const Color bg = Color(0xFF090810);
const Color panel = Color(0xFF151222);
const Color purple = Color(0xFF9B6DFF);
const Color muted = Color(0xFFAAA5B8);

class ShamCardApp extends StatelessWidget {
  const ShamCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SHAM CARD',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: purple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int index = 0;

  final List<Widget> pages = const [
    HomePage(),
    MarketsPage(),
    AssistantPage(),
    WalletPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: pages[index]),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF110E1B),
        indicatorColor: purple.withOpacity(0.22),
        selectedIndex: index,
        onDestinationSelected: (value) {
          setState(() => index = value);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.grid_view_rounded),
            label: 'الرئيسية',
          ),
          NavigationDestination(
            icon: Icon(Icons.show_chart_rounded),
            label: 'الأسواق',
          ),
          NavigationDestination(
            icon: Icon(Icons.auto_awesome),
            label: 'المساعد',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: 'المحفظة',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            label: 'حسابي',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
      children: [
        Row(
          children: [
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFB18AFF),
                    Color(0xFF5425A8),
                  ],
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Center(
                child: Text(
                  'SC',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SHAM CARD',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'مساحتك الرقمية',
                  style: TextStyle(
                    color: muted,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_rounded),
            ),
          ],
        ),

        const SizedBox(height: 28),

        const Text(
          'مرحباً بك 👋',
          style: TextStyle(color: muted, fontSize: 14),
        ),

        const SizedBox(height: 5),

        const Text(
          'لوحة التحكم',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 20),

        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF49277C),
                Color(0xFF211633),
                Color(0xFF151222),
              ],
            ),
            border: Border.all(
              color: purple.withOpacity(0.35),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    size: 18,
                  ),
                  SizedBox(width: 8),
                  Text('الرصيد التجريبي'),
                  Spacer(),
                  Icon(Icons.more_horiz),
                ],
              ),

              const SizedBox(height: 22),

              const Text(
                '\$ 2,450.00',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'قيمة افتراضية للعرض فقط',
                style: TextStyle(
                  color: Color(0xFFD2C5E8),
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 22),

              Row(
                children: [
                  Expanded(
                    child: ActionButton(
                      icon: Icons.add,
                      label: 'إضافة تجريبية',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ActionButton(
                      icon: Icons.history,
                      label: 'السجل',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 25),

        const Text(
          'الخدمات',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 4),

        const Text(
          'استكشف أقسام شام كارد',
          style: TextStyle(
            color: muted,
            fontSize: 12,
          ),
        ),

        const SizedBox(height: 14),

        const GridServices(),

        const SizedBox(height: 20),

        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: panel,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(0.07),
            ),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, color: purple),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'SHAM CARD نسخة تجريبية تعليمية. '
                  'جميع الأرصدة والأسعار والعمليات افتراضية '
                  'ولا تمثل أموالاً حقيقية.',
                  style: TextStyle(
                    color: muted,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 11,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.10),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 17),
          const SizedBox(width: 7),
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}

class GridServices extends StatelessWidget {
  const GridServices({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.credit_card_rounded, 'بطاقتي', 'بطاقة افتراضية تجريبية'),
      (Icons.swap_horiz_rounded, 'العمليات', 'سجل توضيحي افتراضي'),
      (Icons.trending_up_rounded, 'الأسواق', 'بيانات تعليمية'),
      (Icons.auto_awesome, 'المساعد الذكي', 'تعلّم المصطلحات'),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.45,
      children: items.map((item) {
        return Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: panel,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.white.withOpacity(0.07),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(item.$1, color: purple, size: 25),
              const SizedBox(height: 10),
              Text(
                item.$2,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                item.$3,
                style: const TextStyle(
                  color: muted,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class MarketsPage extends StatelessWidget {
  const MarketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimplePage(
      icon: Icons.show_chart_rounded,
      title: 'الأسواق',
      subtitle: 'بيانات وأسعار توضيحية',
      message: 'ستظهر هنا الأسواق التجريبية والرسوم التعليمية.',
    );
  }
}

class AssistantPage extends StatelessWidget {
  const AssistantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimplePage(
      icon: Icons.auto_awesome,
      title: 'المساعد الذكي',
      subtitle: 'تعلّم المصطلحات المالية',
      message: 'قسم تعليمي لشرح المفاهيم، وليس لتقديم توصيات استثمارية.',
    );
  }
}

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimplePage(
      icon: Icons.account_balance_wallet_outlined,
      title: 'المحفظة',
      subtitle: 'محفظة افتراضية',
      message: 'الرصيد وسجل العمليات هنا افتراضيان فقط.',
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimplePage(
      icon: Icons.person_outline_rounded,
      title: 'حسابي',
      subtitle: 'إعدادات SHAM CARD',
      message: 'ستضاف إعدادات اللغة والمظهر لاحقاً.',
    );
  }
}

class SimplePage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String message;

  const SimplePage({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: purple.withOpacity(0.15),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(icon, color: purple, size: 36),
            ),
            const SizedBox(height: 22),
            Text(
              title,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              subtitle,
              style: const TextStyle(color: muted),
            ),
            const SizedBox(height: 20),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: muted,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'DEMO VERSION',
              style: TextStyle(
                color: purple,
                letterSpacing: 2,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
