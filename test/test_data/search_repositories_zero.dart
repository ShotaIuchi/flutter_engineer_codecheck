import 'dart:convert';

final testDataSearchRepositoriesZero = json.decode('''
{
    "total_count": 0,
    "incomplete_results": false,
    "items": []
}
''') as Map<String, dynamic>;
