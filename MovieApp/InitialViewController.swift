import UIKit

class InitialViewController: UITabBarController{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let movieList = MovieCategoryViewController()
        let favorites = FavoritesViewController()
        
        movieList.title = "Movie List"
        
        let tabBarController = UITabBarController()
        
        movieList.tabBarItem = UITabBarItem(
            title: "Movie List",
            image: UIImage(systemName: "house"),
            selectedImage: nil)
        
        favorites.tabBarItem = UITabBarItem(
            title: "Favorites",
            image: UIImage(systemName: "house"),
            selectedImage: nil)
        
        tabBarController.viewControllers = [movieList, favorites]
        
        addChild(tabBarController)
        tabBarController.view.frame = view.bounds
        view.addSubview(tabBarController.view)
        tabBarController.didMove(toParent: self)
        
        tabBarController.selectedIndex = 0

    }
}


