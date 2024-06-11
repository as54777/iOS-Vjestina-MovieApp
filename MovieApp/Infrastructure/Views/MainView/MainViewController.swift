import UIKit

class MainViewController: UITabBarController, UITabBarControllerDelegate {
    
    private var router: AppRouterProtocol
    
    init(router: AppRouterProtocol) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        let movieList = MovieCategoryViewController()
        let favorites = FavoritesViewController()
        
        movieList.navigationItem.title = "Movie List"
        
        movieList.title = "Movie List"
        favorites.title = "Favorites"
        
        movieList.tabBarItem = UITabBarItem(
            title: "Movie List",
            image: UIImage(systemName: "house"),
            selectedImage: nil)
        
        favorites.tabBarItem = UITabBarItem(
            title: "Favorites",
            image: UIImage(systemName: "heart"),
            selectedImage: nil)
                
        viewControllers = [movieList, favorites]
    }
}
