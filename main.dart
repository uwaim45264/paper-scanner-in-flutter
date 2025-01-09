import 'package:flutter/material.dart';
import 'package:flutter_document_scanner/flutter_document_scanner.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:animations/animations.dart';

void main() {
  runApp(DocumentScannerApp());
}

class DocumentScannerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      themeMode: ThemeMode.system,
      home: SplashScreen(),
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      fontFamily: 'Roboto',
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.indigo,
        brightness: Brightness.light,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87),
        displayMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black54),
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black87),
        bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
        bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          backgroundColor: Colors.indigo,
          textStyle: const TextStyle(fontSize: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
          shadowColor: Colors.indigoAccent,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        prefixIconColor: Colors.indigo,
        labelStyle: const TextStyle(fontSize: 16, color: Colors.black54),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadowColor: Colors.black26,
      ),
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.grey[100],
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      fontFamily: 'Roboto',
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.indigo,
        brightness: Brightness.dark,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white70),
        displayMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white60),
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white70),
        bodyLarge: TextStyle(fontSize: 16, color: Colors.white70),
        bodyMedium: TextStyle(fontSize: 14, color: Colors.white60),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          backgroundColor: Colors.indigo,
          textStyle: const TextStyle(fontSize: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
          shadowColor: Colors.indigoAccent,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        prefixIconColor: Colors.indigoAccent,
        labelStyle: const TextStyle(fontSize: 16, color: Colors.white60),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
      ),
      cardTheme: CardTheme(
        color: Colors.grey[850],
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadowColor: Colors.black45,
      ),
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.grey[900],
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<Color?> _backgroundColorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 2.0 * 3.14159).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _textFadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _backgroundColorAnimation = ColorTween(
      begin: Colors.pinkAccent[100],
      end: Colors.indigo[400],
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context, _createRoute());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.pinkAccent[100]!, Colors.indigo[400]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 1.0],
                  ),
                ),
                child: AnimatedBuilder(
                  animation: _backgroundColorAnimation,
                  builder: (context, child) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.pinkAccent[100]!, _backgroundColorAnimation.value!],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _controller.value * 2,
                      child: Opacity(
                        opacity: 1.0 - _controller.value,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.3),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform(
                      transform: Matrix4.identity()
                        ..rotateY(_controller.value * 3.14159 * 2)
                        ..rotateX(_controller.value * 3.14159 / 2),
                      alignment: Alignment.center,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Icon(
                            Icons.camera_alt,
                            size: 100,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                for (int i = 0; i < 8; i++)
                  Positioned.fill(
                    child: Transform.rotate(
                      angle: i * 3.14159 / 4,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Particle(explosion: _controller.value == 1.0),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _textFadeAnimation,
              child: SlideTransition(
                position: Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))
                    .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut)),
                child: ScaleTransition(
                  scale: CurvedAnimation(
                    parent: _controller,
                    curve: Interval(0.0, 0.5, curve: Curves.easeOut),
                  ),
                  child: Text(
                    "Welcome to Paper Scanner",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _textFadeAnimation,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => MainScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}

class Particle extends StatefulWidget {
  final bool explosion;
  Particle({required this.explosion});

  @override
  _ParticleState createState() => _ParticleState();
}

class _ParticleState extends State<Particle> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0, end: 200).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.repeat(reverse: !widget.explosion);
  }

  @override
  void didUpdateWidget(covariant Particle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.explosion) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, widget.explosion ? _animation.value * 2 : _animation.value),
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        );
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  void _showAppInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('App Information'),
          content: const Text('This is a document scanner app that helps you scan and save documents.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Document Scanner',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo[300]!, Colors.indigo[600]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 4.0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Subtle animation applied to the image
              AnimatedScale(
                scale: 1.0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                child: Image.asset(
                  'assets/images/ETEA-new.png',
                  height: 300,
                ),
              ),
              const SizedBox(height: 50),
              OpenContainer(
                closedElevation: 8.0,
                transitionType: ContainerTransitionType.fadeThrough,
                closedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                closedColor: Colors.indigo,
                openColor: Colors.white,
                transitionDuration: const Duration(milliseconds: 1100),
                closedBuilder: (context, action) {
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    leading: const Icon(Icons.format_list_numbered, color: Colors.white, size: 28),
                    title: const Text(
                      'Set Roll No Sequence',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    onTap: action,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    tileColor: Colors.indigo,
                    hoverColor: Colors.indigoAccent.withOpacity(0.1),
                    splashColor: Colors.indigoAccent.withOpacity(0.2),
                  );
                },
                openBuilder: (context, action) {
                  return RollNoSequenceScreen();
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAppInfo(context),
        tooltip: 'App Information',
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.info_outline, size: 28),
        elevation: 6.0,
      ),
    );
  }
}

