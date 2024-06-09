import UIKit

class MovieCategoryViewController: UIViewController {
    
    var viewModel = MovieCategoryViewModel()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Movie List"
        
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemTableCell.self, forCellReuseIdentifier: "MovieCell")
        view.addSubview(tableView)
        
        bindViewModel()
        
        viewModel.fetchAllMovies()
    }
    
    private func bindViewModel() {
        viewModel.onUpdatePopularMovies = { [weak self] in
            self?.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
        
        viewModel.onUpdateFreeToWatchMovies = { [weak self] in
            self?.tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
        }
        
        viewModel.onUpdateTrendingMovies = { [weak self] in
            self?.tableView.reloadSections(IndexSet(integer: 2), with: .automatic)
        }
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
        
        switch indexPath.section {
        case 0:
            cell.movies = viewModel.popularMovies
        case 1:
            cell.movies = viewModel.freeToWatchMovies
        case 2:
            cell.movies = viewModel.trendingMovies
        default:
            break
        }
        
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
