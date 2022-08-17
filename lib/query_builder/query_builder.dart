enum QueryMode { insert, update, delete, select }

class QueryBuilder {
  QueryBuilder.insert({
    required this.columnNames,
    required this.columnValues,
    required this.tableName,
  }) : mode = QueryMode.insert;

  final List<String> columnNames;
  final List<dynamic> columnValues;
  final String tableName;

  final QueryMode mode;

  String? buildQuery() {
    switch (mode) {
      case QueryMode.insert:
        return _buildInserQuery(columnNames, columnValues, tableName);

      case QueryMode.update:
        return '';

      case QueryMode.delete:
        return '';
      case QueryMode.select:
        return '';
    }
  }

  String? _buildInserQuery(
    List<String> columnNames,
    List<dynamic> columnValues,
    String tableName,
  ) {
    if (checkValidation()) {
      return "insert into $tableName (${columnNames.join(',')})"
          " values (${columnValues.map((e) {
        if (e is String) {
          e = "'$e'";
        }
        return e;
      }).join(',')})";
    }
    return null;
  }

  bool checkValidation() {
    if (columnNames.isEmpty) {
      return false;
    } else if (columnValues.isEmpty ||
        columnValues.length != columnNames.length) {
      return false;
    } else if (tableName.isEmpty) {
      return false;
    }
    return true;
  }
}
