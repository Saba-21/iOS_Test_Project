import UIKit

final class CharactersListView: UIView {
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CharacterItemView.self, forCellWithReuseIdentifier: "CharacterItemView")
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(collectionView)
        addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
        spinner.startAnimating()
    }
    
    func setupList(dataSource: UICollectionViewDataSource, delegate:UICollectionViewDelegate){
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
    }
    
    func onDataLoaded(){
        DispatchQueue.main.async(execute: {
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
            self.collectionView.isHidden = false
            self.collectionView.reloadData()
        })
    }
    
    func onDataFailedToLoad(){
        DispatchQueue.main.async(execute: {
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
            self.collectionView.isHidden = false
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
}
