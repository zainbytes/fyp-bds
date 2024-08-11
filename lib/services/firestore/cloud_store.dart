class CloudStore {
  static CloudStore? _firestore;
  CloudStore._();

  static get getInstance{
    _firestore ??= CloudStore._();
    return _firestore;
  }
}