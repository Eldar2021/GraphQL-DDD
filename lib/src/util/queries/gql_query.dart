mixin GqlQuery {
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
}
