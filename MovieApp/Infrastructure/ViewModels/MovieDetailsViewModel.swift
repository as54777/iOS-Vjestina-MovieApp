import Foundation

class MovieDetailsViewModel {
    var movieDetails: MovieService.MovieDetailsResponse? {
        didSet {
            onUpdateMovieDetails?()
        }
    }
    
    var onUpdateMovieDetails: (() -> Void)?
    private let movieId: Int
    private let dataSource = MovieService()
    
    init(movieId: Int) {
        self.movieId = movieId
        fetchMovieDetails()
    }
    
    func fetchMovieDetails() {
        Task {
            do {
                let details = try await dataSource.fetchMovieDetails(for: movieId)
                DispatchQueue.main.async {
                    self.movieDetails = details
                }
            } catch {
                print("Error fetching movie details: \(error)")
            }
        }
    }
}
