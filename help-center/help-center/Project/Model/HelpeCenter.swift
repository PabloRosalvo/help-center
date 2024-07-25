import Foundation

struct HelpeCenter: Codable {
    let header: Header
    let items: [Item]
}

struct Header: Codable {
    let image: Image
    let line1, line2: String
}

struct Image: Codable {
    let the1X, the2X, the3X: String

    enum CodingKeys: String, CodingKey {
        case the1X = "@1x"
        case the2X = "@2x"
        case the3X = "@3x"
    }
}

struct Item: Codable {
    let id: String
    let title: String
    let category: String?
    let totalArticles: Int
}
