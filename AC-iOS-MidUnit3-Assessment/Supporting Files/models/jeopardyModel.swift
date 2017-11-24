import Foundation

struct Questions: Codable {
    var question: String?
    var answer: String?
    var value: Int?
    var category: Category
}

struct Category: Codable {
    var title: String?
}


