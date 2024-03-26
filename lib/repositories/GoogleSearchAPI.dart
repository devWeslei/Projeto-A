import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:html/dom.dart' as html;
import 'package:projeto/models/Item.dart';

class GoogleSearchAPI {
  Future<List<Item>> search(String query) async {
    final response =
    await http.get(Uri.parse('https://www.google.com/search?q=$query'));
    if (response.statusCode == 200) {
      final document = htmlParser.parse(response.body);

      return extractSearchResults(document);
    } else {
      throw Exception('Failed to load data');
    }
  }

  List<Item> extractSearchResults(html.Document document) {
    // Esse codigo navega a estrutura html da pagina de resultados do google para descobrir
    // os titulos e os links associados aos titulos. No momento de implementacao desse metodo
    // esta era a estrutura atual da pagina resultado de busca do google:
    //
    // <div>
    //  <a>
    //     <div>
    //         <div>
    //          <h3>Título</h3>       *Leitura: Título esta no elemento H3 > nodes[list no indice 0].toString();
    //         </div>                         e Linke associado está no H3 > div pai > div pai > elemento a > div
    //     </div>                                                           > "href" -> "Link associado ao título"
    //
    //     <div>
    //       "href" -> "Link associado ao título"
    //     </div>
    //  </a>
    // </div>

    List<Item> result = [];
    List<html.Element> h3List = document.querySelectorAll('h3');
    for (html.Element h3 in h3List) {
      String title = (((h3.nodes)[0] as html.Element).nodes)[0].toString();
      String? href = (h3.parentNode?.parentNode?.parentNode as html.Element)
          .attributes['href'];
      print(href);
      if (href != null) {
        String? url = href.replaceAll("/url?q=", ""); //corta o inicio do link, começando pelo http...
        url = url.substring(0, url.indexOf("&sa"));   //corta a string até o valor "&sa"
        result.add(Item(
            title: title,
            link: Uri.decodeFull(Uri.decodeFull(url)) // decode 2 vzs porque de alguma forma o google estava fazendo 2 encodes no href.
            ));
      }
    }
    return result;
  }
}
