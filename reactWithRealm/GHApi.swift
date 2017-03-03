//
//  GHApi.swift
//  reactWithRealm
//
//  Created by Nikita Rodin on 3/3/17.
//  Copyright © 2017 Nikita Rodin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxRealm
import RealmSwift
import SwiftyJSON

class GithubService {

    static let baseURL = "https://api.github.com"
    
    class func searchRepositories(_ queryStream: Observable<String>) -> Disposable {
        return queryStream.flatMapLatest { query in
            return URLSession.shared.rx.json(url: searchURL(query))
        }
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .map { JSON($0) }
            .map( {json -> [Repo] in
                let items = json["items"].arrayValue
                return items.map {Repo(value: $0.object)}
            })
            .subscribe(onNext: { repos in
                let realm = try? Realm()
                try? realm?.write {
                    realm?.add(repos, update: true)
                }
            })
    }

    /// provide factory method for urls to GitHub's search API
    fileprivate class func searchURL(_ query: String) -> URL {
        return URL(string: "\(baseURL)/search/repositories?q=\(query.percentEscaped)+language:Swift+in:name")!
    }
    
    fileprivate class func parseJSON(_ json: Observable<Any>) -> Observable<JSON> {
        return json.observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .map { JSON($0) }
    }
    
}

