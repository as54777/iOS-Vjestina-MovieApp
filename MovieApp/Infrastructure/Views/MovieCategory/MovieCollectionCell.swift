import UIKit
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
