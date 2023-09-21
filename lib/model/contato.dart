class Contato {
  String? _objectId;
  String? _nome;
  String? _sobreNome;
  String? _tel;
  String? _path;

  Contato(
      {String? objectId,
      String? nome,
      String? sobreNome,
      String? tel,
      String? path}) {
    if (objectId != null) {
      _objectId = objectId;
    }
    if (nome != null) {
      _nome = nome;
    }
    if (sobreNome != null) {
      _sobreNome = sobreNome;
    }
    if (tel != null) {
      _tel = tel;
    }
    if (path != null) {
      _path = path;
    }
  }

  String? get objectId => _objectId;
  set objectId(String? objectId) => _objectId = objectId;

  String? get path => _path;
  set path(String? path) => _path = path;

  String? get nome => _nome;
  set nome(String? nome) => _nome = nome;
  String? get sobreNome => _sobreNome;
  set sobreNome(String? sobreNome) => _sobreNome = sobreNome;
  String? get tel => _tel;
  set tel(String? tel) => _tel = tel;

  Contato.fromJson(Map<String, dynamic> json) {
    _objectId = json['objectId'];
    _nome = json['nome'];
    _sobreNome = json['sobre_nome'];
    _tel = json['tel'];
    _path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_objectId != null) {
      data['objectId'] = _objectId;
    }
    data['nome'] = _nome;
    data['sobre_nome'] = _sobreNome ?? '';
    data['tel'] = _tel;

    data['path'] = _path ?? '';

    return data;
  }

  @override
  String toString() {
    return 'Contato(_objectId: $_objectId, _nome: $_nome, _sobreNome: $_sobreNome, _tel: $_tel, _path: $_path)';
  }
}
