//
//  HomeViewController.swift
//  NetflixClone
//
//  Created by Jun Hyeok Kim on 2023/05/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private let homeFeedTable : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self
                       , forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        configureNavbar()
        
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = headerView
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    // MARK: - Configure
    
    private func configureNavbar() {
        var image = UIImage(named: "Netflix2")
        image = image?.withRenderingMode(.alwaysOriginal)
        
        let navbarSize = CGSize(width: 50, height: 30)
        UIGraphicsBeginImageContextWithOptions(navbarSize, false, 0.0)
        image?.draw(in: CGRect(origin: .zero, size: navbarSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(.alwaysOriginal)
        UIGraphicsEndImageContext()
        
        let barButtonItem = UIBarButtonItem(image: resizedImage, style: .done, target: self, action: nil)
        navigationItem.leftBarButtonItem = barButtonItem
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil),
        ]
        
        navigationController?.navigationBar.tintColor = .white
    }

    
    
    
}


extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0,-offset))
    }
    
}