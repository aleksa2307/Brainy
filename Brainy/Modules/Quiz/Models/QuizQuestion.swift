import UIKit

struct QuizQuestion {

    enum QuestionType {
        case multipleChoice, trueFalse

        var displayTitle: String {
            self == .multipleChoice ? "MULTIPLE CHOICE" : "TRUE / FALSE"
        }

        var badgeBackground: UIColor {
            self == .multipleChoice ? UIColor(hex: "eef2ff") : UIColor(hex: "fef3c7")
        }

        var badgeTextColor: UIColor {
            self == .multipleChoice ? UIColor(hex: "4f46e5") : UIColor(hex: "92400e")
        }
    }

    let type: QuestionType
    let text: String
    let options: [String]
    let correctIndex: Int
    let explanation: String
    let funFact: String
}

extension QuizQuestion {
    static let sampleQuestions: [QuizQuestion] = [
        QuizQuestion(
            type: .multipleChoice,
            text: "What is the capital of France?",
            options: ["London", "Berlin", "Paris", "Madrid"],
            correctIndex: 2,
            explanation: "Paris is the capital and most populous city of France.",
            funFact: "💡 Paris has been France's capital city since 987 AD — over 1,000 years ago!"
        ),
        QuizQuestion(
            type: .trueFalse,
            text: "The Great Wall of China is visible from space with the naked eye.",
            options: ["True", "False"],
            correctIndex: 1,
            explanation: "This is a myth — the Great Wall is too narrow to be seen from space.",
            funFact: "💡 The Great Wall stretches over 13,000 miles and took more than 1,000 years to build."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Which planet is known as the Red Planet?",
            options: ["Venus", "Jupiter", "Saturn", "Mars"],
            correctIndex: 3,
            explanation: "Mars appears red due to iron oxide (rust) on its surface.",
            funFact: "💡 Mars has the tallest volcano in the solar system — Olympus Mons at 22 km high!"
        ),
        QuizQuestion(
            type: .trueFalse,
            text: "Diamonds are made of compressed carbon.",
            options: ["True", "False"],
            correctIndex: 0,
            explanation: "Diamonds are formed from carbon under extreme heat and pressure deep underground.",
            funFact: "💡 Diamonds form about 100 miles underground and can be billions of years old!"
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Who painted the Mona Lisa?",
            options: ["Michelangelo", "Leonardo da Vinci", "Raphael", "Botticelli"],
            correctIndex: 1,
            explanation: "The Mona Lisa was painted by Leonardo da Vinci between 1503 and 1519.",
            funFact: "💡 The Mona Lisa is only 77×53 cm — smaller than most people imagine!"
        ),
        QuizQuestion(
            type: .trueFalse,
            text: "Humans and chimpanzees share about 98% of their DNA.",
            options: ["True", "False"],
            correctIndex: 0,
            explanation: "Yes! Humans and chimpanzees share approximately 98.7% of their DNA.",
            funFact: "💡 Those ~1.3% differences account for all uniquely human traits!"
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "What is the largest ocean on Earth?",
            options: ["Atlantic", "Indian", "Pacific", "Arctic"],
            correctIndex: 2,
            explanation: "The Pacific Ocean covers about 165 million square kilometres.",
            funFact: "💡 The Pacific Ocean is larger than all of Earth's landmasses combined!"
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "In which year did World War II end?",
            options: ["1943", "1944", "1945", "1946"],
            correctIndex: 2,
            explanation: "World War II ended in 1945 with Germany's surrender in May and Japan's in September.",
            funFact: "💡 WWII was the deadliest conflict in human history, with over 70 million casualties."
        ),
        QuizQuestion(
            type: .trueFalse,
            text: "Lightning never strikes the same place twice.",
            options: ["True", "False"],
            correctIndex: 1,
            explanation: "This is a myth — lightning frequently strikes the same place multiple times.",
            funFact: "💡 The Empire State Building is struck by lightning about 20–25 times per year!"
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "What is the chemical symbol for gold?",
            options: ["Go", "Gd", "Au", "Ag"],
            correctIndex: 2,
            explanation: "Au comes from the Latin word 'aurum', meaning gold.",
            funFact: "💡 All the gold ever mined could fit inside a cube roughly 21 metres on each side!"
        )
    ]
}
