import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:html/dom.dart' as html;

class GoogleSearchAPI {
  Future<List<Map<String, String>>> search(String query) async {
    final response =
        await http.get(Uri.parse('https://www.google.com/search?q=$query'));
    if (response.statusCode == 200) {
      final document = htmlParser.parse(response.body);

      final titles = _extractTitles(document);
      final links = _extractLinks(document);

      final List<Map<String, String>> results = [];

      for (int i = 0; i < titles.length && i < links.length; i++) {
        results.add({
          'title': titles[i] ?? '',
          // Se o título for nulo, atribuímos uma string vazia
          'link': links[i] ?? ''
          // Se o link for nulo, atribuímos uma string vazia
        });
      }
      return results;
    } else {
      throw Exception('Failed to load data');
    }
  }

  List<String> _extractTitles(html.Document document) {
    return document
        .querySelectorAll('h3')
        .map((element) => element.text)
        .toList();
  }

  List<String?> _extractLinks(html.Document document) {
    final List<String?> links = [];

    // Encontrar todos os links dentro dos elementos com classe 'tF2Cxc'
    final RegExp regExp = RegExp(r'<a href="/url\?q=(.*?)&');
    final Iterable<RegExpMatch> matches = regExp.allMatches(document.outerHtml);

    // Iterar sobre as correspondências e extrair os links
    for (RegExpMatch match in matches) {
      final link = match.group(1);
      if (link != null) {
        links.add(Uri.decodeFull(link));
      }
    }
    return links;
  }



//////////////////////////////



//////////////////////////////



//List<String?> _extractLinks(html.Document document) {
//return document.querySelectorAll('a').map((element) => element.attributes['href']).toList();

//   final List<String?> links = [];
//
//   // Seleciona todos os elementos 'a' dentro do documento
//   final elements = document.querySelectorAll('a');
//
//   // Itera sobre os elementos 'a' e extrai o atributo 'href' (link)
//   for (var element in elements) {
//     final link = element.attributes['href'];
//
//     // Verifica se a URL começa com 'https://www.google.com/'
//     // Se não, adiciona esse prefixo à URL
//     if (link != null && !link.startsWith('https://www.google.com/')) {
//       links.add('https://www.google.com$link');
//     } else {
//       links.add(link);
//     }
//   }
//   return links;
// }
}
