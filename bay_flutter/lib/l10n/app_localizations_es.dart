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
  String get details => 'Detalles:';

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
  String get reason => 'Motivo';

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
  String get errorLoadingTitle => 'Error al cargar';

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

  @override
  String get pgpKeys => 'Claves PGP';

  @override
  String get keyInformation => 'Información de la clave';

  @override
  String get generateNewKey => 'Generar nueva clave';

  @override
  String get exportKey => 'Exportar clave';

  @override
  String get importKey => 'Importar clave';

  @override
  String get serverBackup => 'Backup del servidor';

  @override
  String get securityNotices => 'Avisos de seguridad';

  @override
  String get setBackupPassword => 'Establecer contraseña de backup';

  @override
  String get generateKey => 'Generar clave';

  @override
  String get privateKeyExport => 'Exportar Private Key';

  @override
  String get importPrivateKey => 'Importar Private Key';

  @override
  String get keyConfigured => 'Clave configurada';

  @override
  String get keyIncomplete => 'Clave incompleta';

  @override
  String get canSendEncryptedMessages =>
      'Puedes enviar y recibir mensajes cifrados.';

  @override
  String get generateOrImportKey =>
      'Genera una nueva clave o importa una existente.';

  @override
  String get privateKeyLocalPublicKeyMissing =>
      'Private Key presente localmente, pero Public Key no está en el servidor.';

  @override
  String get publicKeyOnServerPrivateKeyMissing =>
      'Public Key en el servidor, pero Private Key falta localmente.';

  @override
  String get keysMismatch => 'Las claves no coinciden.';

  @override
  String get exportPrivateKeyForBackup =>
      'Exporta tu Private Key para hacer backup. ¡Guárdala de forma segura!';

  @override
  String get importExistingPrivateKey =>
      'Importa una Private Key existente (por ejemplo, desde un backup u otro dispositivo).';

  @override
  String get storePrivateKeyEncryptedOnServer =>
      'Almacena tu Private Key cifrada en el servidor. Esto te permite restaurarla en otro dispositivo.';

  @override
  String get securityWarning => 'Advertencia de seguridad';

  @override
  String get aboutToStorePrivateKeyOnServer =>
      'Estás a punto de almacenar tu Private Key en el servidor.';

  @override
  String get keyWillBeEncryptedBeforeUpload =>
      'La clave se cifrará con una contraseña antes de subirla. Sin embargo, debes tener en cuenta lo siguiente:';

  @override
  String get chooseStrongUniquePassword =>
      'Elige una contraseña fuerte y única';

  @override
  String get passwordCannotBeReset =>
      'Esta contraseña NO puede ser restablecida';

  @override
  String get backupWorthlessWithoutPassword =>
      'Sin la contraseña, el backup no sirve';

  @override
  String get serverOperatorMightGuessPassword =>
      'El operador del servidor podría intentar adivinar la contraseña';

  @override
  String get chooseStrongPasswordForBackup =>
      'Elige una contraseña fuerte para tu backup. La necesitarás para restaurar la clave.';

  @override
  String get passwordsDontMatch => 'Las contraseñas no coinciden';

  @override
  String get pleaseEnterName => 'Por favor ingresa un nombre';

  @override
  String get enterPasswordForBackup =>
      'Ingresa la contraseña que usaste para cifrar el backup:';

  @override
  String get decryptingAndImporting => 'Descifrando e importando...';

  @override
  String get decryptionFailedWrongPassword =>
      'Descifrado fallido. ¿Contraseña incorrecta?';

  @override
  String get understandProceed => 'Entiendo, proceder';

  @override
  String get uploadPublicKey => 'Subir Public Key';

  @override
  String get generating => 'Generando...';

  @override
  String get exportPrivateKey => 'Exportar Private Key';

  @override
  String get pastePrivateKey => 'Pegar Private Key';

  @override
  String get loadFromServerBackup => 'Cargar desde backup del servidor';

  @override
  String get createEncryptedBackup => 'Crear backup cifrado';

  @override
  String get copyFingerprint => 'Copiar Fingerprint';

  @override
  String get createBackup => 'Crear backup';

  @override
  String get restore => 'Restaurar';

  @override
  String errorLoading(String error) {
    return 'Error al cargar';
  }

  @override
  String get existingKeyWillBeReplaced =>
      '¡La clave existente será reemplazada!';

  @override
  String get invalidKeyAfterDecryption =>
      'Clave inválida después del descifrado';

  @override
  String get noPrivateKey => 'No hay Private Key disponible';

  @override
  String get noFingerprint => 'No hay fingerprint disponible';

  @override
  String get backupSuccessfullySaved =>
      '¡Backup guardado exitosamente en el servidor!';

  @override
  String errorBackup(String error) {
    return 'Error durante el backup: $error';
  }

  @override
  String get noBackupOnServer => 'No se encontró backup en el servidor.';

  @override
  String errorGeneration(String error) {
    return 'Error durante la generación: $error';
  }

  @override
  String get keySuccessfullyGenerated =>
      '¡Clave generada y subida exitosamente!';

  @override
  String errorUploading(String error) {
    return 'Error al subir: $error';
  }

  @override
  String get privateKeyNeverLeavesDevice =>
      'Tu Private Key nunca sale de este dispositivo';

  @override
  String get onlyPublicKeyStoredOnServer =>
      'Solo la Public Key se almacena en el servidor';

  @override
  String get regularBackupsRecommended =>
      'Crea backups regulares de tu Private Key';

  @override
  String get lostKeyCannotDecryptOldMessages =>
      'Si pierdes tu clave, los mensajes antiguos no podrán ser descifrados';

  @override
  String get createsNewEd25519Key =>
      'Crea una nueva clave Ed25519/Curve25519. Esto solo toma unos segundos.';

  @override
  String get generatingEd25519Key =>
      'Creando clave Ed25519/Curve25519. Esto solo toma unos segundos.';

  @override
  String get keySuccessfullyRestored => '¡Clave restaurada exitosamente!';

  @override
  String get protectWithPassphrase => 'Proteger con passphrase';

  @override
  String get recommendedForSecurity => 'Recomendado para seguridad adicional';

  @override
  String get passphrase => 'Passphrase';

  @override
  String get enterSecurePassphrase => 'Ingresa una passphrase segura';

  @override
  String get name => 'Nombre';

  @override
  String get yourName => 'Tu nombre';

  @override
  String get emailOptional => 'Email (opcional)';

  @override
  String get yourEmailCom => 'tu@email.com';

  @override
  String get fingerprint => 'Fingerprint';

  @override
  String get algorithm => 'Algoritmo';

  @override
  String get keySize => 'Tamaño de clave';

  @override
  String get identity => 'Identidad';

  @override
  String get keepKeySafe =>
      '¡Guarda esta clave de forma segura! Nunca la compartas con otros.';

  @override
  String get pastePrivateKeyInPgpFormat =>
      'Pega tu Private Key en formato PGP armor:';

  @override
  String get beginPgpPrivateKeyBlock => '-----BEGIN PGP PRIVATE KEY BLOCK-----';

  @override
  String get pleasePasteKey => 'Por favor pega una clave';

  @override
  String get invalidKeyFormat => 'Formato de clave inválido';

  @override
  String get privateKeySuccessfullyImported =>
      '¡Private Key importada exitosamente!';

  @override
  String get selectBackupToRestore =>
      'Selecciona el backup que deseas restaurar:';

  @override
  String get selectBackup => 'Seleccionar backup';

  @override
  String get decryptBackup => 'Descifrar backup';

  @override
  String copiedToClipboard(String label) {
    return '$label copiado al portapapeles';
  }

  @override
  String get publicKeySuccessfullyUploaded =>
      '¡Public Key subida exitosamente!';

  @override
  String get backupPassword => 'Contraseña de backup';

  @override
  String get keyGenerationTooLong =>
      'La generación de la clave está tardando demasiado. Por favor intenta de nuevo o reinicia la aplicación.';

  @override
  String get noOwnPgpKey =>
      'No hay clave PGP propia disponible. Por favor sube tu Public Key.';

  @override
  String get recipientHasNoPgpKey => 'El destinatario no tiene clave PGP';

  @override
  String get adminPanel => 'Panel de Administración';

  @override
  String get adminPanelWelcome => 'Bienvenido al Área de Administración';

  @override
  String get userManagement => 'Gestión de Usuarios';

  @override
  String get categoryManagement => 'Gestión de Categorías';

  @override
  String get newsManagement => 'Gestión de Noticias';

  @override
  String get paymentSettings => 'Configuración de Pagos';

  @override
  String get pendingPayments => 'Pagos Pendientes';

  @override
  String get slotVariants => 'Variantes de Slot';

  @override
  String get moderatorPanel => 'Panel de Moderación';

  @override
  String get moderatorPanelWelcome => 'Bienvenido al Área de Moderación';

  @override
  String get reports => 'Reportes';

  @override
  String get disputes => 'Disputas';

  @override
  String get allReports => 'Todos';

  @override
  String get openReports => 'Abiertos';

  @override
  String get inReviewReports => 'En Revisión';

  @override
  String get resolvedReports => 'Resueltos';

  @override
  String get dismissedReports => 'Rechazados';

  @override
  String get statusReportOpen => 'ABIERTO';

  @override
  String get statusReportInReview => 'EN REVISIÓN';

  @override
  String get statusReportResolved => 'RESUELTO';

  @override
  String get statusReportDismissed => 'RECHAZADO';

  @override
  String get reportedBy => 'Reportado por';

  @override
  String get reportedUser => 'Usuario Reportado';

  @override
  String get reportedListing => 'Oferta Reportada';

  @override
  String get reportReason => 'Razón';

  @override
  String get reportReasonSpam => 'Spam';

  @override
  String get reportReasonInappropriate => 'Contenido Inapropiado';

  @override
  String get reportReasonScam => 'Estafa';

  @override
  String get reportReasonHarassment => 'Acoso';

  @override
  String get reportReasonFakeInfo => 'Información Falsa';

  @override
  String get reportReasonOther => 'Otro';

  @override
  String get noReports => 'Sin Reportes';

  @override
  String get noReportsMessage => 'Actualmente no hay reportes para revisar.';

  @override
  String get viewReport => 'Ver Reporte';

  @override
  String get reportDetail => 'Detalles del Reporte';

  @override
  String reportId(int id) {
    return 'Reporte #$id';
  }

  @override
  String get reportType => 'Tipo';

  @override
  String get reportTypeUser => 'Usuario';

  @override
  String get reportTypeListing => 'Anuncio';

  @override
  String get reportedAt => 'Reportado el';

  @override
  String get reportDescription => 'Descripción';

  @override
  String get moderatorNotes => 'Notas del Moderador';

  @override
  String get addNote => 'Agregar Nota';

  @override
  String get internalNotesOnly => 'Visible solo para moderadores';

  @override
  String get enterNote => 'Ingresar nota...';

  @override
  String get noteSaved => 'La nota ha sido guardada';

  @override
  String get takeAction => 'Tomar Acción';

  @override
  String get markAsInReview => 'Marcar como En Revisión';

  @override
  String get resolveReport => 'Resolver Reporte';

  @override
  String get dismissReport => 'Rechazar Reporte';

  @override
  String get viewReportedUser => 'Ver Usuario Reportado';

  @override
  String get viewReportedListing => 'Ver Anuncio Reportado';

  @override
  String get warnUser => 'Advertir Usuario';

  @override
  String get banUser => 'Bloquear Usuario';

  @override
  String get reportMarkedInReview => 'Reporte marcado como en revisión';

  @override
  String get reportResolved => 'Reporte resuelto';

  @override
  String get reportDismissed => 'Reporte rechazado';

  @override
  String get confirmResolveReport =>
      '¿Quieres marcar este reporte como resuelto?';

  @override
  String get confirmDismissReport => '¿Quieres rechazar este reporte?';

  @override
  String get resolve => 'Resolver';

  @override
  String get dismiss => 'Desestimar';

  @override
  String get userDetail => 'Detalles del Usuario';

  @override
  String userId(int id) {
    return 'ID: $id';
  }

  @override
  String get registeredAt => 'Registrado el';

  @override
  String get lastActive => 'Última actividad';

  @override
  String get totalListings => 'Anuncios totales';

  @override
  String get totalTransactions => 'Transacciones totales';

  @override
  String get userRating => 'Calificación';

  @override
  String get userStatus => 'Estado';

  @override
  String get userStatusActive => 'Activo';

  @override
  String get userStatusBanned => 'Baneado';

  @override
  String get userStatusWarned => 'Advertido';

  @override
  String get banUserDialog => 'Banear Usuario';

  @override
  String banReason(String reason) {
    return 'Motivo: $reason';
  }

  @override
  String get selectBanReason => 'Seleccionar razón del baneo';

  @override
  String get banReasonSpam => 'Spam';

  @override
  String get banReasonScam => 'Estafa';

  @override
  String get banReasonHarassment => 'Acoso a Otros Usuarios';

  @override
  String get banReasonIllegalContent => 'Contenido Ilegal';

  @override
  String get banReasonMultipleViolations => 'Múltiples Violaciones';

  @override
  String get banReasonOther => 'Otro';

  @override
  String get banDuration => 'Duración del Baneo';

  @override
  String get banDuration24h => '24 Horas';

  @override
  String get banDuration7d => '7 Días';

  @override
  String get banDuration30d => '30 Días';

  @override
  String get banDurationPermanent => 'Permanente';

  @override
  String get additionalNotes => 'Notas Adicionales';

  @override
  String get optionalNotes => 'Opcional: Información adicional...';

  @override
  String get confirmBanUser => '¿Realmente quieres banear a este usuario?';

  @override
  String get ban => 'Banear';

  @override
  String get userBanned => 'El usuario ha sido bloqueado';

  @override
  String get userWarned => 'Usuario advertido';

  @override
  String get newsManagementScreen => 'Gestión de Noticias';

  @override
  String get allNews => 'Todas las Noticias';

  @override
  String get publishedNews => 'Publicadas';

  @override
  String get draftNews => 'Borradores';

  @override
  String get createNews => 'Crear Noticia';

  @override
  String get noNewsItems => 'No hay Noticias';

  @override
  String get noNewsItemsMessage => 'Aún no se han creado noticias.';

  @override
  String get newsTitle => 'Título';

  @override
  String get newsContent => 'Contenido';

  @override
  String get newsStatus => 'Estado';

  @override
  String get newsStatusPublished => 'Publicada';

  @override
  String get newsStatusDraft => 'Borrador';

  @override
  String get publishedAt => 'Publicado el';

  @override
  String get editNews => 'Editar Noticia';

  @override
  String get deleteNews => 'Eliminar Noticia';

  @override
  String get createNewsItem => 'Crear Noticia';

  @override
  String get editNewsItem => 'Editar Noticia';

  @override
  String get enterNewsTitle => 'Ingresar título de la noticia';

  @override
  String get enterNewsContent => 'Ingresar contenido de la noticia...';

  @override
  String get newsTitleRequired => 'El título es requerido';

  @override
  String get newsContentRequired => 'El contenido es requerido';

  @override
  String get publish => 'Publicar';

  @override
  String get saveAsDraft => 'Guardar como Borrador';

  @override
  String get newsCreated => 'Noticia creada';

  @override
  String get newsUpdated => 'Noticia actualizada';

  @override
  String get newsDeleted => 'Noticia eliminada';

  @override
  String get confirmDeleteNews => '¿Realmente quieres eliminar esta noticia?';

  @override
  String confirmDeleteNewsWithTitle(String title) {
    return '¿Realmente quieres eliminar \"$title\"?';
  }

  @override
  String get deleteExpired => 'Eliminar caducadas';

  @override
  String get deleteExpiredNews => 'Eliminar noticias caducadas';

  @override
  String get confirmDeleteExpiredNews =>
      '¿Quieres eliminar todas las noticias caducadas?';

  @override
  String expiredNewsDeleted(int count) {
    return '$count noticias caducadas eliminadas';
  }

  @override
  String get newsStatusExpired => 'Caducada';

  @override
  String createdLabel(String date) {
    return 'Creada: $date';
  }

  @override
  String expiresLabel(String date) {
    return 'Caduca: $date';
  }

  @override
  String get markdownSupported => 'Se admite Markdown';

  @override
  String get lifetimeDays => 'Duración (días)';

  @override
  String get defaultLifetimeDays => 'Predeterminado: 14 días';

  @override
  String get expiryDate => 'Fecha de caducidad';

  @override
  String get noExpiryDate => 'Sin fecha de caducidad';

  @override
  String get publishNewsMessage => 'La noticia se mostrará en el panel';

  @override
  String get titleContentRequired =>
      'El título y el contenido no pueden estar vacíos';

  @override
  String get createFirstNews => 'Crea la primera noticia con el botón +.';

  @override
  String errorDeleting(String error) {
    return 'Error al eliminar: $error';
  }

  @override
  String get categoryManagementScreen => 'Gestión de Categorías';

  @override
  String get categories => 'Categorías';

  @override
  String get subcategories => 'Subcategorías';

  @override
  String get createCategory => 'Crear Categoría';

  @override
  String get createSubcategory => 'Crear Subcategoría';

  @override
  String get noCategories => 'No hay Categorías';

  @override
  String get noCategoriesMessage => 'Aún no se han creado categorías.';

  @override
  String get noSubcategories => 'No hay Subcategorías';

  @override
  String get noSubcategoriesMessage => 'Aún no se han creado subcategorías.';

  @override
  String get categoryName => 'Nombre';

  @override
  String get categoryDescription => 'Descripción';

  @override
  String get parentCategory => 'Categoría Padre';

  @override
  String get listingsCount => 'Anuncios';

  @override
  String get editCategory => 'Editar Categoría';

  @override
  String get deleteCategory => 'Eliminar Categoría';

  @override
  String get createCategoryDialog => 'Crear Categoría';

  @override
  String get editCategoryDialog => 'Editar Categoría';

  @override
  String get enterCategoryName => 'Ingresar nombre de categoría';

  @override
  String get enterCategoryDescription => 'Ingresar descripción (opcional)';

  @override
  String get categoryNameRequired => 'El nombre es requerido';

  @override
  String get categoryCreated => 'Categoría creada';

  @override
  String get categoryUpdated => 'Categoría actualizada';

  @override
  String get categoryDeleted => 'Categoría eliminada';

  @override
  String get confirmDeleteCategory =>
      '¿Realmente quieres eliminar esta categoría? Todas las subcategorías asociadas también serán eliminadas.';

  @override
  String confirmDeleteCategoryWithName(String name) {
    return '¿Realmente quieres eliminar \"$name\"?';
  }

  @override
  String get newCategory => 'Nueva categoría';

  @override
  String get addSubcategory => 'Añadir subcategoría';

  @override
  String get createFirstCategory => 'Crea la primera categoría con el botón +.';

  @override
  String subcategoriesCount(int count, int sortOrder) {
    return '$count Subcategorías • Orden: $sortOrder';
  }

  @override
  String get sorting => 'Orden';

  @override
  String sortingLabel(int sortOrder) {
    return 'Orden: $sortOrder';
  }

  @override
  String get sortingHint => '0';

  @override
  String get categoryShownToUsers => 'La categoría se muestra a los usuarios';

  @override
  String categoryHasSubcategories(int count) {
    return '¡Esta categoría tiene $count subcategorías que también se eliminarán!';
  }

  @override
  String get nameRequired => 'El nombre no puede estar vacío';

  @override
  String get paymentSettingsScreen => 'Configuración de Pagos';

  @override
  String get paymentMethods => 'Métodos de Pago';

  @override
  String get fees => 'Tarifas';

  @override
  String get paypalEnabled => 'PayPal Habilitado';

  @override
  String get bitcoinEnabled => 'Bitcoin Habilitado';

  @override
  String get transactionFee => 'Tarifa de Transacción';

  @override
  String get platformFee => 'Tarifa de Plataforma';

  @override
  String get feePercentage => 'Porcentaje';

  @override
  String get minimumFee => 'Tarifa Mínima';

  @override
  String get maximumFee => 'Tarifa Máxima';

  @override
  String get settingsSaved => 'Configuración guardada';

  @override
  String get saveSettings => 'Guardar configuración';

  @override
  String get paymentSettingsInfo =>
      'Esta configuración determina cómo los usuarios pueden pagar por los slots.';

  @override
  String get enablePaypal => 'Activar PayPal';

  @override
  String get paypalPaymentDescription => 'Los usuarios pueden pagar con PayPal';

  @override
  String get paypalEmailAddress => 'Dirección de correo PayPal';

  @override
  String get paypalEmailHint => 'pagos@ejemplo.com';

  @override
  String get enableBitcoin => 'Activar Bitcoin';

  @override
  String get bitcoinPaymentDescription =>
      'Los usuarios pueden pagar con Bitcoin';

  @override
  String get bitcoinWalletAddress => 'Dirección de billetera Bitcoin';

  @override
  String get bitcoinWalletHint => 'bc1q...';

  @override
  String get pendingPaymentsScreen => 'Pagos Pendientes';

  @override
  String get allPendingPayments => 'Todos';

  @override
  String get paypalPayments => 'PayPal';

  @override
  String get bitcoinPayments => 'Bitcoin';

  @override
  String get noPendingPayments => 'No hay Pagos Pendientes';

  @override
  String get noPendingPaymentsMessage =>
      'Actualmente no hay pagos pendientes para procesar.';

  @override
  String get paymentId => 'ID de Pago';

  @override
  String get amount => 'Monto';

  @override
  String get requestedAt => 'Solicitado el';

  @override
  String get paymentStatus => 'Estado';

  @override
  String get paymentStatusPending => 'Pendiente';

  @override
  String get paymentStatusProcessing => 'Procesando';

  @override
  String get paymentStatusCompleted => 'Completado';

  @override
  String get paymentStatusFailed => 'Fallido';

  @override
  String get processPayment => 'Procesar Pago';

  @override
  String get checkBitcoinPayments => 'Verificar pagos Bitcoin';

  @override
  String get expireOldOrders => 'Expirar pedidos antiguos';

  @override
  String get confirmPaymentTitle => 'Confirmar pago';

  @override
  String confirmPaymentMessage(int orderId, String amount, String method) {
    return '¿Realmente quieres confirmar el pago del pedido #$orderId?\n\nCantidad: $amount\nMétodo: $method';
  }

  @override
  String get paymentConfirmedSlotActivated => 'Pago confirmado y slot activado';

  @override
  String bitcoinPaymentsProcessed(int count) {
    return '$count pagos Bitcoin procesados';
  }

  @override
  String get expireOldOrdersTitle => 'Expirar pedidos antiguos';

  @override
  String get expireOldOrdersMessage =>
      '¿Quieres marcar todos los pedidos pendientes de más de 24 horas como expirados?';

  @override
  String get expireAction => 'Expirar';

  @override
  String ordersExpired(int count) {
    return '$count pedidos marcados como expirados';
  }

  @override
  String get allPaymentsProcessed => 'Todos los pagos han sido procesados';

  @override
  String orderNumber(int number) {
    return 'Pedido #$number';
  }

  @override
  String get user => 'Usuario';

  @override
  String get unknown => 'Desconocido';

  @override
  String get variant => 'Variante';

  @override
  String get method => 'Método';

  @override
  String get txId => 'TX-ID';

  @override
  String paymentDetailsTitle(int number) {
    return 'Detalles de pago #$number';
  }

  @override
  String get paypalEmail => 'Email PayPal';

  @override
  String get currency => 'Moneda';

  @override
  String get bitcoinAddress => 'Dirección Bitcoin';

  @override
  String get amountUsd => 'Cantidad (USD)';

  @override
  String get amountBtc => 'Cantidad (BTC)';

  @override
  String get memo => 'Memo';

  @override
  String get markAsProcessing => 'Marcar como Procesando';

  @override
  String get markAsCompleted => 'Marcar como Completado';

  @override
  String get markAsFailed => 'Marcar como Fallido';

  @override
  String get paymentMarkedProcessing => 'Pago marcado como procesando';

  @override
  String get paymentMarkedCompleted => 'Pago marcado como completado';

  @override
  String get paymentMarkedFailed => 'Pago marcado como fallido';

  @override
  String get slotVariantsScreen => 'Variantes de Slot';

  @override
  String get activeSlotVariants => 'Activas';

  @override
  String get inactiveSlotVariants => 'Inactivas';

  @override
  String get createSlotVariant => 'Crear Variante de Slot';

  @override
  String get noSlotVariants => 'No hay Variantes de Slot';

  @override
  String get noSlotVariantsMessage => 'Aún no se han creado variantes de slot.';

  @override
  String get variantName => 'Nombre';

  @override
  String get duration => 'Duración';

  @override
  String durationDays(int days) {
    return '$days días';
  }

  @override
  String get priceUSD => 'Precio (USD)';

  @override
  String get priceBTC => 'Precio (BTC)';

  @override
  String get maxListings => 'Máx. Anuncios';

  @override
  String get variantStatus => 'Estado';

  @override
  String get editSlotVariant => 'Editar Variante de Slot';

  @override
  String get deleteSlotVariant => 'Eliminar Variante de Slot';

  @override
  String get createSlotVariantDialog => 'Crear Variante de Slot';

  @override
  String get editSlotVariantDialog => 'Editar Variante de Slot';

  @override
  String get enterVariantName => 'Ingresar nombre de variante';

  @override
  String get enterDuration => 'Duración (días)';

  @override
  String get enterPriceUSD => 'Precio en USD';

  @override
  String get enterPriceBTC => 'Precio en BTC';

  @override
  String get enterMaxListings => 'Máx. anuncios';

  @override
  String get variantNameRequired => 'El nombre es requerido';

  @override
  String get durationRequired => 'La duración es requerida';

  @override
  String get priceUSDRequired => 'El precio en USD es requerido';

  @override
  String get priceBTCRequired => 'El precio en BTC es requerido';

  @override
  String get maxListingsRequired => 'El máx. de anuncios es requerido';

  @override
  String get slotVariantCreated => 'Variante de slot creada';

  @override
  String get slotVariantUpdated => 'Variante de slot actualizada';

  @override
  String get slotVariantDeleted => 'Variante de slot eliminada';

  @override
  String get confirmDeleteSlotVariant =>
      '¿Realmente quieres eliminar esta variante de slot?';

  @override
  String confirmDeleteSlotVariantWithName(String name) {
    return '¿Realmente quieres eliminar \"$name\"?';
  }

  @override
  String get manageSlotVariants => 'Gestionar variantes de slot';

  @override
  String get createFirstSlotVariant =>
      'Crea la primera variante de slot con el botón +.';

  @override
  String get newSlotVariant => 'Nueva variante de slot';

  @override
  String get freeLabel => 'GRATIS';

  @override
  String get free => 'Gratis';

  @override
  String get nameHint => 'p.ej. Estándar, Premium';

  @override
  String get descriptionOptional => 'Descripción (opcional)';

  @override
  String get priceUsd => 'Precio (USD)';

  @override
  String get durationDaysLabel => 'Duración (días)';

  @override
  String get freeVariantDescription =>
      'La variante es gratuita (para slots promocionales)';

  @override
  String get activeVariantDescription => 'La variante se puede comprar';

  @override
  String get atLeastOnePaymentMethodRequired =>
      'Debe estar activado al menos un método de pago';

  @override
  String get userManagementScreen => 'Gestión de Usuarios';

  @override
  String get allUsers => 'Todos los Usuarios';

  @override
  String get activeUsers => 'Activos';

  @override
  String get bannedUsers => 'Baneados';

  @override
  String get searchUsers => 'Buscar usuarios...';

  @override
  String get noUsers => 'No hay Usuarios';

  @override
  String get noUsersMessage => 'No se encontraron usuarios.';

  @override
  String get role => 'Rol';

  @override
  String get viewUser => 'Ver Usuario';

  @override
  String get unbanUser => 'Desbloquear Usuario';

  @override
  String get userUnbanned => 'El usuario ha sido desbloqueado';

  @override
  String get confirmUnbanUser => '¿Realmente quieres desbanear a este usuario?';

  @override
  String get unban => 'Desbanear';

  @override
  String get administration => 'Administración';

  @override
  String get systemUserManagement => 'Gestión de sistema y usuarios';

  @override
  String get manageCategories => 'Gestionar categorías';

  @override
  String get createCategoriesSubcategories =>
      'Crear categorías y subcategorías';

  @override
  String get configureSlotTypes => 'Configurar tipos y precios de slots';

  @override
  String get paypalBitcoinSlots => 'PayPal y Bitcoin para compra de slots';

  @override
  String get reviewPendingOrders => 'Revisar y confirmar pedidos pendientes';

  @override
  String get manageUsersRoles => 'Gestionar usuarios y asignar roles';

  @override
  String featureInMilestone(String title, String milestone) {
    return '$title se implementará en el hito $milestone.';
  }

  @override
  String get slots => 'Slots';

  @override
  String get payments => 'Pagos';

  @override
  String get users => 'Usuarios';

  @override
  String get moderatorPanelScreen => 'Panel de Moderador';

  @override
  String openReportsCount(int count) {
    return '$count abiertos';
  }

  @override
  String get listingReports => 'Ofertas';

  @override
  String get userReports => 'Usuarios';

  @override
  String get noReportsDescription => 'Actualmente no hay reportes';

  @override
  String get listing => 'Oferta';

  @override
  String get reportStatusOpen => 'ABIERTO';

  @override
  String get reportStatusReviewing => 'EN REVISIÓN';

  @override
  String get reportStatusResolved => 'RESUELTO';

  @override
  String get reportStatusDismissed => 'DESESTIMADO';

  @override
  String get reportReasonFraud => 'Oferta Fraudulenta';

  @override
  String get assigned => 'Asignado';

  @override
  String get justNow => 'Justo ahora';

  @override
  String minutesAgo(int minutes) {
    return 'hace ${minutes}m';
  }

  @override
  String hoursAgo(int hours) {
    return 'hace ${hours}h';
  }

  @override
  String daysAgo(int days) {
    return 'hace ${days}d';
  }

  @override
  String get staff => 'Personal';

  @override
  String get banned => 'BLOQUEADO';

  @override
  String get noUsersFound => 'No se Encontraron Usuarios';

  @override
  String get reportAssignedToYou => 'El reporte ha sido asignado a ti';

  @override
  String get statusUpdated => 'El estado ha sido actualizado';

  @override
  String get noteCannotBeEmpty => 'La nota no puede estar vacía';

  @override
  String get deactivateListing => 'Desactivar Oferta';

  @override
  String get deactivateListingConfirm =>
      '¿Realmente desea desactivar esta oferta? Esta acción no se puede deshacer.';

  @override
  String get deactivate => 'Desactivar';

  @override
  String get listingDeactivated => 'La oferta ha sido desactivada';

  @override
  String get reportNotFound => 'Reporte no encontrado';

  @override
  String assignedToModerator(int id) {
    return 'Asignado al moderador #$id';
  }

  @override
  String get notYetAssigned => 'Aún no asignado';

  @override
  String get reportDetails => 'Detalles del Reporte';

  @override
  String get reportedOn => 'Reportado el';

  @override
  String reporterUser(int id) {
    return 'Usuario #$id';
  }

  @override
  String get reportedUserProfile => 'Perfil de Usuario Reportado';

  @override
  String get addInternalNotes => 'Agregar notas internas...';

  @override
  String get assignToMe => 'Asignarme';

  @override
  String get markAsResolved => 'Marcar como Resuelto';

  @override
  String fullDateTimeFormat(
      String day, String month, int year, String hour, String minute) {
    return '$day.$month.$year a las $hour:$minute';
  }

  @override
  String listingId(int id) {
    return 'Oferta #$id';
  }

  @override
  String get warning => 'Advertencia';

  @override
  String confirmRoleChange(String role) {
    return '¿Realmente desea asignar el rol \"$role\" a este usuario? Esta acción otorga permisos extendidos al usuario.';
  }

  @override
  String get roleUpdated => 'El rol ha sido actualizado';

  @override
  String error(String error) {
    return 'Error: $error';
  }

  @override
  String get noFreeSlotVariantsAvailable =>
      'No hay variantes de slot gratuitas disponibles. Crea primero una variante gratuita.';

  @override
  String get grantFreeSlot => 'Otorgar Slot Gratuito';

  @override
  String selectFreeSlotVariant(String username) {
    return 'Selecciona una variante de slot gratuita para $username:';
  }

  @override
  String daysRuntime(int days) {
    return '$days días de duración';
  }

  @override
  String get freeUppercase => 'GRATIS';

  @override
  String freeSlotGranted(String variantName, String username) {
    return 'El slot gratuito \"$variantName\" ha sido otorgado a $username';
  }

  @override
  String get confirmUnban => '¿Realmente desea desbloquear a este usuario?';

  @override
  String get unbanReason => 'Bloqueo levantado por el administrador';

  @override
  String get information => 'Información';

  @override
  String get lastLogin => 'Último Inicio de Sesión';

  @override
  String get never => 'Nunca';

  @override
  String get status => 'Estado';

  @override
  String get bannedSince => 'Bloqueado Desde';

  @override
  String get banReasonLabel => 'Motivo del Bloqueo';

  @override
  String get cannotChangeOwnRole => 'No puede cambiar su propio rol.';

  @override
  String get roleDescriptionAdmin => 'Acceso completo a todas las funciones';

  @override
  String get roleDescriptionModerator =>
      'Puede gestionar reportes y moderar contenido';

  @override
  String get roleDescriptionUser => 'Usuario regular sin permisos extendidos';

  @override
  String get banHistory => 'Historial de Bloqueos';

  @override
  String get bannedAction => 'Bloqueado';

  @override
  String get unbannedAction => 'Desbloqueado';

  @override
  String get banReasonFraud => 'Fraude/Estafa';

  @override
  String get banReasonInappropriate => 'Comportamiento Inapropiado';

  @override
  String get banReasonTosViolation => 'Violación de Términos de Servicio';

  @override
  String get banReasonMultipleAccounts => 'Múltiples Cuentas';

  @override
  String get banReasonIllegal => 'Actividades Ilegales';

  @override
  String get banReasonRequired => 'Por favor ingrese un motivo';

  @override
  String get enterBanReason =>
      'Por favor proporcione un motivo para el bloqueo:';

  @override
  String get presetReasons => 'Motivos Predefinidos:';

  @override
  String get reasonRequired => 'Motivo (requerido)';

  @override
  String get describeBanReason => 'Describa el motivo del bloqueo...';

  @override
  String get banWarning =>
      'Advertencia: El bloqueo desactivará todas las ofertas activas y cancelará las transacciones abiertas del usuario.';

  @override
  String get banAction => 'Bloquear';

  @override
  String get sectionDonate => 'Apoyar al Desarrollador';

  @override
  String get donateTitle => 'Apoyar el Desarrollo';

  @override
  String get donateDescription =>
      'Si te gusta esta aplicación, puedes apoyar su desarrollo con una donación:';

  @override
  String get donateBitcoin => 'Donar Bitcoin';

  @override
  String get donateCoffee => 'Buy Me a Coffee';

  @override
  String get bitcoinAddressCopied => '¡Dirección Bitcoin copiada!';
}
