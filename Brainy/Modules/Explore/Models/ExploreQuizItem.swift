import UIKit

struct ExploreQuizItem: Equatable {
    enum SupplementaryTag: Equatable {
        case none
        case new
        case pro
    }

    enum Difficulty: Equatable {
        case easy
        case medium
        case hard

        var title: String {
            switch self {
            case .easy: return "Easy"
            case .medium: return "Medium"
            case .hard: return "Hard"
            }
        }

        var backgroundColor: UIColor {
            switch self {
            case .easy: return UIColor(hex: "dcfce7")
            case .medium: return UIColor(hex: "fef3c7")
            case .hard: return UIColor(hex: "fee2e2")
            }
        }

        var textColor: UIColor {
            switch self {
            case .easy: return UIColor(hex: "22c55e")
            case .medium: return UIColor(hex: "f59e0b")
            case .hard: return UIColor(hex: "ef4444")
            }
        }
    }

    /// Matches `ExploreViewModel.categories` titles for filtering (except "All").
    let categoryFilterID: String
    let categoryLabel: String
    let categoryLabelColorHex: String
    let title: String
    let emoji: String
    let topBarGradientStartHex: String
    let topBarGradientEndHex: String
    let thumbnailGradientStartHex: String
    let thumbnailGradientEndHex: String
    let rating: String
    let duration: String
    let participants: String
    let difficulty: Difficulty
    let supplementaryTag: SupplementaryTag
}
