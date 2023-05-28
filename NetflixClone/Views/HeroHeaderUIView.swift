//
//  HeroHeaderUIView.swift
//  NetflixClone
//
//  Created by Jun Hyeok Kim on 2023/05/25.
//

import UIKit

class HeroHeaderUIView : UIView {
    // MARK: - Properties
    private let downloadButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Download", for: .normal)
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.borderWidth = 1
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    private let playButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Play", for: .normal)
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.borderWidth = 1
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let heroImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "Dune")
        return imageView
    }()
    
    // MARK: - lifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradient() // Putting Gradient 'When' and 'where' matters !

        addSubview(playButton)
        addSubview(downloadButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
        constraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    public func configure(with model : TitleViewModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else { return }
        
        heroImageView.sd_setImage(with: url,completed: nil)
    }

    
    // MARK: - Constraints
    
    private func constraints() {
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -60),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            playButton.widthAnchor.constraint(equalToConstant: 100),
            
        ])
        
        NSLayoutConstraint.activate([
            downloadButton.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 30),
            downloadButton.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),
            downloadButton.widthAnchor.constraint(equalToConstant: 100),
        ])
    }

    // MARK: - gradient
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }

    
}
