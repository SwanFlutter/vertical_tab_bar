import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Brand Assets',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const TestBrandAssetsPage(),
    );
  }
}

class TestBrandAssetsPage extends StatefulWidget {
  const TestBrandAssetsPage({super.key});

  @override
  State<TestBrandAssetsPage> createState() => _TestBrandAssetsPageState();
}

class _TestBrandAssetsPageState extends State<TestBrandAssetsPage> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Test Brand Assets'),
          actions: [
            IconButton(
              icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: () {
                setState(() {
                  _isDarkMode = !_isDarkMode;
                });
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _isDarkMode ? 'Dark Mode' : 'Light Mode',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              Container(
                width: 300,
                height: 300,
                color: Colors.grey[200],
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.3,
                        child: Image.asset(
                          _isDarkMode
                              ? 'assets/brand/creator_logo_dark.png'
                              : 'assets/brand/creator_logo.png',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.error,
                                      size: 48, color: Colors.red),
                                  const SizedBox(height: 16),
                                  Text(
                                    'خطا در بارگذاری تصویر:\n${error.toString()}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        color: Colors.blue.withValues(alpha: 0.8),
                        child: const Text(
                          'محتوای روی برند',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isDarkMode = !_isDarkMode;
                  });
                },
                child: Text(_isDarkMode ? 'حالت روشن' : 'حالت تاریک'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
