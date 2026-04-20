import Foundation

enum QuizThemedQuestionProvider {

    /// Returns a fixed-length window from the category pool so different quiz titles get different subsets.
    static func questions(forCategory category: String, quizTitle: String, count: Int = 10) -> [QuizQuestion] {
        let normalized = category.trimmingCharacters(in: .whitespacesAndNewlines)
        let pool = pool(forCategory: normalized)
        guard pool.count >= count else {
            if pool.isEmpty {
                return Array(QuizQuestion.sampleQuestions.prefix(count))
            }
            return padPool(pool, targetCount: count)
        }
        let maxStart = pool.count - count
        let start = stableFingerprint("\(normalized)|\(quizTitle)") % (maxStart + 1)
        return Array(pool[start ..< (start + count)])
    }

    private static func pool(forCategory category: String) -> [QuizQuestion] {
        switch category.lowercased() {
        case "geography": return ThemedQuizPools.geography
        case "history": return ThemedQuizPools.history
        case "science": return ThemedQuizPools.science
        case "movies": return ThemedQuizPools.movies
        case "music": return ThemedQuizPools.music
        case "sports": return ThemedQuizPools.sports
        case "it": return ThemedQuizPools.it
        case "languages": return ThemedQuizPools.languages
        default: return []
        }
    }

    private static func padPool(_ pool: [QuizQuestion], targetCount: Int) -> [QuizQuestion] {
        guard !pool.isEmpty else { return [] }
        var result: [QuizQuestion] = []
        result.reserveCapacity(targetCount)
        var i = 0
        while result.count < targetCount {
            result.append(pool[i % pool.count])
            i += 1
        }
        return result
    }

    private static func stableFingerprint(_ string: String) -> Int {
        var hash = 5381
        for byte in string.utf8 {
            hash = ((hash &<< 5) &+ hash) &+ Int(byte)
        }
        if hash == Int.min { return 0 }
        return abs(hash)
    }
}
