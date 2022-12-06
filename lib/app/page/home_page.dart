import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final mock = [
    {
      'date': DateTime.now(),
      'title': 'Whatever',
      'description': 'Description',
      'link':
          'https://www.intoxianime.com/2022/12/sentai-daishikkaku-anime-do-autor-de-gotoubun-ganha-trailer-e-diretor-responsavel/',
    }
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Masterclass 5'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: mock.length,
          itemBuilder: (context, index) {
            final item = mock.elementAt(index);

            final title = item['title'] as String;            
            final description = item['description'] as String;
            final date = item['date'] as DateTime;
            final link = item['link'] as String;

            return Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: theme.primaryColor,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Text(
                          '${date.day}/${date.month}/${date.year}',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () => launchUrlString(link),
                        child: const Text(
                          'Acessar matéria',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
