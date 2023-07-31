import 'package:mobx/mobx.dart';

part 'cep_store.g.dart';

class CepStore = _CepStore with _$CepStore;

abstract class _CepStore with Store {
  @observable
  String? cep;

  @action
  void setCep(String value) => cep = value;

  @computed
  String? get clearCep => cep?.replaceAll(RegExp('[ˆ0-9]'), '');
}
