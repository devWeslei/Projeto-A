import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:html/dom.dart' as html;

class GoogleSearchAPI {
Future<List<Map<String, String>>> search(String query) async {
    final response = await http.get(Uri.parse('https://www.google.com/search?q=$query'));
    final document = htmlParser.parse(response.body);

    final titles = _extractTitles(document);
    final links = _extractLinks(document);

    final List<Map<String, String>> results = [];

    for (int i = 0; i < titles.length && i < links.length; i++) {
      results.add({
        'title': titles[i] ?? '', // Se o título for nulo, atribuímos uma string vazia
        'link': links[i] ?? '' // Se o link for nulo, atribuímos uma string vazia
      });
    }
    return results;
  }

  List<String> _extractTitles(html.Document document) {
    return document.querySelectorAll('h3').map((element) => element.text).toList();
  }

  List<String?> _extractLinks(html.Document document) {
    return document.querySelectorAll('a').map((element) => element.attributes['href']).toList();
  }
}