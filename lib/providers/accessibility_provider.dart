import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccessibilityProvider extends ChangeNotifier {
  static const _chaveFonte = 'pref_font_scale';
  static const _chaveContraste = 'pref_alto_contraste';

  double _fontScale = 1.0;
  bool _altoContraste = false;

  double get fontScale => _fontScale;
  bool get altoContraste => _altoContraste;

  static const double _min = 0.8;
  static const double _max = 1.6;
  static const double _passo = 0.1;

  AccessibilityProvider() {
    _carregarPreferencias();
  }

  Future<void> _carregarPreferencias() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _fontScale = prefs.getDouble(_chaveFonte) ?? 1.0;
      _altoContraste = prefs.getBool(_chaveContraste) ?? false;
      notifyListeners();
    } catch (_) {
      // Se não for possível ler preferências (ex.: ambiente restrito),
      // mantém os valores padrão sem interromper o uso do app.
    }
  }

  Future<void> aumentarFonte() async {
    if (_fontScale < _max) {
      _fontScale = double.parse((_fontScale + _passo).toStringAsFixed(1));
      notifyListeners();
      await _salvarFonte();
    }
  }

  Future<void> diminuirFonte() async {
    if (_fontScale > _min) {
      _fontScale = double.parse((_fontScale - _passo).toStringAsFixed(1));
      notifyListeners();
      await _salvarFonte();
    }
  }

  Future<void> alternarContraste() async {
    _altoContraste = !_altoContraste;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_chaveContraste, _altoContraste);
    } catch (_) {}
  }

  Future<void> _salvarFonte() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(_chaveFonte, _fontScale);
    } catch (_) {}
  }
}
