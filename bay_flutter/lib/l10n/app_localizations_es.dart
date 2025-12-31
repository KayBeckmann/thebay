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

  @override
  String get transactions => 'Transacciones';

  @override
  String purchases(int count) {
    return 'Compras ($count)';
  }

  @override
  String sales(int count) {
    return 'Ventas ($count)';
  }

  @override
  String get refresh => 'Actualizar';

  @override
  String get noPurchasesYet => 'Aún no hay compras';

  @override
  String get noSalesYet => 'Aún no hay ventas';

  @override
  String get yourPurchasesWillAppearHere => 'Tus compras aparecerán aquí';

  @override
  String get yourSalesWillAppearHere => 'Tus ventas aparecerán aquí';

  @override
  String get statusOpen => 'Abierta';

  @override
  String get statusPaid => 'Pagada';

  @override
  String get statusShipped => 'Enviada';

  @override
  String get statusReceived => 'Recibida';

  @override
  String get statusCompleted => 'Completada';

  @override
  String get statusDisputed => 'En disputa';

  @override
  String get statusCancelled => 'Cancelada';

  @override
  String get autoCompletesToday => 'Se completa automáticamente hoy';

  @override
  String autoCompletesInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'días',
      one: 'día',
    );
    return 'Se completa automáticamente en $count $_temp0';
  }

  @override
  String get transaction => 'Transacción';

  @override
  String get rateThisTransaction => 'Califica esta transacción';

  @override
  String shareYourExperience(String username) {
    return 'Comparte tu experiencia con $username';
  }

  @override
  String get rateNow => 'Calificar ahora';

  @override
  String get alreadyRated => 'Ya has calificado esta transacción';

  @override
  String get statusOpenDesc => 'Esperando el pago del comprador';

  @override
  String get statusPaidDesc => 'Pago enviado, esperando que el vendedor envíe';

  @override
  String get statusShippedDesc =>
      'El artículo ha sido enviado, esperando la entrega';

  @override
  String get statusReceivedDesc => 'El comprador ha recibido el artículo';

  @override
  String get statusCompletedDesc => 'Transacción completada exitosamente';

  @override
  String get statusDisputedDesc => 'Se ha abierto una disputa';

  @override
  String get statusCancelledDesc => 'La transacción fue cancelada';

  @override
  String get timeline => 'Línea de tiempo';

  @override
  String get created => 'Creada';

  @override
  String get paid => 'Pagada';

  @override
  String get paymentSent => 'Pago enviado';

  @override
  String get waitingForBuyer => 'Esperando al comprador';

  @override
  String get shipped => 'Enviada';

  @override
  String get waitingForSeller => 'Esperando al vendedor';

  @override
  String get received => 'Recibida';

  @override
  String get completed => 'Completada';

  @override
  String get cancelled => 'Cancelada';

  @override
  String get pending => 'Pendiente';

  @override
  String get markAsShipped => 'Marcar como enviada';

  @override
  String get markAsPaid => 'Marcar como pagada';

  @override
  String get markAsReceived => 'Marcar como recibida';

  @override
  String get cancelTransaction => 'Cancelar transacción';

  @override
  String get openDispute => 'Abrir disputa';

  @override
  String get actions => 'Acciones';

  @override
  String get confirmShipment =>
      'Confirma que has enviado el artículo. El comprador tendrá 14 días para confirmar la recepción o abrir una disputa.';

  @override
  String get confirm => 'Confirmar';

  @override
  String get transactionMarkedAsShipped => 'Transacción marcada como enviada';

  @override
  String get confirmPayment => 'Confirma que has enviado el pago al vendedor.';

  @override
  String get paymentMarkedAsSent => 'Pago marcado como enviado';

  @override
  String get confirmReceipt =>
      'Confirma que has recibido el artículo. Esto completará la transacción.';

  @override
  String get transactionCompleted => 'Transacción completada';

  @override
  String get cancelTransactionConfirm =>
      '¿Realmente quieres cancelar esta transacción? Esta acción no se puede deshacer.';

  @override
  String get keep => 'Mantener';

  @override
  String get transactionCancelled => 'Transacción cancelada';

  @override
  String get describeIssue =>
      'Por favor describe el problema con esta transacción. Un moderador revisará tu disputa.';

  @override
  String get reason => 'Razón';

  @override
  String get describeProblem => 'Describe el problema...';

  @override
  String get pleaseEnterReason => 'Por favor ingresa una razón';

  @override
  String get disputeOpened => 'Disputa abierta';

  @override
  String get transactionNotFound => 'Transacción no encontrada';

  @override
  String get transactionId => 'ID de transacción';

  @override
  String get totalPrice => 'Precio total';

  @override
  String get parties => 'Partes';

  @override
  String get buyer => 'Comprador';

  @override
  String get seller => 'Vendedor';

  @override
  String get you => 'Tú';

  @override
  String get viewListingDetails => 'Ver detalles del anuncio';

  @override
  String get buyerNote => 'Nota del comprador';

  @override
  String get autoCompleteWarning => 'Advertencia de completado automático';

  @override
  String get autoCompleteToday =>
      'Esta transacción se completará automáticamente hoy si no se abre una disputa.';

  @override
  String autoCompleteInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'días',
      one: 'día',
    );
    return 'Esta transacción se completará automáticamente en $count $_temp0 si no se toma ninguna acción.';
  }

  @override
  String get disputeOpen => 'Disputa abierta';

  @override
  String disputeReason(String reason) {
    return 'Razón: $reason';
  }

  @override
  String disputeOpenedDate(String date) {
    return 'Abierta: $date';
  }

  @override
  String get moderatorReviewing => 'Un moderador está revisando esta disputa.';

  @override
  String get paymentInformation => 'Información de pago';

  @override
  String get sendPaymentTo =>
      'Por favor envía el pago al vendedor con los siguientes detalles:';

  @override
  String get includeTransactionId =>
      'El vendedor enviará el artículo una vez que se reciba el pago. Por favor incluye tu ID de transacción en la nota de pago.';

  @override
  String get messages => 'Mensajes';

  @override
  String get inbox => 'Bandeja de entrada';

  @override
  String get sent => 'Enviados';

  @override
  String get drafts => 'Borradores';

  @override
  String get newMessage => 'Nuevo mensaje';

  @override
  String get noMessages => 'No hay mensajes';

  @override
  String get inboxEmpty => 'Tu bandeja de entrada está vacía.';

  @override
  String get noSentMessages => 'No hay mensajes enviados';

  @override
  String get noSentMessagesYet => 'Aún no has enviado ningún mensaje.';

  @override
  String get noDrafts => 'No hay borradores';

  @override
  String get noSavedDrafts => 'No tienes borradores guardados.';

  @override
  String get errorLoading => 'Error al cargar';

  @override
  String from(String username) {
    return 'De: $username';
  }

  @override
  String to(String username) {
    return 'Para: $username';
  }

  @override
  String get yesterday => 'Ayer';

  @override
  String get monday => 'Lun';

  @override
  String get tuesday => 'Mar';

  @override
  String get wednesday => 'Mié';

  @override
  String get thursday => 'Jue';

  @override
  String get friday => 'Vie';

  @override
  String get saturday => 'Sáb';

  @override
  String get sunday => 'Dom';

  @override
  String userNumber(int id) {
    return 'Usuario #$id';
  }

  @override
  String get noRecipient => 'Sin destinatario';

  @override
  String lastEdited(String date) {
    return 'Última edición: $date';
  }

  @override
  String get deleteMessage => '¿Eliminar mensaje?';

  @override
  String get actionCannotBeUndone => 'Esta acción no se puede deshacer.';

  @override
  String get deleteDraft => '¿Eliminar borrador?';

  @override
  String get reply => 'Responder';

  @override
  String get decryptingMessage => 'Descifrando mensaje...';

  @override
  String get decryptionFailed => 'Fallo al descifrar';

  @override
  String get endToEndEncrypted => 'Cifrado de extremo a extremo';

  @override
  String fromUser(String username) {
    return 'De: $username';
  }

  @override
  String dateLabel(String date) {
    return 'Fecha: $date';
  }

  @override
  String get subject => 'Asunto';

  @override
  String get noSubject => '[Sin asunto]';

  @override
  String get message => 'Mensaje';

  @override
  String get noContent => '[Sin contenido]';

  @override
  String get editDraft => 'Editar borrador';

  @override
  String get draft => 'Borrador';

  @override
  String get send => 'Enviar';

  @override
  String get recipient => 'Destinatario';

  @override
  String get enterUsername => 'Ingresa el nombre de usuario';

  @override
  String get messageWillBeEncrypted => 'El mensaje será cifrado';

  @override
  String get clickToVerifyRecipient =>
      'Haz clic en el ícono de búsqueda para verificar el destinatario';

  @override
  String userNotFoundOrNoKey(String username) {
    return 'Usuario \"$username\" no encontrado o no tiene clave PGP';
  }

  @override
  String get pleaseSelectRecipient => 'Por favor selecciona un destinatario';

  @override
  String get recipientNotVerified =>
      'Destinatario no verificado o sin clave PGP disponible. Por favor verifica el destinatario.';

  @override
  String get pleaseEnterSubject => 'Por favor ingresa un asunto';

  @override
  String get pleaseEnterMessage => 'Por favor ingresa un mensaje';

  @override
  String errorSending(String error) {
    return 'Error al enviar: $error';
  }

  @override
  String get draftSaved => 'Borrador guardado';

  @override
  String errorSavingDraft(String error) {
    return 'Error al guardar: $error';
  }
}
