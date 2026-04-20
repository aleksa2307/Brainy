import Foundation

struct QuizRecord: Codable {
    let title: String
    let emoji: String
    let category: String
    let score: Int
    let total: Int
    let date: Date
    let timeTaken: Double

    var accuracy: Int { total > 0 ? Int(round(Double(score) / Double(total) * 100)) : 0 }
    var isPerfect: Bool { score == total && total > 0 }
}

struct InProgressQuiz: Codable {
    let title: String
    let emoji: String
    let category: String
    let categoryFilterID: String
}

struct BadgeInfo {
    let id: String
    let emoji: String
    let name: String
    let isUnlocked: Bool
}

struct UserStats: Codable {
    var totalXP: Int = 0
    var quizzesPlayed: Int = 0
    var totalCorrectAnswers: Int = 0
    var totalAnswers: Int = 0
    var totalTimeTaken: Double = 0
    var currentStreak: Int = 0
    var longestStreak: Int = 0
    var lastPlayedDate: Date?
    var recentQuizzes: [QuizRecord] = []
    var unlockedBadgeIDs: [String] = []

    var weeklyXP: Int = 0
    var weeklyQuizzesPlayed: Int = 0
    var weekStartDate: Date?

    var todayXP: Int = 0
    var todayQuizzesPlayed: Int = 0
    var hasPerfectScoreToday: Bool = false
    var todayDate: Date?

    var level: Int { max(1, totalXP / 500 + 1) }
    var xpInCurrentLevel: Int { totalXP % 500 }
    var xpToNextLevel: Int { 500 - xpInCurrentLevel }
    var levelProgress: Float { Float(xpInCurrentLevel) / 500.0 }

    var accuracyPercent: Int {
        guard totalAnswers > 0 else { return 0 }
        return Int(round(Double(totalCorrectAnswers) / Double(totalAnswers) * 100))
    }

    var avgAnswerTimeString: String {
        guard totalAnswers > 0 else { return "–" }
        let avg = totalTimeTaken / Double(totalAnswers)
        return String(format: "%.1fs", avg)
    }

    var favCategory: String {
        guard !recentQuizzes.isEmpty else { return "–" }
        let counts = Dictionary(grouping: recentQuizzes.map { $0.category }, by: { $0 }).mapValues { $0.count }
        return counts.max(by: { $0.value < $1.value })?.key ?? "–"
    }

    var formattedXP: String {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.groupingSeparator = ","
        return f.string(from: NSNumber(value: totalXP)) ?? "\(totalXP)"
    }

    var formattedXPToNext: String {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        let xp = f.string(from: NSNumber(value: xpToNextLevel)) ?? "\(xpToNextLevel)"
        return "\(xp) XP to next level"
    }
}

final class StatsManager {
    static let shared = StatsManager()
    private init() {}

    private let defaults = UserDefaults.standard
    private let statsKey = "brainy_user_stats"
    private let inProgressKey = "brainy_in_progress_quiz"

    var inProgressQuiz: InProgressQuiz? {
        get {
            guard let data = defaults.data(forKey: inProgressKey),
                  let quiz = try? JSONDecoder().decode(InProgressQuiz.self, from: data)
            else { return nil }
            return quiz
        }
        set {
            if let quiz = newValue, let data = try? JSONEncoder().encode(quiz) {
                defaults.set(data, forKey: inProgressKey)
            } else {
                defaults.removeObject(forKey: inProgressKey)
            }
        }
    }

    func markQuizStarted(_ meta: QuizMeta) {
        inProgressQuiz = InProgressQuiz(
            title: meta.title, emoji: meta.emoji,
            category: meta.category, categoryFilterID: meta.categoryFilterID
        )
    }

    func clearInProgressQuiz() {
        inProgressQuiz = nil
    }

