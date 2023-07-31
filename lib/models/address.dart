import 'package:xlo_mobx/models/uf.dart';

import '../repositories/city.dart';

class Address {
  UF uf;
  City city;
  String cep;
  String district;

  Address({
    required this.uf,
    required this.city,
    required this.cep,
    required this.district,
  });

  @override
  String toString() {
    return 'Address{uf: $uf, city: $city, cep: $cep, district: $district}';
  }
}
