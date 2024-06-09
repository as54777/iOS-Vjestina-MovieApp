class MovieDataSource {
    private let movieService = MovieService()
    
    func fetchPopularMovies() async throws -> [MovieService.MovieResponse] {
        return try await movieService.fetchPopularMovies()
    }
    
    func fetchFreeToWatchMovies() async throws -> [MovieService.MovieResponse] {
        return try await movieService.fetchFreeToWatchMovies()
    }
    
    func fetchTrendingMovies() async throws -> [MovieService.MovieResponse] {
        return try await movieService.fetchTrendingMovies()
    }
    
    func searchMovies(byTitle title: String) async throws -> [MovieService.MovieDetailsResponse] {
        return try await movieService.searchMovies(byTitle: title)
    }
    
    func fetchMovieDetails(for id: Int) async throws -> MovieService.MovieDetailsResponse {
        return try await movieService.fetchMovieDetails(for: id)
    }
    
    func fetchDetails(byId id: Int) async throws -> MovieService.MovieResponse {
        return try await movieService.fetchDetails(byId: id)
    }
}
