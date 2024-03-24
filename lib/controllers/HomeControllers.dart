import 'dart:convert';

import 'package:get/get.dart';
import 'package:projeto/repositories/GoogleSearchAPI.dart';
import '../models/Item.dart';

class HomeController extends GetxController{
  final RxString searchText = ''.obs; // Texto digitado pelo usuário
  final RxList<Item> results = <Item>[].obs; // Lista de resultados da busca

  final GoogleSearchAPI googleSearchApi = GoogleSearchAPI();

  void search() async {
    // Limpa a lista de resultados antes de cada nova busca
    results.clear();


    // Realiza a busca usando a API
    final List<Map<String, String?>> data = await googleSearchApi.search(searchText.value);

    // Converte a lista de mapas em uma lista de objetos Item
    final List<Item> items = data.map((item) => Item.fromJson(item)).toList();

    // Atualiza a lista de resultados
    results.addAll(items);

    Get.find<HomeController>().update();
  }
}