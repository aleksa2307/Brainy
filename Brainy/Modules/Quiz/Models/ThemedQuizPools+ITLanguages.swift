import Foundation

extension ThemedQuizPools {

    static let it: [QuizQuestion] = [
        QuizQuestion(
            type: .multipleChoice,
            text: "What does CPU stand for?",
            options: ["Central Processing Unit", "Computer Personal Utility", "Core Program Unit", "Cached Power Unit"],
            correctIndex: 0,
            explanation: "The CPU executes instructions and coordinates other hardware.",
            funFact: "💡 Modern CPUs pack billions of transistors on a chip."
        ),
        QuizQuestion(
            type: .trueFalse,
            text: "HTTP and HTTPS are protocols used on the web.",
            options: ["True", "False"],
            correctIndex: 0,
            explanation: "Hypertext Transfer Protocol (Secure) underpins browser–server communication.",
            funFact: "💡 HTTPS adds TLS encryption for confidentiality and integrity."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Which company created the Swift programming language for Apple platforms?",
            options: ["Google", "Microsoft", "Apple", "Mozilla"],
            correctIndex: 2,
            explanation: "Apple introduced Swift as a modern successor to Objective-C.",
            funFact: "💡 Swift is open source and used beyond iOS."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "What is Linux?",
            options: ["A spreadsheet app", "A family of open-source operating-system kernels", "A CPU brand", "A video codec"],
            correctIndex: 1,
            explanation: "The Linux kernel powers Android servers, embedded devices, and desktops.",
            funFact: "💡 Android uses a Linux-based kernel with Google frameworks."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "In Git, what command creates a new commit of staged changes?",
            options: ["git push", "git pull", "git commit", "git clone"],
            correctIndex: 2,
            explanation: "'git commit' records a snapshot after you stage with 'git add'.",
            funFact: "💡 Commits form a directed history graph with branches."
        ),
        QuizQuestion(
            type: .trueFalse,
            text: "RAM is volatile — its contents are lost when power is cut.",
            options: ["True", "False"],
            correctIndex: 0,
            explanation: "Unlike flash/SSD storage for persistence, typical RAM needs power refresh.",
            funFact: "💡 DDR5 is a common modern RAM standard."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Which big-O means linear time in input size n?",
            options: ["O(1)", "O(log n)", "O(n)", "O(n²)"],
            correctIndex: 2,
            explanation: "Linear algorithms scale proportionally with n.",
            funFact: "💡 Nested loops often risk O(n²) or worse."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "What does SQL primarily manipulate?",
            options: ["Vector graphics", "Relational databases", "Audio streams", "3D meshes"],
            correctIndex: 1,
            explanation: "Structured Query Language queries and updates tables of data.",
            funFact: "💡 JOIN combines rows across related tables."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Which port is the default for HTTPS?",
            options: ["21", "80", "443", "8080"],
            correctIndex: 2,
            explanation: "Port 443 is assigned for HTTP over TLS.",
            funFact: "💡 Port 80 is common for plain HTTP."
        ),
        QuizQuestion(
            type: .trueFalse,
            text: "A binary search requires a sorted array to work correctly.",
            options: ["True", "False"],
            correctIndex: 0,
            explanation: "You compare midpoints only when ordering guarantees halves exclude answers.",
            funFact: "💡 Binary search runs in O(log n) time."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "What does JSON stand for?",
            options: ["JavaScript Object Notation", "Joint System Output Network", "Junction Object Naming", "Just-in-time Object Notation"],
            correctIndex: 0,
            explanation: "JSON is a lightweight text format for data exchange.",
            funFact: "💡 Swift's Codable maps JSON to types easily."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Which design pattern separates object construction from representation?",
            options: ["Singleton", "Builder", "Observer", "Adapter"],
            correctIndex: 1,
            explanation: "Builders assemble complex objects step by step.",
            funFact: "💡 StringBuilder in Java epitomizes incremental construction."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "What is phishing?",
            options: ["Hardware overheating", "Deceptive attempts to steal credentials", "GPU overclocking", "Lossless compression"],
            correctIndex: 1,
            explanation: "Attackers impersonate trusted entities to trick users.",
            funFact: "💡 MFA reduces account takeover from stolen passwords."
        ),
        QuizQuestion(
            type: .trueFalse,
            text: "IPv6 addresses are longer than IPv4 addresses.",
            options: ["True", "False"],
            correctIndex: 0,
            explanation: "IPv6 uses 128-bit addresses vs IPv4's 32 bits.",
            funFact: "💡 NAT helped extend IPv4 lifespan despite address exhaustion."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Which cloud model shares resources among tenants on shared hardware?",
            options: ["Private cloud", "Public cloud", "Air-gapped mainframe", "Edge-only cluster"],
            correctIndex: 1,
            explanation: "Public cloud providers host many customers abstracting underlying hardware.",
            funFact: "💡 Regions and availability zones improve resilience."
        )
    ]

