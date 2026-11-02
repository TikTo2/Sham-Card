
import 'package:flutter/material.dart';

void main() {
  runApp(const ShamCardApp());
}

const purple = Color(0xFF9B6DFF);
const darkBg = Color(0xFF090810);
const darkPanel = Color(0xFF171324);

class ShamCardApp extends StatefulWidget {
  const ShamCardApp({super.key});

  @override
  State<ShamCardApp> createState() => _ShamCardAppState();
}

class _ShamCardAppState extends State<ShamCardApp> {
  bool english = false;
  bool light = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SHAM CARD',
      theme: ThemeData(
        useMaterial3: true,
        brightness: light ? Brightness.light : Brightness.dark,
        scaffoldBackgroundColor:
            light ? const Color(0xFFF5F2FA) : darkBg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: purple,
          brightness: light ? Brightness.light : Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      home: MainScreen(
        english: english,
        light: light,
        onLanguage: (v) => setState(() => english = v),
        onTheme: (v) => setState(() => light = v),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  final bool english;
  final bool light;
  final ValueChanged<bool> onLanguage;
  final ValueChanged<bool> onTheme;

  const MainScreen({
    super.key,
    required this.english,
    required this.light,
    required this.onLanguage,
    required this.onTheme,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int tab = 0;
  double balance = 2450;
  final List<String> history = [
    'Welcome bonus / مكافأة ترحيبية',
  ];

  String t(String ar, String en) => widget.english ? en : ar;

  void addDemo() {
    setState(() {
      balance += 100;
      history.insert(
        0,
        t('إضافة افتراضية +100', 'Demo credit +100'),
      );
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(t(
          'تم تحديث الرصيد الافتراضي',
          'Demo balance updated',
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(
        english: widget.english,
        balance: balance,
        onAdd: addDemo,
        openTab: (v) => setState(() => tab = v),
      ),
      MarketsPage(english: widget.english),
      AssistantPage(english: widget.english),
      WalletPage(
        english: widget.english,
        balance: balance,
        history: history,
        onAdd: addDemo,
      ),
      ProfilePage(
        english: widget.english,
        light: widget.light,
        onLanguage: widget.onLanguage,
        onTheme: widget.onTheme,
      ),
    ];

    final labels = widget.english
        ? ['Home', 'Markets', 'Assistant', 'Wallet', 'Profile']
        : ['الرئيسية', 'الأسواق', 'المساعد', 'المحفظة', 'حسابي'];

    final icons = [
      Icons.grid_view_rounded,
      Icons.show_chart_rounded,
      Icons.auto_awesome,
      Icons.account_balance_wallet_outlined,
      Icons.person_outline_rounded,
    ];

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: tab, children: pages),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        backgroundColor: widget.light
            ? Colors.white
            : const Color(0xFF110E1B),
        indicatorColor: purple.withOpacity(.2),
        onDestinationSelected: (v) => setState(() => tab = v),
        destinations: List.generate(
          5,
          (i) => NavigationDestination(
            icon: Icon(icons[i]),
            label: labels[i],
          ),
        ),
      ),
    );
  }
}

// ---------------- HOME ----------------

class HomePage extends StatelessWidget {
  final bool english;
  final double balance;
  final VoidCallback onAdd;
  final ValueChanged<int> openTab;

  const HomePage({
    super.key,
    required this.english,
    required this.balance,
    required this.onAdd,
    required this.openTab,
  });

  @override
  Widget build(BuildContext context) {
    String t(String ar, String en) => english ? en : ar;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const BrandHeader(),
        const SizedBox(height: 28),
        Text(t('مرحباً بك 👋', 'Welcome 👋'),
            style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 5),
        Text(
          t('لوحة التحكم', 'Dashboard'),
          style: const TextStyle(
              fontSize: 28, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF633A9C),
                Color(0xFF302047),
                Color(0xFF171324),
              ],
            ),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: purple.withOpacity(.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                const Icon(Icons.account_balance_wallet_outlined),
                const SizedBox(width: 8),
                Text(t('رصيدك الافتراضي', 'Your demo balance')),
                const Spacer(),
                const Icon(Icons.more_horiz),
              ]),
              const SizedBox(height: 22),
              Text(
                '\$ ${balance.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                t('قيمة افتراضية للعرض فقط',
                    'Virtual value for display only'),
                style: const TextStyle(
                    color: Color(0xFFD5C8E8), fontSize: 12),
              ),
              const SizedBox(height: 22),
              Row(children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: onAdd,
                    icon: const Icon(Icons.add),
                    label: Text(t('إضافة تجريبية', 'Demo add')),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => openTab(3),
                    icon: const Icon(Icons.history),
                    label: Text(t('السجل', 'History')),
                  ),
                ),
              ]),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Row(children: [
          Expanded(child: InfoTile(
            icon: Icons.swap_horiz,
            title: t('العمليات', 'Activity'),
            value: '01',
          )),
          const SizedBox(width: 12),
          Expanded(child: InfoTile(
            icon: Icons.credit_card,
            title: t('البطاقة', 'Card'),
            value: 'DEMO',
          )),
        ]),
        const SizedBox(height: 25),
        SectionTitle(t('خدمات شام كارد', 'SHAM CARD services')),
        const SizedBox(height: 13),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.4,
          children: [
            ServiceTile(
              icon: Icons.show_chart,
              title: t('الأسواق', 'Markets'),
              subtitle: t('بيانات توضيحية', 'Demo information'),
              onTap: () => openTab(1),
            ),
            ServiceTile(
              icon: Icons.auto_awesome,
              title: t('المساعد الذكي', 'AI assistant'),
              subtitle: t('مساعد تعليمي', 'Learning assistant'),
              onTap: () => openTab(2),
            ),
            ServiceTile(
              icon: Icons.account_balance_wallet,
              title: t('المحفظة', 'Wallet'),
              subtitle: t('إدارة الرصيد الافتراضي', 'Demo wallet'),
              onTap: () => openTab(3),
            ),
            ServiceTile(
              icon: Icons.person_outline,
              title: t('حسابي', 'My account'),
              subtitle: t('الإعدادات الشخصية', 'Personal settings'),
              onTap: () => openTab(4),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const DemoNotice(),
      ],
    );
  }
}

