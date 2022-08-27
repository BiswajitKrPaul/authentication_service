enum QueryMode { insert, update, delete, select, paginatedSelect }

class QueryBuilder {
  QueryBuilder.insert({
    required this.columnNames,
    required this.columnValues,
    required this.tableName,
  })  : mode = QueryMode.insert,
        pageNo = 0,
        limit = 0;

  QueryBuilder.paginatedSelect({
    required this.columnNames,
    required this.tableName,
    this.pageNo = 1,
    this.limit = 10,
  })  : mode = QueryMode.paginatedSelect,
        columnValues = [];

  final List<String> columnNames;
  final List<dynamic> columnValues;
  final String tableName;
  final int pageNo;
  final int limit;

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
      case QueryMode.paginatedSelect:
        return _buildPaginatedSelectQuery(
          columnNames,
          tableName,
          pageNo,
          limit,
        );
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

  String? _buildPaginatedSelectQuery(
    List<String> columnNames,
    String tableName,
    int page,
    int limit,
  ) {
    if (columnNames.isNotEmpty && tableName.isNotEmpty) {
      final offset = pageNo <= 1 ? 0 : (pageNo - 1) * limit;

      return 'select (select count(*) from $tableName) as count, '
          "${columnNames.join(',')} from $tableName"
          ' limit $limit offset $offset ';
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
