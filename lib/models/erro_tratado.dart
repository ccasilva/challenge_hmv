class ErroTratado implements Exception{
  static const Map<String,String> erros = {
    'ERRO_CADASTRO': 'Não foi possivel se cadastrar.',
    'ERRO_AUTENTICAR': 'Não foi possivel se autenticar.'
  };

  final String key;
  ErroTratado(this.key);

  @override
  String toString() {
    // TODO: implement toString
    return erros[key] ?? 'Ocorreu um erro no processo.';
  }
}