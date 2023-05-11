import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }

    func setupTabs(){
        let charactersScreen = CharactersViewController()
        let favoritesScreen = FavoritesViewController()
        
        charactersScreen.navigationItem.largeTitleDisplayMode = .automatic
        favoritesScreen.navigationItem.largeTitleDisplayMode = .automatic
        
        charactersScreen.title = "Characters"
        favoritesScreen.title = "Favorites"
        
        let charactersNavigation = UINavigationController(rootViewController: charactersScreen)
        let favoritesNavigation = UINavigationController(rootViewController: favoritesScreen)

        charactersNavigation.navigationBar.prefersLargeTitles = true
        favoritesNavigation.navigationBar.prefersLargeTitles = true
        
        charactersNavigation.tabBarItem = UITabBarItem(title:"Characters", image: UIImage(systemName: "globe"), tag: 1)
        favoritesNavigation.tabBarItem = UITabBarItem(title:"Favorites", image: UIImage(systemName: "person"), tag: 1)
        
        setViewControllers([charactersNavigation, favoritesNavigation], animated: true)
    }
    
}

