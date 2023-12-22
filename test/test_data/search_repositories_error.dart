import 'dart:convert';

final testDataSearchRepositoriesError = json.decode('''
{
    "total_count": 1,
    "incomplete_results": false,
    "items": []
}
''') as Map<String, dynamic>;
