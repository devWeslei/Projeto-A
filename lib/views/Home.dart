import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:projeto/controllers/HomeControllers.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../models/DialogWidget.dart';

class Home extends StatelessWidget {
  Home({
    Key? key,
  }) : super(key: key);

  final HomeController controller = Get.put(HomeController());

  _validateField() {
    String search = controller.searchText.value;

    if (search.isNotEmpty) {
      controller.search();
    } else {
      controller.results.clear();
      DialogWidget('Ops!', 'Preencha o campo de busca!').showDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(children: [
          const SizedBox(
            width: 20,
            height: 20,
          ),
          const Text(
            'Olá! insira o texto que queira pesquisar',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 02, 12, 02),
            child: TextField(
              onChanged: (text) => controller.searchText.value = text,
              buildCounter: (BuildContext context,
                      {int? currentLength, int? maxLength, bool? isFocused}) =>
                  null,
              maxLength: 250,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              style: const TextStyle(fontSize: 18),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                hintText: "O que procura?",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff334bea),
                padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              onPressed: () => _validateField(),
              child: const Text(
                "Pesquisar",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: controller.results.length,
                  itemBuilder: (context, index) {
                    final item = controller.results[index];
                    return ListTile(
                      title: Text(item.title),
                      subtitle: InkWell(
                        onTap: () => launchUrlString(item.link),
                        child: Text(
                          item.link,
                          style: const TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    );
                  },
                )),
          ),
        ]),
      ),
    );
  }
}
