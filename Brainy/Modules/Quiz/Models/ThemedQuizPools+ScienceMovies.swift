import Foundation

extension ThemedQuizPools {

    static let science: [QuizQuestion] = [
        QuizQuestion(
            type: .multipleChoice,
            text: "What is the chemical symbol for water?",
            options: ["O₂", "CO₂", "H₂O", "NaCl"],
            correctIndex: 2,
            explanation: "Each water molecule has two hydrogen atoms and one oxygen atom.",
            funFact: "💡 Despite the name 'hydrogen', oxygen makes up most of water's mass."
        ),
        QuizQuestion(
            type: .trueFalse,
            text: "Sound can travel through a vacuum.",
            options: ["True", "False"],
            correctIndex: 1,
            explanation: "Sound needs a medium such as air, water, or solid matter.",
            funFact: "💡 In space movies, explosions are often silent — in reality space has no air to carry sound."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Which gas do plants primarily take in for photosynthesis?",
            options: ["Oxygen", "Nitrogen", "Carbon dioxide", "Hydrogen"],
            correctIndex: 2,
            explanation: "Plants use CO₂ with sunlight to build sugars and release oxygen.",
            funFact: "💡 Forests and phytoplankton produce much of Earth's breathable oxygen."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "What is the nearest star to Earth (besides the Sun)?",
            options: ["Sirius", "Alpha Centauri", "Proxima Centauri", "Betelgeuse"],
            correctIndex: 2,
            explanation: "Proxima Centauri is about 4.24 light-years away, part of the Alpha Centauri system.",
            funFact: "💡 A 'light-year' measures distance, not time."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Speed of light in vacuum is approximately?",
            options: ["300 km/s", "3,000 km/s", "300,000 km/s", "3 million km/s"],
            correctIndex: 2,
            explanation: "Light travels roughly 299,792 km per second in vacuum.",
            funFact: "💡 Nothing with mass can reach the speed of light."
        ),
        QuizQuestion(
            type: .trueFalse,
            text: "An adult human has more bacterial cells than human cells.",
            options: ["True", "False"],
            correctIndex: 1,
            explanation: "Recent estimates often find human cells roughly comparable to or outnumbering microbes.",
            funFact: "💡 Your microbiome still weighs roughly 1–2% of body mass."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "DNA's structure is most famously described as a what?",
            options: ["Sheet", "Helix", "Cube", "Ring"],
            correctIndex: 1,
            explanation: "Watson, Crick, and Franklin's work revealed DNA's double helix.",
            funFact: "💡 Base pairs link the two strands like ladder rungs."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Which organ pumps blood through the circulatory system?",
            options: ["Liver", "Heart", "Kidney", "Lung"],
            correctIndex: 1,
            explanation: "The heart contracts rhythmically to circulate blood.",
            funFact: "💡 A resting adult heart beats about 60–100 times per minute."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "What particle carries a negative charge in an atom?",
            options: ["Proton", "Neutron", "Electron", "Photon"],
            correctIndex: 2,
            explanation: "Electrons orbit the nucleus and carry negative electric charge.",
            funFact: "💡 Protons define an element's atomic number."
        ),
        QuizQuestion(
            type: .trueFalse,
            text: "Water expands when it freezes.",
            options: ["True", "False"],
            correctIndex: 0,
            explanation: "Ice is less dense than liquid water, which is why it floats.",
            funFact: "💡 This anomaly helps protect aquatic life under winter ice."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Which planet is known as the Red Planet?",
            options: ["Venus", "Jupiter", "Mars", "Saturn"],
            correctIndex: 2,
            explanation: "Iron oxide (rust) dust gives Mars its reddish appearance.",
            funFact: "💡 Olympus Mons on Mars is the solar system's tallest known volcano."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "What is the center of an atom called?",
            options: ["Shell", "Nucleus", "Valence", "Isotope"],
            correctIndex: 1,
            explanation: "The nucleus contains protons and usually neutrons.",
            funFact: "💡 Most of an atom's mass is in the tiny nucleus."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Which unit measures force in the SI system?",
            options: ["Joule", "Watt", "Newton", "Pascal"],
            correctIndex: 2,
            explanation: "One newton accelerates one kilogram at one metre per second squared.",
            funFact: "💡 Named after Isaac Newton."
        ),
        QuizQuestion(
            type: .trueFalse,
            text: "Vitamin C deficiency can cause scurvy.",
            options: ["True", "False"],
            correctIndex: 0,
            explanation: "Without vitamin C, collagen formation suffers and gums may bleed.",
            funFact: "💡 Citrus helped sailors avoid scurvy on long voyages."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Which of these is NOT a state of matter commonly taught in school?",
            options: ["Solid", "Plasma", "Liquid", "Neutronium"],
            correctIndex: 3,
            explanation: "Solid, liquid, gas, and plasma are common; neutronium is exotic dense matter.",
            funFact: "💡 Plasma makes up most visible matter in stars."
        )
    ]

