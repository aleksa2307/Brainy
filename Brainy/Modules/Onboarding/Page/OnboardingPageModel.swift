import UIKit

struct OnboardingPageModel {
    let gradientColors: [UIColor]
    let emojiGrid: [String]
    let centerEmoji: String
    let centerShadowColor: UIColor
    let heading: String
    let subtitle: String
    let accentColor: UIColor
    let buttonTitle: String
    let showArrow: Bool
    let pageIndex: Int

    static let all: [OnboardingPageModel] = [
        OnboardingPageModel(
            gradientColors: [UIColor(hex: "eef2ff"), UIColor(hex: "dbeafe")],
            emojiGrid: ["🌍", "🎬", "🔬", "🎵", "🏛️", "⚽"],
            centerEmoji: "🧭",
            centerShadowColor: UIColor(red: 79/255, green: 70/255, blue: 229/255, alpha: 0.25),
            heading: "Explore quizzes you love",
            subtitle: "Discover hundreds of quizzes across every topic — from science to cinema, history to hip-hop.",
            accentColor: UIColor(hex: "4f46e5"),
            buttonTitle: "Next",
            showArrow: true,
            pageIndex: 0
        ),
        OnboardingPageModel(
            gradientColors: [UIColor(hex: "fef9c3"), UIColor(hex: "fef3c7")],
            emojiGrid: ["⭐", "🏅", "🔥", "💎", "🎖️", "⚡"],
            centerEmoji: "🏆",
            centerShadowColor: UIColor(red: 245/255, green: 158/255, blue: 11/255, alpha: 0.25),
            heading: "Earn points, badges, and streaks",
            subtitle: "Answer correctly to earn XP, unlock exclusive badges, and keep your daily streak alive.",
            accentColor: UIColor(hex: "f59e0b"),
            buttonTitle: "Next",
            showArrow: true,
            pageIndex: 1
        ),
        OnboardingPageModel(
            gradientColors: [UIColor(hex: "dcfce7"), UIColor(hex: "d1fae5")],
            emojiGrid: ["📊", "🎯", "💡", "🚀", "🧠", "✅"],
            centerEmoji: "📈",
            centerShadowColor: UIColor(red: 34/255, green: 197/255, blue: 94/255, alpha: 0.25),
            heading: "Track your progress every day",
            subtitle: "Watch your skills grow with detailed stats, accuracy tracking, and category insights.",
            accentColor: UIColor(hex: "22c55e"),
            buttonTitle: "Start Playing",
            showArrow: false,
            pageIndex: 2
        )
    ]
}