// ---------------- MARKETS ----------------

class MarketsPage extends StatefulWidget {
  final bool english;
  const MarketsPage({super.key, required this.english});

  @override
  State<MarketsPage> createState() => _MarketsPageState();
}

class _MarketsPageState extends State<MarketsPage> {
  String search = '';

  final assets = const [
    ['BTC', 'Bitcoin', '67250.00', '+2.4%'],
    ['ETH', 'Ethereum', '3520.00', '+1.8%'],
    ['SOL', 'Solana', '145.20', '-0.8%'],
    ['XRP', 'XRP', '0.62', '+1.2%'],
    ['BNB', 'BNB', '580.00', '+0.5%'],
    ['ADA', 'Cardano', '0.45', '-1.1%'],
  ];

  @override
  Widget build(BuildContext context) {
    String t(String ar, String en) =>
        widget.english ? en : ar;

    final filtered = assets.where((a) =>
      a[0].toLowerCase().contains(search.toLowerCase()) ||
      a[1].toLowerCase().contains(search.toLowerCase())
    ).toList();

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const BrandHeader(),
        const SizedBox(height: 25),
        SectionTitle(t('الأسواق', 'Markets')),
        const SizedBox(height: 6),
        Text(t('بيانات تعليمية افتراضية',
            'Illustrative educational data'),
            style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 18),
        TextField(
          onChanged: (v) => setState(() => search = v),
          decoration: InputDecoration(
            hintText: t('ابحث عن أصل...', 'Search assets...'),
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Theme.of(context).cardColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 20),
        ...filtered.map((a) => Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: purple.withOpacity(.18),
              child: Text(a[0][0],
                  style: const TextStyle(color: purple)),
            ),
            title: Text('${a[0]}  ·  ${a[1]}'),
            subtitle: Text(t('سعر توضيحي', 'Illustrative price')),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('\$${a[2]}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold)),
                Text(
                  a[3],
                  style: TextStyle(
                    color: a[3].startsWith('+')
                        ? Colors.green
                        : Colors.redAccent,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        )),
        if (filtered.isEmpty)
          Padding(
            padding: const EdgeInsets.all(25),
            child: Text(t('لا توجد نتائج', 'No results found'),
                textAlign: TextAlign.center),
          ),
        const SizedBox(height: 15),
        SectionTitle(t('مخطط توضيحي', 'Illustrative chart')),
        const SizedBox(height: 12),
        Container(
          height: 180,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: CustomPaint(
            painter: DemoChartPainter(),
            child: const SizedBox.expand(),
          ),
        ),
        const SizedBox(height: 15),
        const DemoNotice(),
      ],
    );
  }
}

