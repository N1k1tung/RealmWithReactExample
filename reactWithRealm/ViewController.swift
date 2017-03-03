//
//  ViewController.swift
//  reactWithRealm
//
//  Created by Nikita Rodin on 3/3/17.
//  Copyright © 2017 Nikita Rodin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import RealmSwift

class ViewController: UIViewController {

    /// table view
    @IBOutlet weak var tableView: UITableView!
    
    var searchBar: UISearchBar!
    
    let disposeBag = DisposeBag()
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setSearchBarInNavigation()
        
        // throttled input (w/o optionals and atleast 3 characters length)
        let input = searchBar.rx.text.asObservable()
            .throttle(0.5, scheduler: MainScheduler.instance)
            .map { $0 ?? "" }
        let filteredInput = input.filter { $0.utf8.count > 2 }
        // update cache
        GithubService.searchRepositories(filteredInput)
            .addDisposableTo(disposeBag)
        // bind cache
        setupViewModel(input)
    }

    fileprivate func setupViewModel(_ input: Observable<String>) {
        viewModel = ViewModel(queryStream: input)
        let ds = RxTableViewSectionedAnimatedDataSource<RepoSection>()
        ds.configureCell = { ds, tableView, indexPath, item in
            let cell = tableView.getCell(indexPath, ofClass: UITableViewCell.self)
            cell.textLabel?.text = item.full_name
            return cell
        }
        viewModel.sections
            .bindTo(tableView.rx.items(dataSource: ds))
            .addDisposableTo(disposeBag)
    }
    
    fileprivate func setSearchBarInNavigation() {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width-16, height: 30))
        let searchBarItem = UIBarButtonItem(customView: searchBar)
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spaceItem.width = -8
        
        self.navigationItem.leftBarButtonItems = [spaceItem, searchBarItem]
        self.searchBar = searchBar
    }
}