class RollNoSequenceScreen extends StatefulWidget {
  @override
  _RollNoSequenceScreenState createState() => _RollNoSequenceScreenState();
}

class _RollNoSequenceScreenState extends State<RollNoSequenceScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _startRollNoController = TextEditingController();
  final TextEditingController _endRollNoController = TextEditingController();
  AnimationController? _buttonController;

  @override
  void initState() {
    super.initState();
    _buttonController = AnimationController(
      duration: Duration(milliseconds: 100),
      vsync: this,
      lowerBound: 0.95,
      upperBound: 1.0,
    );
  }

  @override
  void dispose() {
    _startRollNoController.dispose();
    _endRollNoController.dispose();
    _buttonController?.dispose();
    super.dispose();
  }

  void _saveRollNoSequence() {
    String startRollNo = _startRollNoController.text;
    String endRollNo = _endRollNoController.text;

    if (startRollNo.isNotEmpty && endRollNo.isNotEmpty) {
      int start = int.parse(startRollNo);
      int end = int.parse(endRollNo);
      if (end >= start) {
        Navigator.pushReplacement(context, _createRoute(start, end));
      } else {
        _showSnackBar('End Roll No must be greater than Start Roll No');
      }
    } else {
      _showSnackBar('Please fill both fields');
    }
  }

  Route _createRoute(int start, int end) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ScanPapersScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var fadeTransition = FadeTransition(
          opacity: animation,
          child: child,
        );
        return fadeTransition;
      },
      settings: RouteSettings(arguments: [start, end]),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.deepPurpleAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Set Roll No Sequence',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.blueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey[200]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Enter the Roll Numbers to Set the Sequence',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  letterSpacing: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                shadowColor: Colors.black45,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _startRollNoController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Start Roll No',
                          labelStyle: TextStyle(
                            color: Colors.deepPurpleAccent,
                            fontWeight: FontWeight.w600,
                          ),
                          prefixIcon: Icon(Icons.format_list_numbered, color: Colors.deepPurpleAccent),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(color: Colors.deepPurpleAccent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2),
                          ),
                        ),
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _endRollNoController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'End Roll No',
                          labelStyle: TextStyle(
                            color: Colors.deepPurpleAccent,
                            fontWeight: FontWeight.w600,
                          ),
                          prefixIcon: Icon(Icons.format_list_numbered, color: Colors.deepPurpleAccent),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(color: Colors.deepPurpleAccent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2),
                          ),
                        ),
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Divider(color: Colors.grey[400], thickness: 1.0),
              const SizedBox(height: 24),
              ScaleTransition(
                scale: _buttonController!,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.save, color: Colors.white),
                  label: Text('Save Sequence', style: TextStyle(fontSize: 16)),
                  onPressed: () async {
                    await _buttonController?.forward();
                    _saveRollNoSequence();
                    _buttonController?.reverse();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepPurpleAccent,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    shadowColor: Colors.deepPurple,
                    elevation: 8.0,
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

class ScanPapersScreen extends StatefulWidget {
  @override
  _ScanPapersScreenState createState() => _ScanPapersScreenState();
}

class _ScanPapersScreenState extends State<ScanPapersScreen> {
  int? startRollNo;
  int? endRollNo;
  int scannedCount = 0;
  List<String> scannedImages = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments as List<int>?;
      if (args != null && args.length == 2) {
        setState(() {
          startRollNo = args[0];
          endRollNo = args[1];
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Roll number sequence is not set')),
        );
      }
    });
  }

  void _startScanning(int rollNo) async {
    int totalScansAllowed = (endRollNo ?? 0) - (startRollNo ?? 0) + 1;

    if (scannedCount >= totalScansAllowed) {
      _showCompletionDialog();
      return;
    }

    final Uint8List? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DocumentScanner(
          onSave: (Uint8List scannedData) async {
            try {
              final String filePath = await _saveScannedImage(scannedData, rollNo);
              setState(() {
                scannedImages.add(filePath);
                scannedCount++;
              });

              // Show ImagePreviewScreen after scanning
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImagePreviewScreen(
                    imagePath: filePath,
                    onOkPressed: () {
                      Navigator.pop(context); // Close ImagePreviewScreen
                      if (scannedCount < totalScansAllowed) {
                        // Return to ScanPapersScreen to start next scan
                        Navigator.pop(context);
                      } else {
                        _showCompletionDialog();
                      }
                    },
                  ),
                ),
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error saving scanned image: $e')),
              );
            }
          },
        ),
      ),
    );

    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Scanning canceled or failed')),
      );
    }
  }

  Future<String> _saveScannedImage(Uint8List scannedData, int rollNo) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/scanned_image_$rollNo.png';
    final file = File(filePath);
    await file.writeAsBytes(scannedData);
    return file.path;
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Scanning Completed'),
          content: const Text('All scans are complete.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _shareImages() {
    if (scannedImages.isNotEmpty) {
      Share.shareFiles(scannedImages, text: 'Scanned Documents');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No images to share')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Papers', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurpleAccent, Colors.indigo],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total No Of Scans: ${(endRollNo ?? 0) - (startRollNo ?? 0) + 1}',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Text(
              'Scanned: $scannedCount',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Text(
              'Remaining: ${(endRollNo ?? 0) - (startRollNo ?? 0) + 1 - scannedCount}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: scannedImages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => ImagePreviewScreen(
                            imagePath: scannedImages[index],
                            onOkPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ));
                      },
                      child: Card(
                        elevation: 8,
                        shadowColor: Colors.grey.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.file(File(scannedImages[index]), width: 60, height: 60, fit: BoxFit.cover),
                          ),
                          title: Text('Scanned Image ${index + 1}', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500)),
                          trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.deepPurple),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.scanner),
                    label: const Text('Start Scanning'),
                    onPressed: startRollNo != null ? () => _startScanning(startRollNo!) : null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.deepPurple, // Text color
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 6,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.share),
                    label: const Text('Share Images'),
                    onPressed: _shareImages,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.deepPurple, // Text color
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 6,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ImagePreviewScreen extends StatelessWidget {
  final String imagePath;
  final VoidCallback onOkPressed;
  final VoidCallback? onClosePressed;

  ImagePreviewScreen({
    required this.imagePath,
    required this.onOkPressed,
    this.onClosePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Preview', style: Theme.of(context).textTheme.displayMedium),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo[300]!, Colors.indigo[600]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: onClosePressed ?? () => Navigator.pop(context),
            tooltip: 'Close',
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: InteractiveViewer(
              child: Image.file(File(imagePath)),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.check),
                label: const Text('OK'),
                onPressed: onOkPressed,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(150, 50),
                ),
              ),
              const SizedBox(width: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.close),
                label: const Text('Close'),
                onPressed: onClosePressed ?? () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(150, 50),
                  backgroundColor: Colors.redAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
