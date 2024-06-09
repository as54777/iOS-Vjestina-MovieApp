import UIKit

class MovieListViewController: UIViewController {
    
    let tableView = UITableView()
    let viewModel = MovieListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        navigationController?.viewControllers = [self]
    }
    
    private func setupTableView() {
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: "MovieCell")
        
        view.addSubview(tableView)
        tableView.autoPinEdgesToSuperviewEdges()
    }
}

extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.allMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? ItemTableViewCell else {
            fatalError("Failed to dequeue a reusable cell.")
        }

        let movie = viewModel.allMovies[indexPath.row]
        
        cell.titleLabel.text = movie.name
        cell.titleLabel.numberOfLines = 0
        cell.titleLabel.lineBreakMode = .byWordWrapping
        
        if let movieDetails = viewModel.getMovieDetails(at: indexPath.row) {
            cell.yearLabel.text = "\(movieDetails.year)"
        } else {
            cell.yearLabel.text = ""
        }
        
        cell.descriptionLabel.text = movie.summary
        cell.descriptionLabel.numberOfLines = 0
        cell.descriptionLabel.lineBreakMode = .byWordWrapping
        
        if let url = URL(string: movie.imageUrl) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        cell.movieImageView.image = UIImage(data: data)
                    }
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellSpacingHeight: CGFloat = 8
        let cellHeight: CGFloat = 200
        return cellHeight + cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieId = viewModel.allMovies[indexPath.row].id
        let movieDetails = MovieDetailsViewController()
        movieDetails.movieId = movieId
        movieDetails.navigationItem.title = "Movie Details"
        navigationController?.pushViewController(movieDetails, animated: true)
    }
}
