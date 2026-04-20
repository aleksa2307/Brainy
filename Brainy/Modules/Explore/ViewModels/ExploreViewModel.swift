import Foundation

final class ExploreViewModel {

    let categories: [String] = [
        "All", "History", "Science", "Movies", "Music",
        "Geography", "Sports", "IT", "Languages"
    ]

    private(set) var selectedCategoryIndex: Int = 0
    private(set) var searchQuery: String = ""

    private let allQuizzes: [ExploreQuizItem] = [
        ExploreQuizItem(
            categoryFilterID: "Geography",
            categoryLabel: "Geography",
            categoryLabelColorHex: "06b6d4",
            title: "World Capitals Mastery",
            emoji: "🌍",
            topBarGradientStartHex: "06b6d4",
            topBarGradientEndHex: "3b82f6",
            thumbnailGradientStartHex: "06b6d4",
            thumbnailGradientEndHex: "3b82f6",
            rating: "4.8",
            duration: "8 min",
            participants: "13k",
            difficulty: .medium,
            supplementaryTag: .none
        ),
        ExploreQuizItem(
            categoryFilterID: "Science",
            categoryLabel: "Science",
            categoryLabelColorHex: "22c55e",
            title: "Science Fundamentals",
            emoji: "🔬",
            topBarGradientStartHex: "22c55e",
            topBarGradientEndHex: "059669",
            thumbnailGradientStartHex: "22c55e",
            thumbnailGradientEndHex: "059669",
            rating: "4.6",
            duration: "12 min",
            participants: "9k",
            difficulty: .hard,
            supplementaryTag: .none
        ),
        ExploreQuizItem(
            categoryFilterID: "Movies",
            categoryLabel: "Movies",
            categoryLabelColorHex: "a855f7",
            title: "Cinema Classics",
            emoji: "🎬",
            topBarGradientStartHex: "a855f7",
            topBarGradientEndHex: "6366f1",
            thumbnailGradientStartHex: "a855f7",
            thumbnailGradientEndHex: "6366f1",
            rating: "4.9",
            duration: "7 min",
            participants: "21k",
            difficulty: .easy,
            supplementaryTag: .none
        ),
        ExploreQuizItem(
            categoryFilterID: "History",
            categoryLabel: "History",
            categoryLabelColorHex: "f59e0b",
            title: "Ancient History",
            emoji: "🏛️",
            topBarGradientStartHex: "f59e0b",
            topBarGradientEndHex: "ef4444",
            thumbnailGradientStartHex: "f59e0b",
            thumbnailGradientEndHex: "ef4444",
            rating: "4.7",
            duration: "10 min",
            participants: "7k",
            difficulty: .hard,
            supplementaryTag: .none
        ),
        ExploreQuizItem(
            categoryFilterID: "Music",
            categoryLabel: "Music",
            categoryLabelColorHex: "ec4899",
            title: "Music Legends",
            emoji: "🎵",
            topBarGradientStartHex: "ec4899",
            topBarGradientEndHex: "f43f5e",
            thumbnailGradientStartHex: "ec4899",
            thumbnailGradientEndHex: "f43f5e",
            rating: "4.5",
            duration: "8 min",
            participants: "15k",
            difficulty: .medium,
            supplementaryTag: .none
        ),
        ExploreQuizItem(
            categoryFilterID: "IT",
            categoryLabel: "IT",
            categoryLabelColorHex: "3b82f6",
            title: "Tech & Coding",
            emoji: "💻",
            topBarGradientStartHex: "3b82f6",
            topBarGradientEndHex: "7c3aed",
            thumbnailGradientStartHex: "3b82f6",
            thumbnailGradientEndHex: "7c3aed",
            rating: "4.8",
            duration: "12 min",
            participants: "9k",
            difficulty: .hard,
            supplementaryTag: .new
        ),
        ExploreQuizItem(
            categoryFilterID: "Sports",
            categoryLabel: "Sports",
            categoryLabelColorHex: "f97316",
            title: "Sports Champions",
            emoji: "⚽",
            topBarGradientStartHex: "f97316",
            topBarGradientEndHex: "dc2626",
            thumbnailGradientStartHex: "f97316",
            thumbnailGradientEndHex: "dc2626",
            rating: "4.4",
            duration: "6 min",
            participants: "18k",
            difficulty: .easy,
            supplementaryTag: .none
        ),
        ExploreQuizItem(
            categoryFilterID: "Languages",
            categoryLabel: "Languages",
            categoryLabelColorHex: "14b8a6",
            title: "Language Explorer",
            emoji: "🗣️",
            topBarGradientStartHex: "14b8a6",
            topBarGradientEndHex: "06b6d4",
            thumbnailGradientStartHex: "14b8a6",
            thumbnailGradientEndHex: "06b6d4",
            rating: "4.6",
            duration: "8 min",
            participants: "5k",
            difficulty: .medium,
            supplementaryTag: .new
        ),
        ExploreQuizItem(
            categoryFilterID: "Science",
            categoryLabel: "Science",
            categoryLabelColorHex: "6366f1",
            title: "Space & Universe",
            emoji: "🚀",
            topBarGradientStartHex: "6366f1",
            topBarGradientEndHex: "7c3aed",
            thumbnailGradientStartHex: "6366f1",
            thumbnailGradientEndHex: "7c3aed",
            rating: "4.9",
            duration: "8 min",
            participants: "11k",
            difficulty: .medium,
            supplementaryTag: .pro
        )
    ]

    private var categoryFilteredQuizzes: [ExploreQuizItem] {
        guard selectedCategoryIndex > 0, selectedCategoryIndex < categories.count else {
            return allQuizzes
        }
        let key = categories[selectedCategoryIndex]
        return allQuizzes.filter { $0.categoryFilterID.caseInsensitiveCompare(key) == .orderedSame }
    }

    var filteredQuizzes: [ExploreQuizItem] {
        let base = categoryFilteredQuizzes
        guard !searchQuery.isEmpty else { return base }
        return base.filter { Self.matchesSearch($0, query: searchQuery) }
    }

    private static func matchesSearch(_ item: ExploreQuizItem, query: String) -> Bool {
        item.title.localizedCaseInsensitiveContains(query)
            || item.categoryLabel.localizedCaseInsensitiveContains(query)
            || item.categoryFilterID.localizedCaseInsensitiveContains(query)
    }

    var resultsCountText: String {
        let n = filteredQuizzes.count
        let noun = n == 1 ? "quiz" : "quizzes"
        return "\(n) \(noun) found"
    }

    func selectCategory(at index: Int) {
        guard index >= 0, index < categories.count else { return }
        selectedCategoryIndex = index
    }

    func setSearchQuery(_ text: String) {
        searchQuery = text
    }
}
