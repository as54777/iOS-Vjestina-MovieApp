import Foundation

class MovieService {

    struct MovieResponse: Decodable {
        let id: Int
        let imageUrl: String
        let name: String
        let summary: String
        let year: Int
    }
    
    struct MovieDetailsResponse: Decodable {
        let categories: [String]
        let crewMembers: [CrewMember]
        let duration: Int
        let id: Int
        let imageUrl: String
        let name: String
        let rating: Double
        let releaseDate: String
        let summary: String
        let year: Int
    }
    
    struct CrewMember: Codable {
        let name: String
        let role: String
    }
    
    enum Criteria: String {
        case freeToWatch = "free-to-watch"
        case popular
        case trending
        case movie = "MOVIE"
        case tv_show = "TV_SHOW"
        case for_rent = "FOR_RENT"
        case in_theatres = "IN_THEATRES"
        case on_tv = "ON_TV"
        case streaming = "STREAMING"
        case thisWeek = "THIS_WEEK"
        case today = "TODAY"
    }
    
    func fetchMovies(from url: String) async throws -> [MovieResponse] {
        guard let url = URL(string: url) else { throw URLError(.unsupportedURL) }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer Zpu7bOQYLNiCkT32V3c9BPoxDMfxisPAfevLW6ps", forHTTPHeaderField: "Authorization")
        
        guard let (data, response) = try? await URLSession.shared.data(for: request) else { throw URLError(.unsupportedURL) }
        
        let movies = try JSONDecoder().decode([MovieResponse].self, from: data)
        
        return movies
    }
    
    func fetchFreeToWatchMovies() async throws -> [MovieResponse] {
        var freeToWatchMovies: [MovieResponse] = []
        
        for criterion in [Criteria.movie, Criteria.tv_show]  {
            let url = "https://five-ios-api.herokuapp.com/api/v1/movie/free-to-watch?criteria=\(criterion.rawValue)"
            let movies = try await fetchMovies(from: url)
            freeToWatchMovies.append(contentsOf: movies)
        }

        return freeToWatchMovies
    }

    func fetchPopularMovies() async throws -> [MovieResponse]{
        var popularMovies: [MovieResponse] = []
        
        for criterion in [Criteria.for_rent, Criteria.streaming, Criteria.in_theatres, Criteria.on_tv] {
            let url = "https://five-ios-api.herokuapp.com/api/v1/movie/popular?criteria=\(criterion.rawValue)"
            do {
                let movies = try await fetchMovies(from: url)
                popularMovies.append(contentsOf: movies)
            } catch {
                print("BAD LUCK")
            }
            
        }
        return popularMovies
    }

    func fetchTrendingMovies() async throws -> [MovieResponse] {
        var trendingMovies: [MovieResponse] = []
        
        for criterion in [Criteria.thisWeek, Criteria.today] {
            let url = "https://five-ios-api.herokuapp.com/api/v1/movie/trending?criteria=\(criterion.rawValue)"
            let movies = try await fetchMovies(from: url)
            trendingMovies.append(contentsOf: movies)
        }
        
        return trendingMovies
    }
    
    func fetchMovieDetails(for id: Int) async throws -> MovieDetailsResponse {
        let urlString = "https://five-ios-api.herokuapp.com/api/v1/movie/\(id)/details"
        
        print("URL String: \(urlString)")
        
        guard let url = URL(string: urlString) else { throw URLError(.unsupportedURL) }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer Zpu7bOQYLNiCkT32V3c9BPoxDMfxisPAfevLW6ps", forHTTPHeaderField: "Authorization")
        
        guard let (data, response) = try? await URLSession.shared.data(for: request) else { throw URLError(.unsupportedURL) }
        
        let movieDetails = try JSONDecoder().decode(MovieDetailsResponse.self, from: data)
        
        return movieDetails
    }
    
    func searchMovies(byTitle title: String) async throws -> [MovieDetailsResponse] {
        let urlString = "https://five-ios-api.herokuapp.com/api/v1/movie/search?title=\(title)"
        guard let url = URL(string: urlString) else { throw URLError(.unsupportedURL) }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer Zpu7bOQYLNiCkT32V3c9BPoxDMfxisPAfevLW6ps", forHTTPHeaderField: "Authorization")
        
        guard let (data, response) = try? await URLSession.shared.data(for: request) else { throw URLError(.unsupportedURL) }
        
        let movies = try JSONDecoder().decode([MovieDetailsResponse].self, from: data)
        
        return movies
    }
    
    func fetchDetails(byId id: Int) async throws -> MovieResponse {
        let urlString = "https://five-ios-api.herokuapp.com/api/v1/movie/\(id)"
        guard let url = URL(string: urlString) else { throw URLError(.unsupportedURL) }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer Zpu7bOQYLNiCkT32V3c9BPoxDMfxisPAfevLW6ps", forHTTPHeaderField: "Authorization")
        
        guard let (data, response) = try? await URLSession.shared.data(for: request) else { throw URLError(.unsupportedURL) }
        
        let movie = try JSONDecoder().decode(MovieResponse.self, from: data)
        
        return movie
    }
}
