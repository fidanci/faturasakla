class Hatalar {
  static String goster(String hataKodu) {
    switch (hataKodu) {
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        return "Bu mail adresi kullanımda, lütfen farklı bir mail adresi deneyiniz!";
        break;
      case 'ERROR_USER_NOT_FOUND':
        return "Bu kullanıcı sistemde bulunmamaktadır! Lütfen kayıt olunuz.";
        break;
      default:
        return "Sunucu kaynaklı bir hata oluştu";
    }
  }
}
