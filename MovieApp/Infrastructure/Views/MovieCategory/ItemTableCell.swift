import UIKit
import PureLayout

class ItemTableCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let collectionView: UICollectionView
    var navigationController: UINavigationController?
    var movies: [MovieService.MovieResponse] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
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
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionCell", for: indexPath) as? MovieCollectionCell else {
            fatalError("Failed to dequeue MovieCollectionCell.")
        }
        
        let movie = movies[indexPath.item]
        
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
        let movieId = movies[indexPath.item].id
        
        let movieDetails = MovieDetailsViewController()
        movieDetails.movieId = movieId
        movieDetails.navigationItem.title = "Movie Details"
        navigationController?.pushViewController(movieDetails, animated: true)
    }
}
