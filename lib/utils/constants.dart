// ignore_for_file: constant_identifier_names

import 'dart:math';

class Constants {
  static const IMAGES_API = 'https://picsum.photos/v2/list?page=1&limit=10';
  static imagemRandom([String num = '10']) =>
      'https://picsum.photos/v2/list?page=${Random().nextInt(10) + 1}&limit=$num';
  // static const USER_FAVORITES_URL =
  //     'https://acme-store-791ae-default-rtdb.firebaseio.com/userFavorites';
  static const PRODUTOS_BASE_URL =
      'https://starships-cod3r-default-rtdb.firebaseio.com/produtos';
  static const PEDIDOS_BASE_URL =
      'https://acme-store-791ae-default-rtdb.firebaseio.com/pedidos';
}
