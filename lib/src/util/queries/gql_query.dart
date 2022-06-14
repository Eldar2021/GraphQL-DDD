class GqlQuery {
  GqlQuery._();

  static const String charactersQuery = r'''
  query ($page: Int!){
    characters(page: $page){
      results{
        id
        name
        status
        gender
        type
        species
        image
      }
    }
  }
  ''';

  static const String locationsQuery = r'''
  query ($page: Int!){
    locations(page: $page){
      results{
        id
        name
        type
        dimension
      }
    }
  }
  ''';

  static const String episodesQuery = r'''
  query ($page: Int!){
    episodes(page: $page){
      results{
        id
        name
        episode
        air_date
      }
    }
  }
  ''';

  // ignore: leading_newlines_in_multiline_strings
  static const String getUsersQuery = '''query{
  users{
    data{
      id
      name
    }
  }
}''';

// ignore: leading_newlines_in_multiline_strings
  static const String getTodoQuery = '''query{
  todos{
    data{
      id
      title
      completed
      user{
        id
        name
      }
    }
  }
}''';

// ignore: avoid_positional_boolean_parameters
  static String addTodoMutation(String title, bool completed) => '''
mutation{
  createTodo(input: {title: "$title", completed: $completed}){
    id
    title
    completed
  }
}''';
}
