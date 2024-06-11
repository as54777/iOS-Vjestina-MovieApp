import Foundation

class MovieCategoryViewModel {
    var popularMovies: [MovieService.MovieResponse] = [] {
        didSet {
            onUpdatePopularMovies?()
        }
    }
    
    var freeToWatchMovies: [MovieService.MovieResponse] = [] {
        didSet {
            onUpdateFreeToWatchMovies?()
        }
    }
    
    var trendingMovies: [MovieService.MovieResponse] = [] {
        didSet {
            onUpdateTrendingMovies?()
        }
    }
    
    var onUpdatePopularMovies: (() -> Void)?
    var onUpdateFreeToWatchMovies: (() -> Void)?
    var onUpdateTrendingMovies: (() -> Void)?
    
    private let dataSource = MovieService()
    
    func fetchAllMovies() {
        Task {
            do {
                let popular = try await dataSource.fetchPopularMovies()
                let freeToWatch = try await dataSource.fetchFreeToWatchMovies()
                let trending = try await dataSource.fetchTrendingMovies()
                
                DispatchQueue.main.async {
                    self.popularMovies = popular
                    self.freeToWatchMovies = freeToWatch
                    self.trendingMovies = trending
                }
            } catch {
                print("Failed to fetch movies: \(error)")
            }
        }
    }
}
