import UIKit

final class CharactersViewController: UIViewController{
    
    private let charactersView = CharactersListView()
    private let charactersViewModel = CharactersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(charactersView)
        NSLayoutConstraint.activate([
            charactersView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            charactersView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            charactersView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            charactersView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        charactersViewModel.fetch(onSuccess: {
            self.charactersView.onDataLoaded()
        }, onFailure: { error in
            self.charactersView.onDataFailedToLoad()
        })
        
        charactersView.setupList(dataSource: self, delegate: self)
        
    }
    
}

extension CharactersViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return charactersViewModel.getCharacterListCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterItemView", for: indexPath) as? CharacterItemView
        cell?.configureCell(index: indexPath.row, viewModel: charactersViewModel)
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: charactersView.bounds.width, height: 150)
    }
    
}
