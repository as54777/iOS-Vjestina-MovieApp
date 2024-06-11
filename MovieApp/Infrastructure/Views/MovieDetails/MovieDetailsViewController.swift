import UIKit
import PureLayout

class MovieDetailsViewController: UIViewController {
    
    private var viewModel: MovieDetailsViewModel?
    var movieId: Int?
    
    let RatingLabel = UILabel()
    let Userscore = UILabel()
    let MovieNameLabel = UILabel()
    let YearLabel = UILabel()
    let DateLabel = UILabel()
    let MovieDurationLabel = UILabel()
    let CategoryLabel = UILabel()
    let OverviewLabel = UILabel()
    let MovieSummaryLabel = UILabel()
    
    let ScreenView1 = UIView()
    let ScreenView2 = UIView()
    
    let stackView = UIStackView()
    
    let movieImageView = UIImageView()
    
    var allMembers: [String] = []
    var allRoles: [String] = []
    
    let MemberLabel1 = UILabel()
    let MemberLabel2 = UILabel()
    let MemberLabel3 = UILabel()
    let MemberLabel4 = UILabel()
    let MemberLabel5 = UILabel()
    let MemberLabel6 = UILabel()
    let Role1 = UILabel()
    let Role2 = UILabel()
    let Role3 = UILabel()
    let Role4 = UILabel()
    let Role5 = UILabel()
    let Role6 = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let movieId = movieId else {
            fatalError("Movie ID is required")
        }
        
        viewModel = MovieDetailsViewModel(movieId: movieId)
        
        createHierarchy()
        styleViews()
        defineLayout()
        
        bindViewModel()
        
        viewModel?.fetchMovieDetails()
        
        updateViewWithDetails()
        
        animate()
        
