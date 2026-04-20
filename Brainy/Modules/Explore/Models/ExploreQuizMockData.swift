import Foundation

enum ExploreQuizMockData {

    private struct CategoryTheme {
        let name: String
        let labelColorHex: String
        let gradientEndHex: String
        let thumbnailEndHex: String
    }

    private static let history = CategoryTheme(
        name: "History",
        labelColorHex: "f59e0b",
        gradientEndHex: "ef4444",
        thumbnailEndHex: "f97316"
    )

    private static let scienceGreen = CategoryTheme(
        name: "Science",
        labelColorHex: "22c55e",
        gradientEndHex: "059669",
        thumbnailEndHex: "16a34a"
    )

    private static let scienceViolet = CategoryTheme(
        name: "Science",
        labelColorHex: "6366f1",
        gradientEndHex: "7c3aed",
        thumbnailEndHex: "8b5cf6"
    )

    private static let movies = CategoryTheme(
        name: "Movies",
        labelColorHex: "a855f7",
        gradientEndHex: "6366f1",
        thumbnailEndHex: "9333ea"
    )

    private static let music = CategoryTheme(
        name: "Music",
        labelColorHex: "ec4899",
        gradientEndHex: "f43f5e",
        thumbnailEndHex: "db2777"
    )

    private static let geography = CategoryTheme(
        name: "Geography",
        labelColorHex: "06b6d4",
        gradientEndHex: "3b82f6",
        thumbnailEndHex: "0ea5e9"
    )

    private static let sports = CategoryTheme(
        name: "Sports",
        labelColorHex: "f97316",
        gradientEndHex: "dc2626",
        thumbnailEndHex: "ea580c"
    )

    private static let it = CategoryTheme(
        name: "IT",
        labelColorHex: "3b82f6",
        gradientEndHex: "7c3aed",
        thumbnailEndHex: "6366f1"
    )

    private static let languages = CategoryTheme(
        name: "Languages",
        labelColorHex: "14b8a6",
        gradientEndHex: "06b6d4",
        thumbnailEndHex: "0d9488"
    )

    private static func makeQuiz(
        theme: CategoryTheme,
        title: String,
        emoji: String,
        rating: String,
        duration: String,
        participants: String,
        difficulty: ExploreQuizItem.Difficulty,
        supplementaryTag: ExploreQuizItem.SupplementaryTag = .none
    ) -> ExploreQuizItem {
        ExploreQuizItem(
            categoryFilterID: theme.name,
            categoryLabel: theme.name,
            categoryLabelColorHex: theme.labelColorHex,
            title: title,
            emoji: emoji,
            topBarGradientStartHex: theme.labelColorHex,
            topBarGradientEndHex: theme.gradientEndHex,
            thumbnailGradientStartHex: theme.labelColorHex,
            thumbnailGradientEndHex: theme.thumbnailEndHex,
            rating: rating,
            duration: duration,
            participants: participants,
            difficulty: difficulty,
            supplementaryTag: supplementaryTag
        )
    }