    var stats: UserStats {
        get {
            guard
                let data = defaults.data(forKey: statsKey),
                let decoded = try? JSONDecoder().decode(UserStats.self, from: data)
            else { return UserStats() }
            return decoded
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                defaults.set(data, forKey: statsKey)
            }
        }
    }

    func recordQuiz(title: String, emoji: String, category: String,
                    score: Int, total: Int, xpEarned: Int, timeTaken: Double) {
        var s = stats
        let now = Date()
        let cal = Calendar.current

        // Daily reset
        if let td = s.todayDate, !cal.isDateInToday(td) {
            s.todayXP = 0
            s.todayQuizzesPlayed = 0
            s.hasPerfectScoreToday = false
        }
        s.todayDate = now

        // Weekly reset
        if let ws = s.weekStartDate {
            let days = cal.dateComponents([.day], from: ws, to: now).day ?? 0
            if days >= 7 { s.weeklyXP = 0; s.weeklyQuizzesPlayed = 0; s.weekStartDate = now }
        } else {
            s.weekStartDate = now
        }

        // Streak
        if let last = s.lastPlayedDate {
            if cal.isDateInToday(last) {
                // already played today — no change
            } else if cal.isDateInYesterday(last) {
                s.currentStreak += 1
            } else {
                s.currentStreak = 1
            }
        } else {
            s.currentStreak = 1
        }
        s.longestStreak = max(s.longestStreak, s.currentStreak)
        s.lastPlayedDate = now

        s.totalXP += xpEarned
        s.todayXP += xpEarned
        s.weeklyXP += xpEarned
        s.quizzesPlayed += 1
        s.todayQuizzesPlayed += 1
        s.weeklyQuizzesPlayed += 1
        s.totalCorrectAnswers += score
        s.totalAnswers += total
        s.totalTimeTaken += timeTaken
        if score == total && total > 0 { s.hasPerfectScoreToday = true }

        let record = QuizRecord(title: title, emoji: emoji, category: category,
                                score: score, total: total, date: now, timeTaken: timeTaken)
        s.recentQuizzes.insert(record, at: 0)
        if s.recentQuizzes.count > 10 { s.recentQuizzes = Array(s.recentQuizzes.prefix(10)) }

        unlockBadges(stats: &s, record: record, timeTaken: timeTaken, total: total)
        stats = s
    }

    func allBadges() -> [BadgeInfo] {
        let s = stats
        return Self.badgeDefinitions.map {
            BadgeInfo(id: $0.id, emoji: $0.emoji, name: $0.name,
                      isUnlocked: s.unlockedBadgeIDs.contains($0.id))
        }
    }

    static let badgeDefinitions: [(id: String, emoji: String, name: String)] = [
        ("explorer",      "🌍", "Explorer"),
        ("scientist",     "🔬", "Scientist"),
        ("film_buff",     "🎬", "Film Buff"),
        ("music_lover",   "🎵", "Music Lover"),
        ("speed_runner",  "⚡",  "Speed Runner"),
        ("perfect_score", "⭐", "Perfect Score"),
        ("astronaut",     "🚀", "Astronaut"),
        ("polyglot",      "🗣️", "Polyglot"),
    ]
}

private extension StatsManager {
    func unlockBadges(stats s: inout UserStats, record: QuizRecord, timeTaken: Double, total: Int) {
        var ids = Set(s.unlockedBadgeIDs)
        if s.quizzesPlayed >= 1  { ids.insert("explorer") }
        if s.quizzesPlayed >= 5  { ids.insert("scientist") }
        if s.quizzesPlayed >= 10 { ids.insert("music_lover") }
        if s.quizzesPlayed >= 20 { ids.insert("polyglot") }
        if record.isPerfect      { ids.insert("perfect_score") }
        if record.accuracy >= 80 { ids.insert("film_buff") }
        if total > 0 && timeTaken / Double(total) < 10 { ids.insert("speed_runner") }
        if s.level >= 5          { ids.insert("astronaut") }
        s.unlockedBadgeIDs = Array(ids)
    }
}
