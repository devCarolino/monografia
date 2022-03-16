class Usuario{
  late String _nome;
  late String _contato;
  late String _email;
  late String _senha;
  late String _csenha;
  late String _pais;
  late String _nivel;
  late String _url;

  Usuario();

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "nome": this.nome,
      "contacto": this.contato,
      "email": this.email,
      "pais": this.pais,
      "nivel": this.nivel,
      "url": this._url

    };
    return map;
  }

  String get url => _url;

  set url(String value) {
    _url = value;
  }

  String get nivel => _nivel;

  set nivel(String value) {
    _nivel = value;
  }

  String get pais => _pais;

  set pais(String value) {
    _pais = value;
  }

  String get csenha => _csenha;

  set csenha(String value) {
    _csenha = value;
  }

  String get senha => _senha;

  set senha(String value) {
    _senha = value;
  }

  String get email => _email;

  set email(String? value) {
    _email = value!;
  }

  String get contato => _contato;

  set contato(String value) {
    _contato = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }
}