    static let allQuizzes: [ExploreQuizItem] = [
        makeQuiz(theme: geography, title: "World Capitals Mastery", emoji: "🌍", rating: "4.8", duration: "8 min", participants: "13k", difficulty: .medium),
        makeQuiz(theme: geography, title: "Rivers & Lakes", emoji: "🏞️", rating: "4.6", duration: "7 min", participants: "9k", difficulty: .easy),
        makeQuiz(theme: geography, title: "Flags Around the World", emoji: "🎌", rating: "4.7", duration: "9 min", participants: "16k", difficulty: .medium, supplementaryTag: .new),
        makeQuiz(theme: geography, title: "Mountain Peaks", emoji: "🏔️", rating: "4.5", duration: "6 min", participants: "8k", difficulty: .hard),
        makeQuiz(theme: geography, title: "Deserts & Climate", emoji: "🏜️", rating: "4.4", duration: "10 min", participants: "6k", difficulty: .medium),
        makeQuiz(theme: geography, title: "Cities & Landmarks", emoji: "🌆", rating: "4.9", duration: "8 min", participants: "19k", difficulty: .easy, supplementaryTag: .pro),
        makeQuiz(theme: geography, title: "Oceans & Seas", emoji: "🌊", rating: "4.6", duration: "7 min", participants: "11k", difficulty: .medium),
        makeQuiz(theme: geography, title: "Borders & Regions", emoji: "🗺️", rating: "4.3", duration: "11 min", participants: "5k", difficulty: .hard),
        makeQuiz(theme: geography, title: "Map Reading Basics", emoji: "📍", rating: "4.7", duration: "5 min", participants: "14k", difficulty: .easy),

        makeQuiz(theme: scienceGreen, title: "Science Fundamentals", emoji: "🔬", rating: "4.6", duration: "12 min", participants: "9k", difficulty: .hard),
        makeQuiz(theme: scienceViolet, title: "Space & Universe", emoji: "🚀", rating: "4.9", duration: "8 min", participants: "11k", difficulty: .medium),
        makeQuiz(theme: scienceGreen, title: "Human Body Quiz", emoji: "🫀", rating: "4.5", duration: "10 min", participants: "12k", difficulty: .medium, supplementaryTag: .new),
        makeQuiz(theme: scienceViolet, title: "Chemistry Basics", emoji: "⚗️", rating: "4.7", duration: "9 min", participants: "7k", difficulty: .hard),
        makeQuiz(theme: scienceGreen, title: "Physics in Daily Life", emoji: "⚡", rating: "4.8", duration: "11 min", participants: "10k", difficulty: .medium),
        makeQuiz(theme: scienceViolet, title: "Earth & Ecosystems", emoji: "🌿", rating: "4.4", duration: "10 min", participants: "6k", difficulty: .easy),
        makeQuiz(theme: scienceGreen, title: "Genetics & Evolution", emoji: "🧬", rating: "4.6", duration: "12 min", participants: "5k", difficulty: .hard, supplementaryTag: .pro),
        makeQuiz(theme: scienceViolet, title: "Energy & Environment", emoji: "☀️", rating: "4.5", duration: "9 min", participants: "8k", difficulty: .medium),
        makeQuiz(theme: scienceGreen, title: "Laboratory Smarts", emoji: "🧪", rating: "4.7", duration: "7 min", participants: "9k", difficulty: .easy),

        makeQuiz(theme: movies, title: "Cinema Classics", emoji: "🎬", rating: "4.9", duration: "7 min", participants: "21k", difficulty: .easy),
        makeQuiz(theme: movies, title: "Oscar Winners", emoji: "🏆", rating: "4.8", duration: "8 min", participants: "17k", difficulty: .medium),
        makeQuiz(theme: movies, title: "Directors' Corner", emoji: "🎥", rating: "4.6", duration: "9 min", participants: "10k", difficulty: .hard, supplementaryTag: .new),
        makeQuiz(theme: movies, title: "Movie Quotes", emoji: "💬", rating: "4.7", duration: "6 min", participants: "22k", difficulty: .easy),
        makeQuiz(theme: movies, title: "Franchises & Sequels", emoji: "🍿", rating: "4.5", duration: "10 min", participants: "13k", difficulty: .medium),
        makeQuiz(theme: movies, title: "Animation & VFX", emoji: "✨", rating: "4.8", duration: "8 min", participants: "15k", difficulty: .medium, supplementaryTag: .pro),
        makeQuiz(theme: movies, title: "Film Genres", emoji: "🎞️", rating: "4.4", duration: "7 min", participants: "11k", difficulty: .easy),
        makeQuiz(theme: movies, title: "Blockbusters", emoji: "🌟", rating: "4.9", duration: "9 min", participants: "20k", difficulty: .hard),
        makeQuiz(theme: movies, title: "Indie Gems", emoji: "🎭", rating: "4.6", duration: "8 min", participants: "8k", difficulty: .medium),

        makeQuiz(theme: history, title: "Ancient Empires", emoji: "🏛️", rating: "4.7", duration: "10 min", participants: "7k", difficulty: .hard),
        makeQuiz(theme: history, title: "World Wars", emoji: "⚔️", rating: "4.8", duration: "11 min", participants: "12k", difficulty: .hard, supplementaryTag: .new),
        makeQuiz(theme: history, title: "Revolutions", emoji: "📜", rating: "4.5", duration: "9 min", participants: "6k", difficulty: .medium),
        makeQuiz(theme: history, title: "Medieval Times", emoji: "🏰", rating: "4.6", duration: "10 min", participants: "8k", difficulty: .medium),
        makeQuiz(theme: history, title: "Famous Leaders", emoji: "👑", rating: "4.9", duration: "8 min", participants: "14k", difficulty: .easy),
        makeQuiz(theme: history, title: "Archaeology Finds", emoji: "🧱", rating: "4.4", duration: "12 min", participants: "5k", difficulty: .hard),
        makeQuiz(theme: history, title: "Art & Culture Eras", emoji: "🖼️", rating: "4.7", duration: "9 min", participants: "9k", difficulty: .medium, supplementaryTag: .pro),
        makeQuiz(theme: history, title: "Maritime History", emoji: "⛵", rating: "4.5", duration: "7 min", participants: "6k", difficulty: .easy),
        makeQuiz(theme: history, title: "Cold War & Beyond", emoji: "🛰️", rating: "4.6", duration: "10 min", participants: "7k", difficulty: .medium),

        makeQuiz(theme: music, title: "Music Legends", emoji: "🎵", rating: "4.5", duration: "8 min", participants: "15k", difficulty: .medium),
        makeQuiz(theme: music, title: "Classical Masters", emoji: "🎻", rating: "4.8", duration: "9 min", participants: "10k", difficulty: .hard),
        makeQuiz(theme: music, title: "Pop & Rock Icons", emoji: "🎸", rating: "4.7", duration: "7 min", participants: "18k", difficulty: .easy, supplementaryTag: .new),
        makeQuiz(theme: music, title: "Jazz & Blues", emoji: "🎷", rating: "4.6", duration: "8 min", participants: "7k", difficulty: .medium),
        makeQuiz(theme: music, title: "Hip-Hop & R&B", emoji: "🎤", rating: "4.9", duration: "9 min", participants: "16k", difficulty: .easy),
        makeQuiz(theme: music, title: "World Music", emoji: "🥁", rating: "4.4", duration: "10 min", participants: "6k", difficulty: .medium),
        makeQuiz(theme: music, title: "Instruments & Theory", emoji: "🎹", rating: "4.5", duration: "11 min", participants: "5k", difficulty: .hard, supplementaryTag: .pro),
        makeQuiz(theme: music, title: "Festivals & Awards", emoji: "🎉", rating: "4.7", duration: "6 min", participants: "12k", difficulty: .easy),
        makeQuiz(theme: music, title: "Soundtracks & Scores", emoji: "🎼", rating: "4.8", duration: "8 min", participants: "9k", difficulty: .medium),

        makeQuiz(theme: it, title: "Tech & Coding", emoji: "💻", rating: "4.8", duration: "12 min", participants: "9k", difficulty: .hard, supplementaryTag: .new),
        makeQuiz(theme: it, title: "Internet & Security", emoji: "🔐", rating: "4.7", duration: "10 min", participants: "11k", difficulty: .hard),
        makeQuiz(theme: it, title: "Data & AI Basics", emoji: "🤖", rating: "4.9", duration: "11 min", participants: "14k", difficulty: .medium, supplementaryTag: .pro),
        makeQuiz(theme: it, title: "Mobile & Apps", emoji: "📱", rating: "4.6", duration: "8 min", participants: "16k", difficulty: .easy),
        makeQuiz(theme: it, title: "Operating Systems", emoji: "🖥️", rating: "4.5", duration: "9 min", participants: "8k", difficulty: .medium),
        makeQuiz(theme: it, title: "Networks & Cloud", emoji: "☁️", rating: "4.7", duration: "10 min", participants: "10k", difficulty: .hard),
        makeQuiz(theme: it, title: "Programming Languages", emoji: "🧩", rating: "4.8", duration: "12 min", participants: "12k", difficulty: .hard),
        makeQuiz(theme: it, title: "Hardware & Devices", emoji: "🧰", rating: "4.4", duration: "7 min", participants: "7k", difficulty: .easy),
        makeQuiz(theme: it, title: "Dev Tools & Git", emoji: "🛠️", rating: "4.6", duration: "9 min", participants: "9k", difficulty: .medium),

        makeQuiz(theme: sports, title: "Sports Champions", emoji: "⚽", rating: "4.4", duration: "6 min", participants: "18k", difficulty: .easy),
        makeQuiz(theme: sports, title: "Football Worldwide", emoji: "🌐", rating: "4.7", duration: "8 min", participants: "20k", difficulty: .medium),
        makeQuiz(theme: sports, title: "Olympics History", emoji: "🏅", rating: "4.8", duration: "9 min", participants: "15k", difficulty: .medium, supplementaryTag: .new),
        makeQuiz(theme: sports, title: "Basketball & NBA", emoji: "🏀", rating: "4.6", duration: "7 min", participants: "17k", difficulty: .easy),
        makeQuiz(theme: sports, title: "Tennis & Grand Slams", emoji: "🎾", rating: "4.5", duration: "8 min", participants: "11k", difficulty: .hard),
        makeQuiz(theme: sports, title: "Athletics & Records", emoji: "🏃", rating: "4.7", duration: "6 min", participants: "13k", difficulty: .medium),
        makeQuiz(theme: sports, title: "Winter Sports", emoji: "⛷️", rating: "4.3", duration: "9 min", participants: "8k", difficulty: .hard, supplementaryTag: .pro),
        makeQuiz(theme: sports, title: "Combat Sports", emoji: "🥊", rating: "4.6", duration: "8 min", participants: "9k", difficulty: .medium),
        makeQuiz(theme: sports, title: "Team Strategy", emoji: "🎯", rating: "4.5", duration: "10 min", participants: "7k", difficulty: .hard),

        makeQuiz(theme: languages, title: "Language Explorer", emoji: "🗣️", rating: "4.6", duration: "8 min", participants: "5k", difficulty: .medium, supplementaryTag: .new),
        makeQuiz(theme: languages, title: "English Idioms", emoji: "📘", rating: "4.8", duration: "7 min", participants: "12k", difficulty: .easy),
        makeQuiz(theme: languages, title: "Spanish Essentials", emoji: "🇪🇸", rating: "4.7", duration: "9 min", participants: "10k", difficulty: .medium),
        makeQuiz(theme: languages, title: "French Phrases", emoji: "🇫🇷", rating: "4.5", duration: "8 min", participants: "8k", difficulty: .easy),
        makeQuiz(theme: languages, title: "German Grammar", emoji: "🇩🇪", rating: "4.4", duration: "10 min", participants: "6k", difficulty: .hard),
        makeQuiz(theme: languages, title: "Japanese Scripts", emoji: "🇯🇵", rating: "4.6", duration: "11 min", participants: "7k", difficulty: .hard, supplementaryTag: .pro),
        makeQuiz(theme: languages, title: "Italian Culture Talk", emoji: "🇮🇹", rating: "4.7", duration: "7 min", participants: "9k", difficulty: .medium),
        makeQuiz(theme: languages, title: "Portuguese & Brazilian", emoji: "🇧🇷", rating: "4.5", duration: "8 min", participants: "6k", difficulty: .medium),
        makeQuiz(theme: languages, title: "Polyglot Challenge", emoji: "🌐", rating: "4.9", duration: "12 min", participants: "4k", difficulty: .hard)
    ]
}