        let movieCategory = MovieCategoryViewController()
        movieCategory.navigationItem.title = "Movie List"
        
    }
    
    func createHierarchy() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(ScreenView1)
        stackView.addArrangedSubview(ScreenView2)
        ScreenView1.addSubview(movieImageView)
        ScreenView1.addSubview(RatingLabel)
        ScreenView1.addSubview(Userscore)
        ScreenView1.addSubview(MovieNameLabel)
        ScreenView1.addSubview(YearLabel)
        ScreenView1.addSubview(DateLabel)
        ScreenView1.addSubview(CategoryLabel)
        ScreenView1.addSubview(MovieDurationLabel)
        ScreenView2.addSubview(OverviewLabel)
        ScreenView2.addSubview(MovieSummaryLabel)
        ScreenView2.addSubview(MemberLabel1)
        ScreenView2.addSubview(MemberLabel2)
        ScreenView2.addSubview(MemberLabel3)
        ScreenView2.addSubview(Role1)
        ScreenView2.addSubview(Role2)
        ScreenView2.addSubview(Role3)
        ScreenView2.addSubview(MemberLabel4)
        ScreenView2.addSubview(MemberLabel5)
        ScreenView2.addSubview(Role4)
        ScreenView2.addSubview(Role5)
        ScreenView2.addSubview(MemberLabel6)
        ScreenView2.addSubview(Role6)
    }
    
    func styleViews() {
        view.backgroundColor = .white
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.clipsToBounds = true
        
        RatingLabel.textColor = .white
        RatingLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        Userscore.text = "User Score"
        Userscore.textColor = .white
        
        MovieNameLabel.textColor = .white
        MovieNameLabel.font = UIFont.boldSystemFont(ofSize: 22)
        
        YearLabel.textColor = .white
        
        DateLabel.textColor = .white
        
        CategoryLabel.text = "Drama"
        CategoryLabel.textColor = .white
        
        MovieDurationLabel.textColor = .white
        MovieDurationLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        OverviewLabel.text = "Overview"
        OverviewLabel.textColor = .black
        OverviewLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        MovieSummaryLabel.textColor = .black
        MovieSummaryLabel.numberOfLines = 0
        MovieSummaryLabel.lineBreakMode = .byWordWrapping
        
        let labels = [MemberLabel1, MemberLabel2, MemberLabel3, MemberLabel4, MemberLabel5, MemberLabel6]
        let roles = [Role1, Role2, Role3, Role4, Role5, Role6]
        
        for label in labels {
            label.textColor = .black
            label.font = UIFont.boldSystemFont(ofSize: 14)
        }
        
        for role in roles {
            role.textColor = .black
            role.font = UIFont.systemFont(ofSize: 14)
        }
    }
    
    func defineLayout() {
        stackView.autoPinEdgesToSuperviewEdges()
        movieImageView.autoPinEdgesToSuperviewSafeArea()
        
        RatingLabel.autoPinEdge(.top, to: .top, of: ScreenView1, withOffset: 100)
        RatingLabel.autoPinEdge(.leading, to: .leading, of: ScreenView1, withOffset: 30)
        
        Userscore.autoPinEdge(.top, to: .bottom, of: RatingLabel, withOffset: -23)
        Userscore.autoPinEdge(.leading, to: .trailing, of: RatingLabel, withOffset: 5)
        Userscore.autoPinEdge(toSuperviewEdge: .trailing, withInset: 5, relation: .greaterThanOrEqual)
        
        MovieNameLabel.autoPinEdge(.top, to: .bottom, of: Userscore, withOffset: 10)
        MovieNameLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 30)
        
        YearLabel.autoPinEdge(.top, to: .top, of: MovieNameLabel, withOffset: 3)
        YearLabel.autoPinEdge(.leading, to: .trailing, of: MovieNameLabel, withOffset: 5)
        YearLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 5)
        
        DateLabel.autoPinEdge(.top, to: .bottom, of: MovieNameLabel, withOffset: 50)
        DateLabel.autoPinEdge(.leading, to: .leading, of: ScreenView1, withOffset: 30)
        DateLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 30)
        
        CategoryLabel.autoPinEdge(.top, to: .bottom, of: DateLabel, withOffset: 10)
        CategoryLabel.autoPinEdge(.leading, to: .leading, of: view, withOffset: 30)
        
        MovieDurationLabel.autoPinEdge(.top, to: .bottom, of: CategoryLabel, withOffset: -20)
        MovieDurationLabel.autoPinEdge(.leading, to: .trailing, of: CategoryLabel, withOffset: 10)
        
        OverviewLabel.autoPinEdge(.top, to: .bottom, of: movieImageView, withOffset: 20)
        OverviewLabel.autoPinEdge(.leading, to: .leading, of: view, withOffset: 30)
        
        MovieSummaryLabel.autoPinEdge(.top, to: .bottom, of: OverviewLabel, withOffset: 10)
        MovieSummaryLabel.autoPinEdge(.leading, to: .leading, of: view, withOffset: 30)
        MovieSummaryLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 30)
        
        MemberLabel1.autoPinEdge(.top, to: .bottom, of: MovieSummaryLabel, withOffset: 20)
        MemberLabel1.autoPinEdge(.leading, to: .leading, of: view, withOffset: 30)
        
        MemberLabel2.autoPinEdge(.top, to: .top, of: MemberLabel1)
        MemberLabel2.autoPinEdge(.leading, to: .trailing, of: MemberLabel1, withOffset: 20)
        
        MemberLabel3.autoPinEdge(.top, to: .top, of: MemberLabel2)
        MemberLabel3.autoPinEdge(.leading, to: .trailing, of: MemberLabel2, withOffset: 20)
        
        Role1.autoPinEdge(.top, to: .bottom, of: MemberLabel1, withOffset: 10)
        Role1.autoPinEdge(.leading, to: .leading, of: MemberLabel1)
        
        Role2.autoPinEdge(.top, to: .bottom, of: MemberLabel2, withOffset: 10)
        Role2.autoPinEdge(.leading, to: .leading, of: MemberLabel2)
        
        Role3.autoPinEdge(.top, to: .bottom, of: MemberLabel3, withOffset: 10)
        Role3.autoPinEdge(.leading, to: .leading, of: MemberLabel3)
        
        MemberLabel4.autoPinEdge(.top, to: .bottom, of: Role1, withOffset: 20)
        MemberLabel4.autoPinEdge(.leading, to: .leading, of: Role1)
        
        MemberLabel5.autoPinEdge(.top, to: .top, of: MemberLabel4)
        MemberLabel5.autoPinEdge(.leading, to: .trailing, of: MemberLabel4, withOffset: 20)
        
        MemberLabel6.autoPinEdge(.top, to: .top, of: MemberLabel5)
        MemberLabel6.autoPinEdge(.leading, to: .trailing, of: MemberLabel5, withOffset: 20)
        
        Role4.autoPinEdge(.top, to: .bottom, of: MemberLabel4, withOffset: 10)
        Role4.autoPinEdge(.leading, to: .leading, of: MemberLabel4)
        
        Role5.autoPinEdge(.top, to: .bottom, of: MemberLabel5, withOffset: 10)
        Role5.autoPinEdge(.leading, to: .leading, of: MemberLabel5)
        
        Role6.autoPinEdge(.top, to: .bottom, of: MemberLabel6, withOffset: 10)
        Role6.autoPinEdge(.leading, to: .leading, of: MemberLabel6)
    }
    
    func bindViewModel() {
        viewModel?.onUpdateMovieDetails = { [weak self] in
            self?.updateViewWithDetails()
        }
    }
    
    func updateViewWithDetails() {
        guard let movieDetails = viewModel?.movieDetails else { return }
        
        MovieNameLabel.text = movieDetails.name
        
        YearLabel.text = "(\(String(movieDetails.year)))"
        
        let releaseDate = movieDetails.releaseDate
        let dateComponents = releaseDate.split(separator: "-")
        DateLabel.text = "\(dateComponents[1])/\(dateComponents[2])/\(dateComponents[0])(US)"
    
        let duration = movieDetails.duration
        let hours = duration / 60
        let minutes = duration % 60
        MovieDurationLabel.text = "\(hours)h \(minutes)m"
        
        MovieSummaryLabel.text = movieDetails.summary
        
        let crewMembers = movieDetails.crewMembers
        for member in crewMembers {
            allMembers.append(member.name)
            allRoles.append(member.role)
        }
        
        if allMembers.count > 0 { MemberLabel1.text = allMembers[0] }
        if allMembers.count > 1 { MemberLabel2.text = allMembers[1] }
        if allMembers.count > 2 { MemberLabel3.text = allMembers[2] }
        if allMembers.count > 3 { MemberLabel4.text = allMembers[3] }
        if allMembers.count > 4 { MemberLabel5.text = allMembers[4] }
        if allMembers.count > 5 { MemberLabel6.text = allMembers[5] }
        
        if allRoles.count > 0 { Role1.text = allRoles[0] }
        if allRoles.count > 1 { Role2.text = allRoles[1] }
        if allRoles.count > 2 { Role3.text = allRoles[2] }
        if allRoles.count > 3 { Role4.text = allRoles[3] }
        if allRoles.count > 4 { Role5.text = allRoles[4] }
        if allRoles.count > 5 { Role6.text = allRoles[5] }
        
        let urlString = movieDetails.imageUrl
        if let url = URL(string: urlString) {
            let data = try? Data(contentsOf: url)
            if let data = data {
                DispatchQueue.main.async {
                    self.movieImageView.image = UIImage(data: data)
                }
            }
        }
    }
    
    func animate() {
        let translationX = -view.bounds.width
        RatingLabel.transform = CGAffineTransform(translationX: translationX, y: 0)
        Userscore.transform = CGAffineTransform(translationX: translationX, y: 0)
        MovieNameLabel.transform = CGAffineTransform(translationX: translationX, y: 0)
        YearLabel.transform = CGAffineTransform(translationX: translationX, y: 0)
        DateLabel.transform = CGAffineTransform(translationX: translationX, y: 0)
        CategoryLabel.transform = CGAffineTransform(translationX: translationX, y: 0)
        MovieDurationLabel.transform = CGAffineTransform(translationX: translationX, y: 0)
        MovieSummaryLabel.transform = CGAffineTransform(translationX: translationX, y: 0)
        
        RatingLabel.alpha = 0
        Userscore.alpha = 0
        MovieNameLabel.alpha = 0
        YearLabel.alpha = 0
        DateLabel.alpha = 0
        CategoryLabel.alpha = 0
        MovieDurationLabel.alpha = 0
        MovieSummaryLabel.alpha = 0
        
        UIView.animate(
            withDuration: 0.2,
            animations: {
                self.RatingLabel.transform = .identity
                self.RatingLabel.alpha = 1
                self.Userscore.transform = .identity
                self.Userscore.alpha = 1
                self.MovieNameLabel.transform = .identity
                self.MovieNameLabel.alpha = 1
                self.YearLabel.transform = .identity
                self.YearLabel.alpha = 1
                self.DateLabel.transform = .identity
                self.DateLabel.alpha = 1
                self.CategoryLabel.transform = .identity
                self.CategoryLabel.alpha = 1
                self.MovieDurationLabel.transform = .identity
                self.MovieDurationLabel.alpha = 1
                self.MovieSummaryLabel.transform = .identity
                self.MovieSummaryLabel.alpha = 1
            }
        )
        
        self.MemberLabel1.transform = .identity
        self.MemberLabel1.alpha = 0
        self.MemberLabel2.transform = .identity
        self.MemberLabel2.alpha = 0
        self.MemberLabel3.transform = .identity
        self.MemberLabel3.alpha = 0
        self.MemberLabel4.transform = .identity
        self.MemberLabel4.alpha = 0
        self.MemberLabel5.transform = .identity
        self.MemberLabel5.alpha = 0
        self.MemberLabel6.transform = .identity
        self.MemberLabel6.alpha = 0
        self.Role1.transform = .identity
        self.Role1.alpha = 0
        self.Role2.transform = .identity
        self.Role2.alpha = 0
        self.Role3.transform = .identity
        self.Role3.alpha = 0
        self.Role4.transform = .identity
        self.Role4.alpha = 0
        self.Role5.transform = .identity
        self.Role5.alpha = 0
        self.Role6.transform = .identity
        self.Role6.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseIn, animations: {
            
            self.MemberLabel1.alpha = 1
            self.MemberLabel2.alpha = 1
            self.MemberLabel3.alpha = 1
            self.MemberLabel4.alpha = 1
            self.MemberLabel5.alpha = 1
            self.MemberLabel6.alpha = 1
            
            self.Role1.alpha = 1
            self.Role2.alpha = 1
            self.Role3.alpha = 1
            self.Role4.alpha = 1
            self.Role5.alpha = 1
            self.Role6.alpha = 1
       }, completion: nil)
    }
}
