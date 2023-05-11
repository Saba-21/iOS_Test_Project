import UIKit

final class CharacterItemView: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .label
        nameLabel.numberOfLines = 2
        nameLabel.font = .systemFont(ofSize: 18, weight: .medium)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    private let statusLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .secondaryLabel
        nameLabel.font = .systemFont(ofSize: 16, weight: .regular)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(statusLabel)
        addConstraints()
        contentView.layer.cornerRadius = 16
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 16),
            nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 16),

            statusLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 16),
            statusLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 16),
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            statusLabel.bottomAnchor.constraint(equalTo: bottomAnchor),

        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
    }
    
    public func configureCell(index: Int, viewModel: CharactersViewModel){
        let data = viewModel.getCharacterData(index: index)
        
        nameLabel.text = data.name
        statusLabel.text = "Status: \(data.status)"
        
        viewModel.fetchImage(imageUrl: data.image) { [weak self] result in
            switch result {
            case .success(let data):
                self?.onImageDownloaded(data: data)
            case .failure:
                self?.onImageDownloaded(data: nil)
            }
        }
    }
    
    private func onImageDownloaded(data: Data?){
        DispatchQueue.main.async {
            guard let imageData = data else {
                return
            }
            let image = UIImage(data: imageData)
            self.imageView.image = image
        }
    }

}
