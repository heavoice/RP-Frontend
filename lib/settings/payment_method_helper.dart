String formatPaymentMethod(String method) {
  switch (method) {
    case "BANK_TRANSFER":
      return "Bank Transfer";
    case "E_WALLET":
      return "E-Wallet";
    case "CREDIT_CARD":
      return "Credit Card";
  }

  throw Exception("Unknown payment method: $method");
}
