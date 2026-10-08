import 'package:flutter/material.dart';

void main() {
  runApp(const GarajYatirimApp());
}

class GarajYatirimApp extends StatelessWidget {
  const GarajYatirimApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Garaj Yatırım Oyunu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.amber,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/game': (context) => const GameHomeScreen(),
        '/admin': (context) => const AdminDashboardScreen(),
      },
    );
  }
}

// --- GİRİŞ & KAYIT EKRANI (DESENLİ) ---
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int _logoClickCount = 0;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  // Gizli Admin Giriş Tetikleyicisi (5 kez basınca açılır)
  void _handleLogoTap() {
    setState(() {
      _logoClickCount++;
    });
    if (_logoClickCount >= 5) {
      _logoClickCount = 0;
      _showAdminLoginDialog();
    }
  }

  void _showAdminLoginDialog() {
    final adminPhone = TextEditingController();
    final adminPass = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sistem Yönetici Girişi'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: adminPhone,
              decoration: const InputDecoration(labelText: 'Admin Telefon'),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: adminPass,
              decoration: const InputDecoration(labelText: 'Şifre'),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (adminPhone.text == '5334657446' && adminPass.text == 'TAYLAN446') {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/admin');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Hatalı Yönetici Bilgisi!')),
                );
              }
            },
            child: const Text('Giriş Yap'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _handleLogoTap,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.amber.withOpacity(0.2),
                        border: Border.all(color: Colors.amber, width: 2),
                      ),
                      child: const Icon(Icons.directions_car, size: 70, color: Colors.amber),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'GARAJ YATIRIM OYUNU',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone),
                      labelText: 'Telefon Numarası',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _passController,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      labelText: 'Şifre',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/game');
                      },
                      child: const Text('GİRİŞ YAP / KAYIT OL', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// --- OYUN ANA EKRANI ---
class GameHomeScreen extends StatefulWidget {
  const GameHomeScreen({Key? key}) : super(key: key);

  @override
  _GameHomeScreenState createState() => _GameHomeScreenState();
}

class _GameHomeScreenState extends State<GameHomeScreen> {
  double balance = 150.0;
  int userLevel = 14; 
  double fuel = 80.0; 

  void _depositMoney() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('EFT / Havale ile Bakiye Yükle'),
        content: const Text('IBAN: TR56 0006 2000 0000 0000 0000 00\nAlıcı: Taylan Garaj A.Ş.\n\nYatırım yaptıktan sonra buton ile admine bildirin.'),
        actions: [
          TextButton(
            onPressed: () {
