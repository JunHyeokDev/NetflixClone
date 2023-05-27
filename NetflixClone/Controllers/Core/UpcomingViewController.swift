    //
//  UpcomingViewController.swift
//  NetflixClone
//
//  Created by Jun Hyeok Kim on 2023/05/24.
//

import UIKit

class UpcomingViewController: UIViewController {

    // MARK: - Properties
    
    private var titles : [Title] = [Title]()
    
    private let upcomingTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
                
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground        // Do any additional setup after loading the view.
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(upcomingTable)
        upcomingTable.delegate = self
        upcomingTable.dataSource = self
        fetchUpcoming()

    }
    

    
    override func viewDidLayoutSubviews() {
        //        upcomingTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        //        upcomingTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        //        upcomingTable.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 3).isActive = true
        //        upcomingTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // That also works, but... hmm!
        
        super.viewDidLayoutSubviews()
        upcomingTable.frame = view.bounds
        print(view.frame)
    }
    
    private func fetchUpcoming() {
        APICaller.shared.getUpcomingMovies { [weak self] result in
            switch result {
            case.success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.upcomingTable.reloadData()
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}

extension UpcomingViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else { return UITableViewCell() }
        
        guard let title = titles[indexPath.row].original_title, let url = titles[indexPath.row].poster_path else { return UITableViewCell() }
        
        cell.configure(with: TitleViewModel(titleName: title, posterURL: url))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
        
    }
}

