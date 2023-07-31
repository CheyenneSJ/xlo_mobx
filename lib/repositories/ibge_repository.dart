import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/uf.dart';
import 'city.dart';

class IBGERepository {
  Future<List<UF>> getUFListFromApi() async {
    final preferences = await SharedPreferences.getInstance();

    if (preferences.containsKey('UF_LIST')) {
      final j = json.decode(preferences.getString('UF_LIST') ?? '');

      final ufs = j.map<UF>((j) => UF.fromJson(j)).toList();
      // ufs.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      return ufs;
    }
    const endpoint =
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados';

    try {
      final response = await Dio().get<List>(endpoint);
      preferences.setString('UF_LIST', json.encode(response.data));

      return response.data!.map<UF>((j) => UF.fromJson(j)).toList()
        ..sort((UF a, UF b) =>
            a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    } on DioException catch (e) {
      return Future.error('Falha ao obter lista de Estados');
    }
  }

  Future<List<City>> getCityListFromApi(UF uf) async {
    final String endpoint =
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados/${uf.id}/municipios';

    try {
      final response = await Dio().get<List>(endpoint);
      if (response.data == null) return [];
      final cityList = response.data!
          .map<City>((j) => City.fromJson(j))
          .toList()
        ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      return cityList;
    } on DioException catch (e) {
      return Future.error('falha ao buscar as cidades');
    }
  }
}
