import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'models/booking_model.dart';
import 'models/user_model.dart';

void main() {
  runApp(const HomeServiceApp());
}

class HomeServiceApp extends StatefulWidget {
  const HomeServiceApp({super.key});

  @override
  State<HomeServiceApp> createState() => _HomeServiceAppState();
}

class _HomeServiceAppState extends State<HomeServiceApp> {
  // Simple global state — no external package needed
  UserModel? currentUser;
  final List<BookingModel> bookings = [];

  void setUser(UserModel user) => setState(() => currentUser = user);
  void clearUser() => setState(() => currentUser = null);
  void addBooking(BookingModel b) => setState(() => bookings.add(b));

  @override
  Widget build(BuildContext context) {
    return AppState(
      currentUser: currentUser,
      bookings: bookings,
      setUser: setUser,
      clearUser: clearUser,
      addBooking: addBooking,
      child: MaterialApp(
        title: 'Home Service App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: const SplashScreen(),
      ),
    );
  }
}

// ---------- InheritedWidget for state ----------
class AppState extends InheritedWidget {
  final UserModel? currentUser;
  final List<BookingModel> bookings;
  final void Function(UserModel) setUser;
  final VoidCallback clearUser;
  final void Function(BookingModel) addBooking;

  const AppState({
    super.key,
    required this.currentUser,
    required this.bookings,
    required this.setUser,
    required this.clearUser,
    required this.addBooking,
    required super.child,
  });

  static AppState of(BuildContext context) {
    final state = context.dependOnInheritedWidgetOfExactType<AppState>();
    assert(state != null, 'AppState not found in context');
    return state!;
  }

  @override
  bool updateShouldNotify(AppState oldWidget) =>
      currentUser != oldWidget.currentUser ||
      bookings.length != oldWidget.bookings.length;
}

// ---------- App Theme ----------
class AppTheme {
  static const Color primary = Color(0xFF1A6FE0);
  static const Color primaryDark = Color(0xFF0D4FAA);
  static const Color accent = Color(0xFFFF6B35);
  static const Color background = Color(0xFFF5F7FA);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF1A1F36);
  static const Color textMedium = Color(0xFF6B7280);
  static const Color textLight = Color(0xFF9CA3AF);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);

  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: primary,
          primary: primary,
          secondary: accent,
        ),
        scaffoldBackgroundColor: background,
        appBarTheme: const AppBarTheme(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 0.3,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 15),
        ),
      );
}