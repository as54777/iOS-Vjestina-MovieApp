import UIKit
import MovieAppData

class ItemTableViewCell: UITableViewCell {
    
    var navigationController: UINavigationController?
    
    let containerView = UIView()
    let movieImageView = UIImageView()
    let titleLabel = UILabel()
    let yearLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 8
        containerView.layer.masksToBounds = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 4
        
        contentView.addSubview(containerView)
        containerView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        
        containerView.addSubview(movieImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)

        movieImageView.autoPinEdge(.top, to: .top, of: containerView, withOffset: 5)
        movieImageView.autoPinEdge(.leading, to: .leading, of: containerView, withOffset: 5)
        movieImageView.autoSetDimensions(to: CGSize(width: 100, height: 180))
        
        titleLabel.autoPinEdge(.top, to: .top, of: containerView, withOffset: 2)
        titleLabel.autoPinEdge(.leading, to: .trailing, of: movieImageView, withOffset: 10)
        titleLabel.autoPinEdge(.trailing, to: .trailing, of: containerView, withOffset: -10)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
//        yearLabel.autoPinEdge(.top, to: .top, of: titleLabel)
//        yearLabel.autoPinEdge(.leading, to: .trailing, of: titleLabel, withOffset: 10)
//        yearLabel.autoPinEdge(.trailing, to: .trailing, of: containerView, withOffset: -10)
//        yearLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        descriptionLabel.autoPinEdge(.leading, to: .trailing, of: movieImageView, withOffset: 10)
        descriptionLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 10)
        descriptionLabel.autoPinEdge(.trailing, to: .trailing, of: containerView, withOffset: -10)
    }


        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MovieListViewController: UIViewController {
        
    var movieUseCase = MovieUseCase()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieUseCase = MovieUseCase()
        
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: "MovieCell")
        
        view.addSubview(tableView)
        tableView.autoPinEdgesToSuperviewEdges()
        
        navigationController?.viewControllers = [self]
    }
}

extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieUseCase.allMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? ItemTableViewCell else {
            fatalError("Failed to dequeue a reusable cell.")
        }

        let movie = movieUseCase.allMovies[indexPath.row]
        
        cell.navigationController = self.navigationController
        
        cell.titleLabel.text = movie.name
        cell.titleLabel.numberOfLines = 0
        cell.titleLabel.lineBreakMode = .byWordWrapping
        if let movieDetails = MovieUseCase().getDetails(id: movie.id) {
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
        let movieId = movieUseCase.allMovies[indexPath.row].id
        let movieDetails = MovieDetailsViewController()
        movieDetails.movieId = movieId
        movieDetails.navigationItem.title = "Movie Details"
        navigationController?.pushViewController(movieDetails, animated: true)
    }
}
