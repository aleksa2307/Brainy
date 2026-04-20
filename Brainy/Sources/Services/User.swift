import Foundation

struct User: Codable, Equatable {
    let id: String
    var name: String
    var email: String
    var username: String

    var initials: String {
        let parts = name.split(separator: " ")
        if parts.count >= 2 {
            return String(parts[0].prefix(1) + parts[1].prefix(1)).uppercased()
        }
        return String(name.prefix(2)).uppercased()
    }
}
