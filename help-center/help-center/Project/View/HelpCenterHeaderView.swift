import UIKit

class HelpCenterHeaderView: UICollectionReusableView {
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "image_home")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let gradientOverlayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Central de ajuda"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .blue
        return label
    }()
    
    private let greetingLabel: UILabel = {
        let label = UILabel()
        label.text = "Olá, Diego 👋"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Como podemos ajudar?"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(backgroundImageView)
        addSubview(gradientOverlayView)
        addSubview(titleLabel)
        
        gradientOverlayView.addSubview(greetingLabel)
        gradientOverlayView.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            gradientOverlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            gradientOverlayView.trailingAnchor.constraint(equalTo: trailingAnchor),
            gradientOverlayView.bottomAnchor.constraint(equalTo: bottomAnchor),
            gradientOverlayView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            
            greetingLabel.leadingAnchor.constraint(equalTo: gradientOverlayView.leadingAnchor, constant: 16),
            greetingLabel.trailingAnchor.constraint(equalTo: gradientOverlayView.trailingAnchor, constant: -16),
            greetingLabel.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -4),
            
            messageLabel.leadingAnchor.constraint(equalTo: gradientOverlayView.leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: gradientOverlayView.trailingAnchor, constant: -16),
            messageLabel.bottomAnchor.constraint(equalTo: gradientOverlayView.bottomAnchor, constant: -8)
        ])
        
        applyGradient()
    }
    
    private func applyGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.blue.withAlphaComponent(0.7).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = gradientOverlayView.bounds
        gradientOverlayView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let gradientLayer = gradientOverlayView.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = gradientOverlayView.bounds
        }
    }
}
