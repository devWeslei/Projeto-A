import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

class GoogleSearchAPI {
  Future<List<Map<String, String>>> search(String query) async {
    // URL da pesquisa Google.
    final url = Uri.https('www.google.com', '/search', {'q': query});

    // Obter o HTML da página de resultados.
    final response = await http.get(url);
    final htmlDocument = response.body;

    // Extrair os títulos e links das páginas.
    final titles = _extractTitles(htmlDocument);
    final links = _extractLinks(htmlDocument);

    // Combinar títulos e links em uma lista de mapas.
    final results = List.generate(titles.length, (index) => {
      'title': titles[index],
      'link': links[index],
    });

    return results;
  }

  List<String> _extractTitles(String html) {
    // Selecionar elementos `h3` com a classe `r`.
    final elements = parser.parse(html).querySelectorAll('body > div.main > div.mw > div.main-content > div.result-list > div > div.r > a.r > h3');

    // Extrair o texto de cada elemento.
    final titles = elements.map((element) => element.text.trim()).toList();

    return titles;
  }

  List<String> _extractLinks(String html) {
    // Selecionar elementos `a` com a classe `r`.
    final elements = parser.parse(html).querySelectorAll('body > div.main > div.mw > div.main-content > div.result-list > div > div.r > a.r > h3 > a');

    // Extrair o atributo `href` de cada elemento.
    final links = elements.map((element) => element.attributes['href']).toList();

    // Corrigir links relativos para absolutos.
    final absoluteLinks = links.map((link) => Uri.parse(link!).toString()).toList();

    return absoluteLinks;
  }
}