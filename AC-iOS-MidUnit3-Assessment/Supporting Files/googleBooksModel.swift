//
//  googleBooksModel.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
import UIKit

struct BookItems: Codable {
    let items: [Book]
}

struct Book: Codable {
    let title: VolumeInfo
    let subtitle: VolumeInfo
    let authors: VolumeInfo
    let summary: VolumeInfo
    let price: SaleInfo
    let image: VolumeInfo
}

struct VolumeInfo: Codable {
    let title: String
    let subtitle: String
    let authors: [String]
    let description: String
    let imageLinks: Images
    
}

//struct Images: Codable {
//    let thumbnail: String
//}

struct SaleInfo: Codable {
    let retailPrice: Double
}

class Images: Codable {
    let thumbnail: String
    
    private(set) var thumbnailImage: UIImage? = nil
    
    private enum CodingKeys: String, CodingKey {
        case thumbnail
    }
    
    func getThumbnail(onComplete: @escaping() -> Void) {
        guard let url = URL(string: thumbnail) else { return }
        UIImage.fetchAsync(url: url) { (image: UIImage) in
            self.thumbnailImage = image
            onComplete()
        }
    }
    
}

extension UIImage {
    class func fetchAsync(url: URL, onComplete: @escaping (UIImage) -> ()) {
        DispatchQueue.global().async {
            guard let data = try? Data.init(contentsOf: url) else { return }
            if let image = UIImage(data: data) {
                onComplete(image)
            }
        }
    }
}


class ParsedJSON {
    static func getBook() -> [Book] {
        var books = [Book]()
        if let path = Bundle.main.path(forResource: "bookinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                do {
                    let bookItems = try JSONDecoder().decode(BookItems.self, from: data)
                    books = bookItems.items.sorted { $0.title.title < $1.title.title }
                }
                catch {
                    print(error)
                }
            }
        }
        return books
    }
}







