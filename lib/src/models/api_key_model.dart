// ignore_for_file: public_member_api_docs, sort_constructors_first
class ApiKeyModel {
  String prefix;
  String scope;
  String name;
  String? expiryDate;
  String created;
  bool revoked;
  String lastUsed;

  ApiKeyModel({
    required this.prefix,
    required this.scope,
    required this.name,
    required this.created,
    required this.revoked,
    required this.lastUsed,
    this.expiryDate,
  });
}
