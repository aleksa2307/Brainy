import Foundation

final class ExploreViewModel {

    let categories: [String] = [
        "All", "History", "Science", "Movies", "Music",
        "Geography", "Sports", "IT", "Languages"
    ]

    private(set) var selectedCategoryIndex: Int = 0
    private(set) var searchQuery: String = ""

    private let allQuizzes: [ExploreQuizItem] = ExploreQuizMockData.allQuizzes

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
