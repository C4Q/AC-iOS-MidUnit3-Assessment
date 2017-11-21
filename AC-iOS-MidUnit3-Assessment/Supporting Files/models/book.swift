import Foundation
struct allBooks: Codable {
    var kind: String
    var items: [Items]
}
struct Items: Codable {
    var volumeInfo: VolumeInfo
    var saleInfo: SaleInfo
}
struct VolumeInfo: Codable {
    var title: String
    var subTitle: String?
    var author: [String]?
    var category: [String]?
    var description: String?
    var image: ImageLinks?
}
struct ImageLinks: Codable {
    var smallThumbnail: String?
}
struct SaleInfo: Codable {
    var retailPrice: RetailPrice
}
struct RetailPrice: Codable {
    var amount: Double
}
