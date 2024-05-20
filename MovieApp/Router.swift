import UIKit

protocol AppRouterProtocol {
    
    func setStartScreen(in window: UIWindow?)
    
}

class AppRouter: AppRouterProtocol {
    private let navigationController: UINavigationController!
    
    init(navigationController: UINavigationController!) {
        self.navigationController = navigationController
    }
    
    func setStartScreen(in window: UIWindow?) {
        let vc = MainViewController(router: self)
        
        navigationController.pushViewController(vc, animated: false)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