// ---------------- ASSISTANT ----------------

class AssistantPage extends StatefulWidget {
  final bool english;
  const AssistantPage({super.key, required this.english});

  @override
  State<AssistantPage> createState() => _AssistantPageState();
}

class _AssistantPageState extends State<AssistantPage> {
  final controller = TextEditingController();
  final List<Map<String, String>> messages = [];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String answer(String question) {
    final q = question.toLowerCase();

    if (q.contains('bitcoin') || q.contains('بتكوين') ||
        q.contains('بيتكوين')) {
      return widget.english
          ? 'Bitcoin is a digital asset that uses a decentralized network.'
          : 'البيتكوين أصل رقمي يستخدم شبكة لامركزية لتسجيل العمليات.';
    }

    if (q.contains('wallet') || q.contains('محفظة')) {
      return widget.english
          ? 'A digital wallet is a tool for managing digital assets.'
          : 'المحفظة الرقمية أداة لإدارة الأصول الرقمية والمعلومات المرتبطة بها.';
    }

    if (q.contains('blockchain') || q.contains('بلوك')) {
      return widget.english
          ? 'Blockchain is a distributed digital record.'
          : 'البلوك تشين هو سجل رقمي موزع يصعب تغيير بياناته السابقة.';
    }

    if (q.contains('market') || q.contains('سوق')) {
      return widget.english
          ? 'Markets are places where assets are exchanged. Prices can change.'
          : 'الأسواق أماكن لتبادل الأصول، وتتغير الأسعار فيها بمرور الوقت.';
    }

    return widget.english
        ? 'I am an educational demo assistant. Ask about Bitcoin, wallets, blockchain or markets.'
        : 'أنا مساعد تعليمي تجريبي. يمكنني شرح البيتكوين والمحافظ والبلوك تشين والأسواق.';
  }

  void send() {
    final value = controller.text.trim();
    if (value.isEmpty) return;

    setState(() {
      messages.add({'question': value, 'answer': answer(value)});
      controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    String t(String ar, String en) =>
        widget.english ? en : ar;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BrandHeader(),
              const SizedBox(height: 25),
              SectionTitle(t('المساعد الذكي', 'AI Assistant')),
              Text(t('مساعد تعليمي للمفاهيم الرقمية',
                  'Educational digital concepts assistant'),
                  style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        Expanded(
          child: messages.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Text(
                      t(
                        'مرحباً! اكتب سؤالك عن العملات الرقمية أو التقنية.',
                        'Hello! Ask a question about digital assets or technology.',
                      ),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.grey, fontSize: 16),
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  itemCount: messages.length,
                  itemBuilder: (context, i) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: ChatBubble(
                          text: messages[i]['question']!,
                          user: true,
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: ChatBubble(
                          text: messages[i]['answer']!,
                          user: false,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 8, 15, 15),
          child: Row(children: [
            Expanded(
              child: TextField(
                controller: controller,
                onSubmitted: (_) => send(),
                decoration: InputDecoration(
                  hintText: t('اكتب سؤالك...', 'Write a question...'),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filled(
              onPressed: send,
              icon: const Icon(Icons.send),
            ),
          ]),
        ),
      ],
    );
  }
}

// ---------------- WALLET ----------------

class WalletPage extends StatelessWidget {
  final bool english;
  final double balance;
  final List<String> history;
  final VoidCallback onAdd;

  const WalletPage({
    super.key,
    required this.english,
    required this.balance,
    required this.history,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    String t(String ar, String en) =>
        english ? en : ar;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const BrandHeader(),
        const SizedBox(height: 25),
        SectionTitle(t('المحفظة', 'Wallet')),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(23),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF633A9C), Color(0xFF241735)],
            ),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t('الرصيد الافتراضي', 'Demo balance')),
              const SizedBox(height: 14),
              Text(
                '\$ ${balance.toStringAsFixed(2)}',
                style: const TextStyle(
                    fontSize: 31, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              const Divider(color: Colors.white30),
              Text(t('محفظة تعليمية افتراضية',
                  'Virtual educational wallet')),
            ],
          ),
        ),
        const SizedBox(height: 25),
        SectionTitle(t('بطاقتي الافتراضية', 'My demo card')),
        const SizedBox(height: 12),
        Container(
          height: 190,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFB18AFF), Color(0xFF38205C)],
            ),
            borderRadius: BorderRadius.circular(21),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(children: [
                Text('SHAM CARD',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2)),
                Spacer(),
