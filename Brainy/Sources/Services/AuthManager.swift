import Foundation

enum AuthError: Error {
    case userNotFound
    case wrongPassword
    case emailAlreadyExists

    var message: String {
        switch self {
        case .userNotFound:       return "No account found with this email."
        case .wrongPassword:      return "Incorrect password."
        case .emailAlreadyExists: return "An account with this email already exists."
        }
    }
}

final class AuthManager {
    static let shared = AuthManager()
    private init() {}

    private let defaults = UserDefaults.standard
    private let usersKey = "brainy_users"
    private let passwordsKey = "brainy_passwords"
    private let currentUserIdKey = "brainy_current_user_id"

    var currentUser: User? {
        guard let id = defaults.string(forKey: currentUserIdKey) else { return nil }
        return allUsers.first { $0.id == id }
    }

    var isLoggedIn: Bool { currentUser != nil }

    func register(name: String, email: String, password: String) -> Result<User, AuthError> {
        let normalizedEmail = email.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard !allUsers.contains(where: { $0.email == normalizedEmail }) else {
            return .failure(.emailAlreadyExists)
        }
        let username = "@" + name.lowercased().replacingOccurrences(of: " ", with: "_")
        let user = User(id: UUID().uuidString, name: name, email: normalizedEmail, username: username)
        var users = allUsers
        users.append(user)
        saveUsers(users)
        savePassword(password, forEmail: normalizedEmail)
        defaults.set(user.id, forKey: currentUserIdKey)
        return .success(user)
    }

    func login(email: String, password: String) -> Result<User, AuthError> {
        let normalizedEmail = email.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard let user = allUsers.first(where: { $0.email == normalizedEmail }) else {
            return .failure(.userNotFound)
        }
        guard storedPasswords[normalizedEmail] == password else {
            return .failure(.wrongPassword)
        }
        defaults.set(user.id, forKey: currentUserIdKey)
        return .success(user)
    }

    func logout() {
        defaults.removeObject(forKey: currentUserIdKey)
    }

    func updatePassword(_ newPassword: String) {
        guard let user = currentUser else { return }
        savePassword(newPassword, forEmail: user.email)
    }

    func updateUser(name: String, username: String) {
        guard let current = currentUser else { return }
        var users = allUsers
        guard let idx = users.firstIndex(where: { $0.id == current.id }) else { return }
        users[idx].name = name
        users[idx].username = username
        saveUsers(users)
    }
}

private extension AuthManager {

    var allUsers: [User] {
        guard
            let data = defaults.data(forKey: usersKey),
            let users = try? JSONDecoder().decode([User].self, from: data)
        else { return [] }
        return users
    }

    var storedPasswords: [String: String] {
        defaults.dictionary(forKey: passwordsKey) as? [String: String] ?? [:]
    }

    func saveUsers(_ users: [User]) {
        if let data = try? JSONEncoder().encode(users) {
            defaults.set(data, forKey: usersKey)
        }
    }

    func savePassword(_ password: String, forEmail email: String) {
        var pwds = storedPasswords
        pwds[email] = password
        defaults.set(pwds, forKey: passwordsKey)
    }
}
