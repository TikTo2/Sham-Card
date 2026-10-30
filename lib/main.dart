
import 'package:flutter/material.dart';

void main() {
  runApp(const ShamCardApp());
}

const Color purple = Color(0xFF9B6DFF);
const Color darkBg = Color(0xFF090810);
const Color lightBg = Color(0xFFF4F1FA);
const Color darkPanel = Color(0xFF151222);

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
        scaffoldBackgroundColor: light ? lightBg : darkBg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: purple,
          brightness: light ? Brightness.light : Brightness.dark,
        ),
      ),
      home: Directionality(
        textDirection:
            english ? TextDirection.ltr : TextDirection.rtl,
        child: MainScreen(
          english: english,
          light: light,
          onLanguage: (v) => setState(() => english = v),
          onTheme: (v) => setState(() => light = v),
        ),
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
  int selected = 0;
  double balance = 2450;
  final List<String> transactions = [
    'Welcome bonus / مكافأة ترحيبية',
    'Demo payment / عملية تجريبية',
  ];

  String t(String ar, String en) =>
      widget.english ? en : ar;

  void demoAdd() {
    setState(() {
      balance += 100;
      transactions.insert(
        0,
        t('إضافة تجريبية +100', 'Demo credit +100'),
      );
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(t(
        'تمت إضافة 100 إلى الرصيد الافتراضي',
        '100 added to demo balance',
      ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(
        english: widget.english,
        balance: balance,
        onAdd: demoAdd,
        onOpenWallet: () => setState(() => selected = 3),
        onOpenMarkets: () => setState(() => selected = 1),
      ),
      MarketsPage(english: widget.english),
      AssistantPage(english: widget.english),
      WalletPage(
        english: widget.english,
        balance: balance,
        transactions: transactions,
        onAdd: demoAdd,
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
      body: SafeArea(child: IndexedStack(
        index: selected,
        children: pages,
      )),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selected,
        backgroundColor: widget.light
            ? Colors.white
            : const Color(0xFF110E1B),
        indicatorColor: purple.withOpacity(0.20),
        onDestinationSelected: (v) =>
            setState(() => selected = v),
        destinations: List.generate(5, (i) =>
          NavigationDestination(
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
  final VoidCallback onOpenWallet;
  final VoidCallback onOpenMarkets;

  const HomePage({
    super.key,
    required this.english,
    required this.balance,
    required this.onAdd,
    required this.onOpenWallet,
    required this.onOpenMarkets,
  });

  @override
  Widget build(BuildContext context) {
    final t = (String ar, String en) => english ? en : ar;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const BrandHeader(),
        const SizedBox(height: 28),
        Text(t('مرحباً بك 👋', 'Welcome 👋'),
          style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 5),
        Text(t('لوحة التحكم', 'Dashboard'),
          style: const TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
          )),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF6236A0),
                Color(0xFF211633),
                Color(0xFF151222),
              ],
            ),
            border: Border.all(color: purple.withOpacity(.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t('إجمالي الرصيد الافتراضي',
                  'Total demo balance')),
              const SizedBox(height: 17),
              Text('\$ ${balance.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                )),
              const SizedBox(height: 7),
              Text(t('رصيد افتراضي للتجربة فقط',
                  'Virtual balance for demonstration only'),
                style: const TextStyle(fontSize: 11)),
              const SizedBox(height: 22),
              Row(children: [
                Expanded(child: FilledButton.icon(
                  onPressed: onAdd,
                  icon: const Icon(Icons.add),
                  label: Text(t('إضافة تجريبية', 'Demo add')),
                )),
                const SizedBox(width: 10),
                Expanded(child: OutlinedButton.icon(
                  onPressed: onOpenWallet,
                  icon: const Icon(Icons.history),
                  label: Text(t('السجل', 'History')),
                )),
              ]),
            ],
          ),
        ),
        const SizedBox(height: 24),
        SectionTitle(t('الخدمات', 'Services')),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.35,
          children: [
            ServiceTile(
              icon: Icons.credit_card,
              title: t('بطاقتي', 'My Card'),
              subtitle: t('بطاقة افتراضية', 'Virtual card'),
              onTap: onOpenWallet,
            ),
            ServiceTile(
              icon: Icons.show_chart,
              title: t('الأسواق', 'Markets'),
              subtitle: t('بيانات توضيحية', 'Demo data'),
              onTap: onOpenMarkets,
            ),
            ServiceTile(
              icon: Icons.account_balance_wallet,
              title: t('المحفظة', 'Wallet'),
              subtitle: t('رصيد تجريبي', 'Demo balance'),
              onTap: onOpenWallet,
            ),
            ServiceTile(
              icon: Icons.auto_awesome,
              title: t('المساعد', 'Assistant'),
              subtitle: t('مساعد تعليمي', 'Learning assistant'),
              onTap: onOpenMarkets,
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
    final shown = assets.where((a) =>
      a[0].toLowerCase().contains(search.toLowerCase()) ||
      a[1].toLowerCase().contains(search.toLowerCase())
    ).toList();

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        BrandHeader(),
        const SizedBox(height: 25),
        Text(widget.english ? 'Markets' : 'الأسواق',
          style: const TextStyle(
            fontSize: 27, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Text(widget.english
            ? 'Illustrative market information'
            : 'معلومات سوقية توضيحية',
            style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 18),
        TextField(
          onChanged: (v) => setState(() => search = v),
          decoration: InputDecoration(
            hintText: widget.english ? 'Search assets...' : 'ابحث عن أصل...',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: darkPanel,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 20),
        ...shown.map((a) => Card(
          color: darkPanel,
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: purple.withOpacity(.2),
              child: Text(a[0][0],
                style: const TextStyle(color: purple)),
            ),
            title: Text('${a[0]}  ·  ${a[1]}'),
            subtitle: Text(widget.english
                ? 'Illustrative price'
                : 'سعر توضيحي'),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('\$${a[2]}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(a[3],
                  style: TextStyle(
                    color: a[3].startsWith('+')
                        ? Colors.greenAccent
                        : Colors.redAccent,
                    fontSize: 12,
                  )),
              ],
            ),
          ),
        )),
        const SizedBox(height: 15),
        SectionTitle(widget.english
            ? 'Illustrative chart'
            : 'رسم بياني توضيحي'),
        const SizedBox(height: 12),
        Container(
          height: 170,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: darkPanel,
            borderRadius: BorderRadius.circular(18),
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

  String answer(String question) {
    final q = question.toLowerCase();

    if (q.contains('bitcoin') || q.contains('بتكوين')) {
      return widget.english
          ? 'Bitcoin is a digital asset that operates on a decentralized network.'
          : 'البيتكوين أصل رقمي يعمل عبر شبكة لامركزية.';
    }
    if (q.contains('wallet') || q.contains('محفظة')) {
      return widget.english
          ? 'A digital wallet is a tool for managing digital assets.'
          : 'المحفظة الرقمية أداة لإدارة الأصول الرقمية.';
    }
    if (q.contains('blockchain') || q.contains('بلوك')) {
      return widget.english
          ? 'Blockchain is a distributed record of transactions.'
          : 'البلوك تشين سجل رقمي موزع لتوثيق البيانات والعمليات.';
    }
    if (q.contains('market') || q.contains('سوق')) {
      return widget.english
          ? 'A market is where assets are exchanged. Prices can change.'
          : 'السوق مكان لتبادل الأصول، وقد تتغير الأسعار باستمرار.';
    }

    return widget.english
        ? 'I am a demo learning assistant. Ask about Bitcoin, wallets, blockchain or markets.'
        : 'أنا مساعد تعليمي تجريبي. اسألني عن البيتكوين أو المحافظ أو البلوك تشين أو الأسواق.';
  }

  void send() {
    final value = controller.text.trim();
    if (value.isEmpty) return;

    setState(() {
      messages.add({'q': value, 'a': answer(value)});
      controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BrandHeader(),
              const SizedBox(height: 25),
              Text(widget.english ? 'AI Assistant' : 'المساعد الذكي',
                style: const TextStyle(
                  fontSize: 27, fontWeight: FontWeight.bold)),
              Text(widget.english
                  ? 'Learn digital finance concepts'
                  : 'تعلّم المفاهيم المالية الرقمية',
                  style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        Expanded(
          child: messages.isEmpty
              ? Center(child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Text(
                    widget.english
                        ? 'Hello! Ask me about Bitcoin, wallets or blockchain.'
                        : 'مرحباً! اسألني عن البيتكوين أو المحافظ أو البلوك تشين.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.grey, fontSize: 16),
                  ),
                ))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  itemCount: messages.length,
                  itemBuilder: (context, i) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: ChatBubble(
                          text: messages[i]['q']!,
                          user: true,
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: ChatBubble(
                          text: messages[i]['a']!,
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
            Expanded(child: TextField(
              controller: controller,
              onSubmitted: (_) => send(),
              decoration: InputDecoration(
                hintText: widget.english
                    ? 'Write a question...'
                    : 'اكتب سؤالك...',
                filled: true,
                fillColor: darkPanel,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            )),
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
  final List<String> transactions;
  final VoidCallback onAdd;

  const WalletPage({
    super.key,
    required this.english,
    required this.balance,
    required this.transactions,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final t = (String ar, String en) => english ? en : ar;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const BrandHeader(),
        const SizedBox(height: 25),
        Text(t('المحفظة', 'Wallet'),
          style: const TextStyle(
            fontSize: 27, fontWeight: FontWeight.bold)),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(22),
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
              const SizedBox(height: 15),
              Text('\$ ${balance.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              const Divider(color: Colors.white30),
              Row(children: [
                const Icon(Icons.lock_outline, size: 16),
                const SizedBox(width: 7),
                Text(t('محفظة تجريبية فقط', 'Demo wallet only')),
              ]),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SectionTitle(t('بطاقتي الافتراضية', 'My virtual card')),
        const SizedBox(height: 12),
        Container(
          height: 190,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFB18AFF), Color(0xFF38205C)],
            ),
            borderRadius: BorderRadius.circular(20),
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
                Icon(Icons.contactless),
              ]),
              const Spacer(),
              const Text('0000  ••••  ••••  2026',
                style: TextStyle(
                  fontSize: 19, letterSpacing: 1.5)),
              const SizedBox(height: 10),
              Row(children: [
                Text(t('بطاقة تجريبية', 'DEMO CARD')),
                const Spacer(),
                const Text('SC'),
              ]),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(children: [
          Expanded(child: SectionTitle(
            t('سجل العمليات', 'Activity history'))),
          TextButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.add),
            label: Text(t('إضافة تجريبية', 'Demo add')),
          ),
        ]),
        const SizedBox(height
