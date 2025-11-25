// lib/model/etiquetas_esp.dart

import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';

// Esta clase sirve para traducir los textos de ingles a español
class EtiquetasEsp extends DefaultLocalizations {
  const EtiquetasEsp();

  @override
  String get signInText => "Inicio de sesión"; 
  
  @override
  String get registerText => "Registrar";
  
  @override
  String get registerHintText => "¿No tienes cuenta?";
  
  @override
  String get signInHintText => '¿Ya tienes cuenta?';
  
  @override
  String get emailInputLabel => 'Correo electrónico';
  
  @override
  String get passwordInputLabel => 'Contraseña';
  
  @override
  String get confirmPasswordInputLabel => 'Confirmar contraseña';
  
  @override
  String get forgotPasswordButtonLabel => '¿Olvidaste tu contraseña?';
  
  @override
  String get signInActionText => 'Entrar';
  
  @override
  String get registerActionText => "Crear cuenta";
  
  @override
  String get signInWithGoogleButtonText => "Entrar con Google";
  
  @override
  String get errorPopupMenuLabel => 'Error';
  
  @override
  String get goBackButtonLabel => 'Regresar';
}