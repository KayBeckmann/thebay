// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Bay';

  @override
  String get loginTitle => 'Bienvenido de nuevo';

  @override
  String get loginSubtitle => 'Inicia sesión para continuar';

  @override
  String get username => 'Nombre de usuario';

  @override
  String get usernameRequired => 'Por favor ingresa tu nombre de usuario';

  @override
  String get password => 'Contraseña';

  @override
  String get passwordRequired => 'Por favor ingresa tu contraseña';

  @override
  String get stayLoggedIn => 'Mantener sesión iniciada';

  @override
  String get signIn => 'Iniciar sesión';

  @override
  String get dontHaveAccount => '¿No tienes una cuenta? ';

  @override
  String get signUp => 'Registrarse';

  @override
  String get loginFailed => 'Inicio de sesión fallido';

  @override
  String get connectionError =>
      'Error de conexión. Por favor intenta de nuevo.';

  @override
  String tryAgainInSeconds(int seconds) {
    return 'Intenta de nuevo en $seconds segundos';
  }

  @override
  String get registerTitle => 'Crear cuenta';

  @override
  String get registerSubtitle => 'Regístrate para comenzar';

  @override
  String get usernameHelper =>
      '3-20 caracteres, letras, números, guiones bajos';

  @override
  String get usernameMinLength =>
      'El nombre de usuario debe tener al menos 3 caracteres';

  @override
  String get usernameMaxLength =>
      'El nombre de usuario no puede tener más de 20 caracteres';

  @override
  String get usernameInvalidChars =>
      'Solo se permiten letras, números y guiones bajos';

  @override
  String get passwordHelper => 'Mín 8 car., mayúscula, minúscula, dígito';

  @override
  String get passwordMinLength =>
      'La contraseña debe tener al menos 8 caracteres';

  @override
  String get passwordNeedsUppercase =>
      'La contraseña debe contener una letra mayúscula';

  @override
  String get passwordNeedsLowercase =>
      'La contraseña debe contener una letra minúscula';

  @override
  String get passwordNeedsDigit => 'La contraseña debe contener un dígito';

  @override
  String get confirmPassword => 'Confirmar contraseña';

  @override
  String get passwordsDoNotMatch => 'Las contraseñas no coinciden';

  @override
  String get agreeToTerms => 'Acepto los ';

  @override
  String get termsOfService => 'Términos de servicio';

  @override
  String get close => 'Cerrar';

  @override
  String get createAccount => 'Crear cuenta';

  @override
  String get alreadyHaveAccount => '¿Ya tienes una cuenta? ';

  @override
  String get mustAcceptTerms => 'Debes aceptar los términos de servicio';

  @override
  String get registrationFailed => 'Registro fallido';

  @override
  String get generatingKey => 'Generando clave de seguridad...';

  @override
  String get generatingKeyMessage =>
      'Tu clave de cifrado personal está siendo generada.\nEsto solo tomará unos segundos.';

  @override
  String keyGenerationFailed(String error) {
    return 'No se pudo generar la clave: $error\nPuedes crearla más tarde en la configuración.';
  }

  @override
  String elapsedTime(String time) {
    return 'Tiempo transcurrido: $time';
  }

  @override
  String get navDashboard => 'Panel';

  @override
  String get navMessages => 'Mensajes';

  @override
  String get navSearch => 'Buscar';

  @override
  String get navSell => 'Vender';

  @override
  String get navTransactions => 'Transacciones';

  @override
  String get navSettings => 'Configuración';

  @override
  String get navModeration => 'Moderación';

  @override
  String get navNews => 'Noticias';

  @override
  String get navAdmin => 'Administración';

  @override
  String get drawerUserFallback => 'Usuario';

  @override
  String get drawerModerationSection => 'Moderación';

  @override
  String get drawerAdminSection => 'Administración';

  @override
  String get roleAdmin => 'Administrador';

  @override
  String get roleModerator => 'Moderador';

  @override
  String get roleUser => 'Usuario';

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get sectionPaymentInfo => 'Información de pago';

  @override
  String get sectionDisplay => 'Visualización';

  @override
  String get sectionSecurity => 'Seguridad';

  @override
  String get sectionAccount => 'Cuenta';

  @override
  String get paypalAddress => 'Dirección PayPal';

  @override
  String get bitcoinWallet => 'Billetera Bitcoin';

  @override
  String get notSpecified => 'No especificado';

  @override
  String get emailAddress => 'Dirección de correo electrónico';

  @override
  String get emailHint => 'tu@email.com';

  @override
  String get walletAddress => 'Dirección de billetera';

  @override
  String get walletHint => 'bc1q...';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Guardar';

  @override
  String get paypalAddressSaved => 'Dirección PayPal guardada';

  @override
  String get bitcoinWalletSaved => 'Billetera Bitcoin guardada';

  @override
  String errorSaving(String error) {
    return 'Error al guardar: $error';
  }

  @override
  String get itemsPerPage => 'Elementos por página';

  @override
  String itemsCount(int count) {
    return '$count elementos';
  }

  @override
  String get displayCurrency => 'Moneda de visualización';

  @override
  String get language => 'Idioma';

  @override
  String get languageChanged =>
      'Idioma cambiado. Por favor reinicia la aplicación para aplicar el cambio.';

  @override
  String get langEnglish => 'English';

  @override
  String get langGerman => 'Deutsch';

  @override
  String get langFrench => 'Français';

  @override
  String get langSpanish => 'Español';

  @override
  String get pgpKey => 'Clave PGP';

  @override
  String get configured => 'Configurado';

  @override
  String get notConfigured => 'Aún no configurado';

  @override
  String get changePassword => 'Cambiar contraseña';

  @override
  String get currentPassword => 'Contraseña actual';

  @override
  String get newPassword => 'Nueva contraseña';

  @override
  String get passwordsMismatch => 'Las contraseñas no coinciden';

  @override
  String get passwordChangeSuccess => 'Contraseña cambiada exitosamente';

  @override
  String get passwordChangeError => 'Error al cambiar la contraseña';

  @override
  String get changeButton => 'Cambiar';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get logoutConfirm => '¿Realmente quieres cerrar sesión?';

  @override
  String get deleteAccount => 'Eliminar cuenta';

  @override
  String get deleteAccountWarning =>
      'Esta acción no se puede deshacer. Todos tus datos serán eliminados permanentemente.';

  @override
  String get passwordConfirmation => 'Contraseña para confirmación';

  @override
  String get pleaseEnterPassword => 'Por favor ingresa tu contraseña';

  @override
  String get deleteAccountError => 'Error al eliminar la cuenta';

  @override
  String genericError(String error) {
    return 'Error: $error';
  }

  @override
  String get dashboardTitle => 'Panel de control';

  @override
  String welcomeUser(String username) {
    return '¡Bienvenido, $username!';
  }

  @override
  String get userFallback => 'Usuario';

  @override
  String get whatTodayQuestion => '¿Qué te gustaría hacer hoy?';

  @override
  String get sectionPendingRatings => 'Calificaciones pendientes';

  @override
  String get sectionNews => 'Noticias';

  @override
  String get sectionSlotWarnings => 'Alertas de slots';

  @override
  String get sectionRecentListings => 'Anuncios recientes';

  @override
  String get noNews => 'No hay noticias';

  @override
  String get noNewsMessage => 'Actualmente no hay noticias. ¡Vuelve más tarde!';

  @override
  String pendingRatingsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tienes $count calificaciones pendientes',
      one: 'Tienes 1 calificación pendiente',
    );
    return '$_temp0';
  }

  @override
  String transactionNumber(int id) {
    return 'Transacción #$id';
  }

  @override
  String viewAllPendingRatings(int count) {
    return 'Ver todas las $count calificaciones pendientes';
  }

  @override
  String get noSlotsExpiring => 'Ningún slot expira en los próximos 3 días.';

  @override
  String slotsExpiringSoon(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count slots expiran pronto',
      one: '1 slot expira pronto',
    );
    return '$_temp0';
  }

  @override
  String slotNumber(int id) {
    return 'Slot #$id';
  }

  @override
  String listingNumber(int id) {
    return 'Anuncio #$id';
  }

  @override
  String get noListingLinked => 'Ningún anuncio vinculado';

  @override
  String moreCount(int count) {
    return '+$count más';
  }

  @override
  String get noListingsYet => 'Aún no hay anuncios';

  @override
  String get noListingsMessage => 'Los anuncios recientes se mostrarán aquí.';

  @override
  String get unitPiece => 'pieza';

  @override
  String get unitKg => 'kg';

  @override
  String get unitGram => 'g';

  @override
  String get unitMeter => 'm';

  @override
  String get unitLiter => 'L';

  @override
  String get edit => 'Editar';

  @override
  String get delete => 'Eliminar';

  @override
  String get create => 'Crear';

  @override
  String get active => 'Activo';

  @override
  String get inactive => 'Inactivo';

  @override
  String get required => 'Requerido';

  @override
  String get invalidInput => 'Entrada inválida';

  @override
  String get shipping => 'Envío';

  @override
  String get shippingMethod => 'Método de envío';

  @override
  String get shippingCost => 'Costo de envío';

  @override
  String get searchTitle => 'Buscar';

  @override
  String get favorites => 'Favoritos';

  @override
  String get searchListingsHint => 'Buscar anuncios...';

  @override
  String get category => 'Categoría';

  @override
  String get subcategory => 'Subcategoría';

  @override
  String get paymentMethod => 'Método de pago';

  @override
  String get clearFilters => 'Borrar filtros';

  @override
  String get noResults => 'Sin resultados';

  @override
  String get browseListings => 'Explorar anuncios';

  @override
  String get paypal => 'PayPal';

  @override
  String get bitcoin => 'Bitcoin';

  @override
  String get listingDetailTitle => 'Detalles del anuncio';

  @override
  String get description => 'Descripción';

  @override
  String get details => 'Detalles';

  @override
  String get acceptedPaymentMethods => 'Métodos de pago aceptados';

  @override
  String get quantity => 'Cantidad';

  @override
  String get pricePerUnit => 'Precio por unidad';

  @override
  String get createdAt => 'Creado el';

  @override
  String get expiresAt => 'Expira el';

  @override
  String get listingNotFound => 'Anuncio no encontrado';

  @override
  String get tryAgain => 'Intentar de nuevo';

  @override
  String get buyNow => 'Comprar ahora';

  @override
  String get contactSeller => 'Contactar vendedor';

  @override
  String get createListingTitle => 'Nuevo anuncio';

  @override
  String get editListingTitle => 'Editar anuncio';

  @override
  String get title => 'Título';

  @override
  String get titleHint => 'Ingresa un título';

  @override
  String get titleRequired => 'El título es requerido';

  @override
  String get descriptionHint => 'Describe tu anuncio...';

  @override
  String get descriptionRequired => 'La descripción es requerida';

  @override
  String get price => 'Precio';

  @override
  String get priceHint => '0.00';

  @override
  String get priceRequired => 'El precio es requerido';

  @override
  String get priceInvalid => 'El precio debe ser mayor que 0';

  @override
  String get quantityHint => '1';

  @override
  String get quantityRequired => 'La cantidad es requerida';

  @override
  String get quantityInvalid => 'La cantidad debe ser mayor que 0';

  @override
  String get unit => 'Unidad';

  @override
  String get selectCategory => 'Seleccionar categoría';

  @override
  String get selectSubcategory => 'Seleccionar subcategoría';

  @override
  String get categoryRequired => 'La categoría es requerida';

  @override
  String get images => 'Imágenes';

  @override
  String get addImages => 'Agregar imágenes';

  @override
  String get selectPaymentMethods => 'Seleccionar métodos de pago';

  @override
  String get atLeastOnePaymentMethod =>
      'Se requiere al menos un método de pago';

  @override
  String get shippingOptions => 'Opciones de envío';

  @override
  String get shippingAvailable => 'Envío disponible';

  @override
  String get shippingCostHint => '5.00';

  @override
  String get listingCreated => 'Anuncio creado';

  @override
  String get listingUpdated => 'Anuncio actualizado';

  @override
  String get errorCreatingListing => 'Error al crear el anuncio';

  @override
  String get errorUpdatingListing => 'Error al actualizar el anuncio';

  @override
  String get deleteListing => 'Eliminar anuncio';

  @override
  String get deleteListingConfirm =>
      '¿Realmente quieres eliminar este anuncio?';

  @override
  String get listingDeleted => 'Anuncio eliminado';

  @override
  String get errorDeletingListing => 'Error al eliminar el anuncio';

  @override
  String get slot => 'Slot';

  @override
  String get selectSlot => 'Seleccionar slot';

  @override
  String get slotRequired => 'El slot es requerido';

  @override
  String get noSlotsAvailable => 'No hay slots disponibles';

  @override
  String get loading => 'Cargando...';

  @override
  String get retry => 'Reintentar';

  @override
  String get searchEmptyStateMessage =>
      'Ingresa un término de búsqueda o selecciona filtros para encontrar anuncios.';

  @override
  String get noResultsMessage =>
      'Prueba con diferentes términos de búsqueda o ajusta los filtros.';

  @override
  String get resetFilters => 'Restablecer filtros';

  @override
  String get noCategory => 'Sin categoría';

  @override
  String get allSubcategories => 'Todas las subcategorías';

  @override
  String get allPaymentMethods => 'Todos los métodos de pago';

  @override
  String searchError(String error) {
    return 'Error de búsqueda: $error';
  }

  @override
  String resultsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count resultados',
      one: '1 resultado',
    );
    return '$_temp0';
  }
}
