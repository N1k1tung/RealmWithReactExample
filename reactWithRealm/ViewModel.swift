//
//  ViewModel.swift
//  reactWithRealm
//
//  Created by Nikita Rodin on 3/3/17.
//  Copyright © 2017 Nikita Rodin. All rights reserved.
//

import Foundation
import RealmSwift
import RxCocoa
import RxSwift
import RxDataSources

typealias RepoSection = AnimatableSectionModel<String, Repo>

class ViewModel {

    // input to query
    let queryStream: Observable<String>
    
    init(queryStream: Observable<String>) {
        self.queryStream = queryStream
    }
    
    
    /// table sections
    var sections: Observable<[RepoSection]> {
        guard let realm = try? Realm() else { return Observable.just([]) }
        
        return queryStream.flatMapLatest { query -> Observable<[RepoSection]> in
            guard query.characters.count > 2 else {
                return Observable.just([])
            }
            let repos = realm.objects(Repo.self).filter("full_name CONTAINS[c] %@", query)
            return Observable.array(from: repos)
                .map { [RepoSection(model: "", items: $0)] }
        }
    }
    
}

extension Repo: IdentifiableType {
    var identity: Int {
        return id
    }
}
