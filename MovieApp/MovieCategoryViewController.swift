import UIKit
import MovieAppData
import PureLayout

class MovieCollectionCell: UICollectionViewCell {
    let movieImageView = UIImageView()
    var navigationController: UINavigationController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.clipsToBounds = true
        movieImageView.layer.cornerRadius = 10
        movieImageView.layer.masksToBounds = true
        contentView.addSubview(movieImageView)
        
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.autoPinEdgesToSuperviewEdges()
        movieImageView.autoMatch(.width, to: .height, of: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

class ItemTableCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let collectionView: UICollectionView
    var navigationController: UINavigationController?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 100
        layout.minimumLineSpacing = 100
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MovieCollectionCell.self, forCellWithReuseIdentifier: "MovieCollectionCell")
        collectionView.backgroundColor = .clear
        
        contentView.addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewEdges()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let movieUseCase = MovieUseCase()
        switch section {
        case 0:
            return movieUseCase.popularMovies.count
        case 1:
            return movieUseCase.freeToWatchMovies.count
        case 2:
            return movieUseCase.trendingMovies.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionCell", for: indexPath) as? MovieCollectionCell else {
            fatalError("Failed to dequeue MovieCollectionCell.")
        }
        
        cell.configure(with: self.navigationController!)
        
        let movieUseCase = MovieUseCase()
        let movie: MovieModel
        
        switch indexPath.section {
        case 0:
            movie = movieUseCase.popularMovies[indexPath.item]
        case 1:
            movie = movieUseCase.freeToWatchMovies[indexPath.item]
        case 2:
            movie = movieUseCase.trendingMovies[indexPath.item]
        default:
            fatalError("Invalid section")
        }
        
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 3
        let spacing: CGFloat = 10
        let totalSpacing = spacing * (itemsPerRow - 1)
        let width = (collectionView.frame.width - totalSpacing) / itemsPerRow
        return CGSize(width: width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieUseCase = MovieUseCase()
        let movieId: Int
        
        switch indexPath.section {
        case 0:
            movieId = movieUseCase.popularMovies[indexPath.item].id
        case 1:
            movieId = movieUseCase.freeToWatchMovies[indexPath.item].id
        case 2:
            movieId = movieUseCase.trendingMovies[indexPath.item].id
        default:
            fatalError("Invalid section")
        }
        
        let movieDetails = MovieDetailsViewController()
        movieDetails.movieId = movieId
        movieDetails.navigationItem.title = "Movie Details"
        navigationController?.pushViewController(movieDetails, animated: true)
    }
}

class MovieCategoryViewController: UIViewController {
    
    var movieUseCase = MovieUseCase()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Movie List"
        
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(ItemTableCell.self, forCellReuseIdentifier: "MovieCell")
        
        view.addSubview(tableView)
    }
}

extension MovieCategoryViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? ItemTableCell else {
            fatalError("Failed to dequeue a reusable cell.")
        }
        
        cell.navigationController = self.navigationController
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "What's popular"
        case 1:
            return "Free to watch"
        case 2:
            return "Trending"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = .blue
        }
    }
}