    static let languages: [QuizQuestion] = [
        QuizQuestion(
            type: .multipleChoice,
            text: "Which language family does English belong to primarily?",
            options: ["Romance", "Germanic", "Slavic", "Semitic"],
            correctIndex: 1,
            explanation: "English evolved from Old English in the Germanic branch of Indo-European.",
            funFact: "💡 It borrowed heavily from French after the Norman Conquest."
        ),
        QuizQuestion(
            type: .trueFalse,
            text: "Mandarin Chinese uses logographic characters rather than an alphabet.",
            options: ["True", "False"],
            correctIndex: 0,
            explanation: "Characters (汉字) represent morphemes/syllables rather than single letters.",
            funFact: "💡 Pinyin romanizes pronunciation for learners."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "'Bonjour' means what in French?",
            options: ["Good night", "Thank you", "Hello / Good day", "Goodbye"],
            correctIndex: 2,
            explanation: "'Bonjour' is a daytime greeting.",
            funFact: "💡 'Bonsoir' suits evenings."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Which language uses the Cyrillic alphabet?",
            options: ["Greek", "Russian", "Hebrew", "Thai"],
            correctIndex: 1,
            explanation: "Russian and several Slavic languages use Cyrillic letters.",
            funFact: "💡 Saints Cyril and Methodius influenced early Slavic writing."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "What is an ideogram?",
            options: ["A word formed only from prefixes", "A symbol representing an idea or word", "A silent letter", "A rhyme scheme"],
            correctIndex: 1,
            explanation: "Ideograms convey meaning directly, as in some Chinese characters.",
            funFact: "💡 Egyptian hieroglyphs mixed logographic and phonetic signs."
        ),
        QuizQuestion(
            type: .trueFalse,
            text: "Spanish and Italian are both Romance languages derived from Latin.",
            options: ["True", "False"],
            correctIndex: 0,
            explanation: "The Romance branch evolved from Vulgar Latin across the former Roman world.",
            funFact: "💡 Portuguese and Romanian are siblings in that branch."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "In linguistics, what is a cognate?",
            options: ["A slang insult", "Words in related languages from a common ancestor", "A silent pause", "A type of emoji"],
            correctIndex: 1,
            explanation: "English 'mother' and German 'Mutter' are cognates.",
            funFact: "💡 False friends look alike but differ in meaning."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Which writing system is used for modern standard Hindi (alongside Devanagari numerals context)?",
            options: ["Arabic script", "Devanagari", "Hangul", "Cyrillic"],
            correctIndex: 1,
            explanation: "Devanagari is an abugida used for Hindi, Marathi, and others.",
            funFact: "💡 Conjunct consonants fuse shapes in complex clusters."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "What does 'polyglot' mean?",
            options: ["A rare grammar error", "A person who speaks several languages", "A dead language", "A dialect map"],
            correctIndex: 1,
            explanation: "Polyglots switch among multilingual communities or study widely.",
            funFact: "💡 Hyperpolyglots may know dozens at functional levels."
        ),
        QuizQuestion(
            type: .trueFalse,
            text: "Japanese writing mixes kanji with syllabaries hiragana and katakana.",
            options: ["True", "False"],
            correctIndex: 0,
            explanation: "Kanji carries lexical meaning; kana spells grammar and loanwords.",
            funFact: "💡 Romaji writes Japanese with Latin letters for learners."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Which term describes two languages used stable in a community (e.g., Canada)?",
            options: ["Monoglossia", "Diglossia or bilingualism", "Aporia", "Solecism"],
            correctIndex: 1,
            explanation: "Bilingual societies maintain communication in multiple languages.",
            funFact: "💡 Code-switching blends languages within sentences."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Arabic is written primarily in which direction?",
            options: ["Left to right", "Right to left", "Top to bottom only", "Spiral outward"],
            correctIndex: 1,
            explanation: "Arabic script runs right-to-left with contextual letter joins.",
            funFact: "💡 Numerals may appear left-to-right inside Arabic text."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "What is the International Phonetic Alphabet used for?",
            options: ["Music tuning", "Precise representation of speech sounds", "Programming types", "Currency codes"],
            correctIndex: 1,
            explanation: "IPA transcribes pronunciation across languages consistently.",
            funFact: "💡 Linguists rely on IPA in dictionaries and fieldwork."
        ),
        QuizQuestion(
            type: .trueFalse,
            text: "German nouns are capitalized in standard orthography.",
            options: ["True", "False"],
            correctIndex: 0,
            explanation: "All German nouns take capitals in formal writing.",
            funFact: "💡 German also famously compound words into long chains."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Which language is written in Hangul, designed for clarity and learnability?",
            options: ["Vietnamese", "Korean", "Mongolian", "Indonesian"],
            correctIndex: 1,
            explanation: "King Sejong's court promulgated Hangul in the 15th century.",
            funFact: "💡 Jamo letters combine into syllable blocks."
        )
    ]
}