    static let movies: [QuizQuestion] = [
        QuizQuestion(
            type: .multipleChoice,
            text: "Which film won the first Academy Award for Best Picture (then 'Outstanding Picture')?",
            options: ["Wings", "Sunrise", "The Jazz Singer", "Metropolis"],
            correctIndex: 0,
            explanation: "'Wings' (1927) was honored at the first Oscars ceremony in 1929.",
            funFact: "💡 The Jazz Singer was pivotal for sound but not the first Best Picture."
        ),
        QuizQuestion(
            type: .trueFalse,
            text: "Steven Spielberg directed 'Jaws' (1975).",
            options: ["True", "False"],
            correctIndex: 0,
            explanation: "Spielberg directed the breakthrough summer blockbuster.",
            funFact: "💡 The shark malfunction famously led to scarcer monster shots — increasing suspense."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "In 'The Matrix' (1999), what color pill does Neo take to leave the simulation?",
            options: ["Blue", "Red", "Green", "Yellow"],
            correctIndex: 1,
            explanation: "Morpheus offers a red pill for truth and a blue pill to forget.",
            funFact: "💡 'Red pill' entered popular culture as a metaphor for awakening."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Which actress played Scarlett O'Hara in 'Gone with the Wind'?",
            options: ["Bette Davis", "Katharine Hepburn", "Vivien Leigh", "Greta Garbo"],
            correctIndex: 2,
            explanation: "Vivien Leigh's performance helped define the epic romance.",
            funFact: "💡 The film remains one of the highest-grossing adjusted for inflation."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "What is Darth Vader's original name before turning to the dark side?",
            options: ["Luke Starkiller", "Anakin Skywalker", "Ben Kenobi", "Han Solo"],
            correctIndex: 1,
            explanation: "Anakin Skywalker becomes Darth Vader in the Star Wars saga.",
            funFact: "💡 George Lucas drew inspiration from samurai films and Flash Gordon serials."
        ),
        QuizQuestion(
            type: .trueFalse,
            text: "'Citizen Kane' is often cited in critics' greatest-films lists.",
            options: ["True", "False"],
            correctIndex: 0,
            explanation: "Orson Welles's 1941 film innovated cinematography and nonlinear storytelling.",
            funFact: "💡 'Rosebud' is one of cinema's most famous MacGuffin-like mysteries."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Which studio produced most classic Disney animated fairy-tale features mid-20th century?",
            options: ["Warner Bros.", "Disney", "Universal", "Paramount"],
            correctIndex: 1,
            explanation: "Walt Disney Animation Studios shaped the animated musical form.",
            funFact: "💡 'Snow White' (1937) was the first full-length cel-animated feature in the US."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "In 'The Godfather', what is the Corleone family's business front?",
            options: ["Bakery", "Olive oil importing", "Casino chain", "Shipping"],
            correctIndex: 1,
            explanation: "Genco Olive Oil is part of the Corleone legitimate front.",
            funFact: "💡 Coppola based aspects on real organized-crime history."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Which composer scored 'Jurassic Park' and many Spielberg films?",
            options: ["Hans Zimmer", "John Williams", "Danny Elfman", "James Horner"],
            correctIndex: 1,
            explanation: "John Williams created iconic themes including the soaring Jurassic motif.",
            funFact: "💡 Williams also scored Star Wars, Harry Potter's early films, and Jaws."
        ),
        QuizQuestion(
            type: .trueFalse,
            text: "'Parasite' (2019) was the first non-English film to win Best Picture Oscar.",
            options: ["True", "False"],
            correctIndex: 0,
            explanation: "Bong Joon Ho's thriller made Oscar history for South Korean cinema.",
            funFact: "💡 Bong thanked translator Sharon Choi in speeches."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "In film aspect ratios, 'widescreen' often refers to scope formats close to?",
            options: ["4:3", "16:9", "2.39:1 (CinemaScope-style)", "1:1"],
            correctIndex: 2,
            explanation: "Classic anamorphic widescreen often hovers near 2.35:1–2.40:1.",
            funFact: "💡 TV's 4:3 was the norm before HD widescreens spread."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Alfred Hitchcock's 'Psycho' is famous for which setting?",
            options: ["Lighthouse", "Motel", "Train", "Submarine"],
            correctIndex: 1,
            explanation: "The Bates Motel became a horror icon.",
            funFact: "💡 The shower scene revolutionized editing and sound design."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Which actor played Forrest Gump?",
            options: ["Tom Hanks", "Robin Williams", "Kevin Costner", "Bill Murray"],
            correctIndex: 0,
            explanation: "Tom Hanks won back-to-back Best Actor Oscars with Philadelphia and Gump.",
            funFact: "💡 The bench scenes were filmed in Savannah, Georgia."
        ),
        QuizQuestion(
            type: .trueFalse,
            text: "James Cameron directed both 'Titanic' and 'Avatar'.",
            options: ["True", "False"],
            correctIndex: 0,
            explanation: "Cameron helmed both box-office phenomenons pushing visual spectacle.",
            funFact: "💡 Cameron has deep-sea exploration credits beyond directing."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Pixar's first feature-length film was?",
            options: ["A Bug's Life", "Toy Story", "Monsters, Inc.", "Finding Nemo"],
            correctIndex: 1,
            explanation: "'Toy Story' (1995) was the first fully computer-animated feature.",
            funFact: "💡 Buzz Lightyear's name nods to Apollo astronaut Buzz Aldrin."
        )
    ]
}
