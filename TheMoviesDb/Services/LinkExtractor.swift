//
//  LinkExtractor.swift
//  TheMoviesDb
//
//  Created by Jennifer Ruiz on 26/06/21.
//

import Foundation
import YoutubeDirectLinkExtractor

final class LinkExtractor {

    // MARK: - Properties

    private let youtubeDirectLinkExtractor = YoutubeDirectLinkExtractor()

    // MARK: - Methods

    func getUrlFromKey(key: String?, completion: @escaping (URL) -> Void) {
        guard let key = key else {
            return
        }
        let urlSting = "https://www.youtube.com/watch?v=\(key)"
        youtubeDirectLinkExtractor.extractInfo(for: .urlString(urlSting),
                        success: { (info) in
                            guard let link = info.highestQualityPlayableLink else {
                                return
                            }
                            guard let url = URL(string: link) else {
                                return
                            }
                            DispatchQueue.main.async {
                                completion(url)
                            }
        }) { (error) in
            print(error)
        }
    }
}
