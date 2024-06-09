import Foundation
import MovieAppData

class MovieListViewModel {
    
    private let movieUseCase = MovieUseCase()
    
    var allMovies: [MovieModel] {
        return movieUseCase.allMovies
    }
    
    func getMovieDetails(at index: Int) -> MovieDetailsModel? {
        let movie = allMovies[index]
        return movieUseCase.getDetails(id: movie.id)
    }
}

