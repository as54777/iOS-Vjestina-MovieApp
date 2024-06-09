import UIKit

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

