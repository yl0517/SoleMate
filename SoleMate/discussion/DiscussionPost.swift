import Foundation

struct DiscussionPost: Identifiable, Codable {
    var id: String
    var userId: String
    var message: String
    var timestamp: Double
}
