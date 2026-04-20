import Foundation

extension ThemedQuizPools {

    static let geography: [QuizQuestion] = [
        QuizQuestion(
            type: .multipleChoice,
            text: "What is the capital of Japan?",
            options: ["Seoul", "Beijing", "Tokyo", "Osaka"],
            correctIndex: 2,
            explanation: "Tokyo is the capital and largest city of Japan.",
            funFact: "💡 Greater Tokyo is the world's most populous metropolitan area."
        ),
        QuizQuestion(
            type: .trueFalse,
            text: "Australia is both a country and a continent.",
            options: ["True", "False"],
            correctIndex: 0,
            explanation: "Australia is the smallest continent and includes one main country with that name.",
            funFact: "💡 Australia is the only continent-nation without land borders with other countries."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Which river is generally considered the longest in the world?",
            options: ["Amazon", "Yangtze", "Nile", "Mississippi"],
            correctIndex: 2,
            explanation: "The Nile is traditionally cited as the longest river on Earth.",
            funFact: "💡 The Nile helped sustain ancient Egyptian civilization for thousands of years."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "What is the capital of Canada?",
            options: ["Toronto", "Vancouver", "Ottawa", "Montreal"],
            correctIndex: 2,
            explanation: "Ottawa is Canada's capital, located in the province of Ontario.",
            funFact: "💡 Ottawa was chosen partly because it sat between English and French-speaking regions."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "The Sahara Desert is located primarily on which continent?",
            options: ["Asia", "Africa", "Australia", "South America"],
            correctIndex: 1,
            explanation: "The Sahara covers much of North Africa.",
            funFact: "💡 The Sahara is roughly the size of the United States."
        ),
        QuizQuestion(
            type: .trueFalse,
            text: "Mount Everest is located in Europe.",
            options: ["True", "False"],
            correctIndex: 1,
            explanation: "Everest sits on the border of Nepal and Tibet (China) in Asia.",
            funFact: "💡 Everest rises about 8,849 metres above sea level."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Which country has the most natural lakes?",
            options: ["Russia", "United States", "Canada", "Brazil"],
            correctIndex: 2,
            explanation: "Canada contains a large share of the world's freshwater lakes.",
            funFact: "💡 Much of Canada's north is sparsely populated lake country."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "What is the smallest independent country by area?",
            options: ["Monaco", "Vatican City", "San Marino", "Liechtenstein"],
            correctIndex: 1,
            explanation: "Vatican City is an independent city-state enclaved within Rome.",
            funFact: "💡 Vatican City covers only about 0.44 km²."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "The Amazon River flows into which ocean?",
            options: ["Pacific", "Indian", "Atlantic", "Arctic"],
            correctIndex: 2,
            explanation: "The Amazon drains into the Atlantic on the northeast coast of South America.",
            funFact: "💡 The Amazon discharges more water than the next several largest rivers combined."
        ),
        QuizQuestion(
            type: .trueFalse,
            text: "Russia spans both Europe and Asia.",
            options: ["True", "False"],
            correctIndex: 0,
            explanation: "Russia crosses the Ural Mountains, with territory in both continents.",
            funFact: "💡 Russia is the largest country by land area."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "What is the capital of Australia?",
            options: ["Sydney", "Melbourne", "Canberra", "Perth"],
            correctIndex: 2,
            explanation: "Canberra was planned as a compromise capital between Sydney and Melbourne.",
            funFact: "💡 Canberra's name may derive from an indigenous word meaning 'meeting place.'"
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Which line divides Earth into Northern and Southern Hemispheres?",
            options: ["Tropic of Cancer", "Prime Meridian", "Equator", "International Date Line"],
            correctIndex: 2,
            explanation: "The equator is 0° latitude and splits the globe north and south.",
            funFact: "💡 Countries on the equator experience roughly 12 hours of day and night year-round."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Madagascar is an island nation off the coast of which continent?",
            options: ["Asia", "Australia", "Africa", "South America"],
            correctIndex: 2,
            explanation: "Madagascar lies in the Indian Ocean east of mainland Africa.",
            funFact: "💡 Madagascar hosts wildlife found nowhere else on Earth."
        ),
        QuizQuestion(
            type: .trueFalse,
            text: "The Dead Sea's surface is below sea level.",
            options: ["True", "False"],
            correctIndex: 0,
            explanation: "The Dead Sea shoreline is one of the lowest exposed points on Earth's land surface.",
            funFact: "💡 The water is so salty that most people float easily."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Which mountain range runs along the west coast of South America?",
            options: ["Rockies", "Alps", "Andes", "Himalayas"],
            correctIndex: 2,
            explanation: "The Andes form a long chain along South America's Pacific edge.",
            funFact: "💡 The Andes are the longest continental mountain range in the world."
        )
    ]

    static let history: [QuizQuestion] = [
        QuizQuestion(
            type: .multipleChoice,
            text: "In which year did World War II end in Europe (V-E Day is often marked in May)?",
            options: ["1943", "1944", "1945", "1946"],
            correctIndex: 2,
            explanation: "Nazi Germany surrendered in May 1945; the war in the Pacific ended months later.",
            funFact: "💡 VE Day is celebrated on May 8 in many European countries."
        ),
        QuizQuestion(
            type: .trueFalse,
            text: "The Roman Empire split into Western and Eastern parts.",
            options: ["True", "False"],
            correctIndex: 0,
            explanation: "The division became pronounced over time, with the East outlasting the West.",
            funFact: "💡 The Eastern Roman Empire is often called Byzantium."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Who was the first President of the United States?",
            options: ["John Adams", "Thomas Jefferson", "George Washington", "Benjamin Franklin"],
            correctIndex: 2,
            explanation: "George Washington led the Continental Army and became president in 1789.",
            funFact: "💡 Washington set precedents like serving only two terms."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "The French Revolution began in which decade?",
            options: ["1760s", "1780s", "1800s", "1820s"],
            correctIndex: 1,
            explanation: "Revolutionary turmoil in France escalated from 1789 onward.",
            funFact: "💡 The storming of the Bastille in 1789 is a famous early event."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Ancient Egyptian rulers were commonly known as what?",
            options: ["Consuls", "Emperors", "Pharaohs", "Shahs"],
            correctIndex: 2,
            explanation: "Pharaohs were believed to intermediate between gods and people.",
            funFact: "💡 The Great Pyramid at Giza is among the Seven Wonders legacy sites."
        ),
        QuizQuestion(
            type: .trueFalse,
            text: "The Berlin Wall fell in 1989.",
            options: ["True", "False"],
            correctIndex: 0,
            explanation: "The wall's opening in November 1989 symbolized the Cold War's easing in Europe.",
            funFact: "💡 Pieces of the wall were later sold worldwide as souvenirs."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "The Black Death pandemic peaked in Europe during which century?",
            options: ["12th", "13th", "14th", "16th"],
            correctIndex: 2,
            explanation: "The mid-14th century saw devastating plague outbreaks across Europe.",
            funFact: "💡 The plague reshaped labour, religion, and trade for generations."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Who wrote 'The Communist Manifesto' with Friedrich Engels?",
            options: ["Lenin", "Karl Marx", "Stalin", "Trotsky"],
            correctIndex: 1,
            explanation: "Marx and Engels published this influential pamphlet in 1848.",
            funFact: "💡 Its opening line about a 'spectre' haunting Europe became iconic."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "The Magna Carta limited the power of which English monarchy's ruler?",
            options: ["Henry VIII", "John", "Elizabeth I", "William the Conqueror"],
            correctIndex: 1,
            explanation: "King John sealed Magna Carta in 1215 under baronial pressure.",
            funFact: "💡 It later inspired ideas of rule of law and due process."
        ),
        QuizQuestion(
            type: .trueFalse,
            text: "The Industrial Revolution began in Britain before spreading elsewhere.",
            options: ["True", "False"],
            correctIndex: 0,
            explanation: "Britain pioneered factory systems, steam power, and railways early on.",
            funFact: "💡 Coal and iron were crucial inputs to Britain's early factories."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Which empire was ruled from Constantinople before 1453?",
            options: ["Ottoman (before conquest)", "Byzantine (Eastern Roman)", "Persian", "Mongol"],
            correctIndex: 1,
            explanation: "The Byzantine Empire had its capital at Constantinople until Ottoman conquest.",
            funFact: "💡 The city is today's Istanbul in Türkiye."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Nelson Mandela became president of which country?",
            options: ["Kenya", "Nigeria", "South Africa", "Zimbabwe"],
            correctIndex: 2,
            explanation: "Mandela was elected after the end of apartheid.",
            funFact: "💡 He had spent decades imprisoned before his presidency."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "The Silk Road mainly connected trade between East Asia and which region?",
            options: ["The Americas", "Sub-Saharan Africa", "Europe / Western Asia", "Australia"],
            correctIndex: 2,
            explanation: "Routes linked Chinese goods with markets across Central Asia toward the Mediterranean.",
            funFact: "💡 Silk was one luxury good, but spices, ideas, and religions moved too."
        ),
        QuizQuestion(
            type: .trueFalse,
            text: "The Titanic sank on its maiden voyage in 1912.",
            options: ["True", "False"],
            correctIndex: 0,
            explanation: "The ocean liner struck an iceberg and sank in the North Atlantic.",
            funFact: "💡 The disaster led to major maritime safety reforms."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Who was known as the 'Maid of Orléans' in French history?",
            options: ["Marie Antoinette", "Catherine de' Medici", "Joan of Arc", "Eleanor of Aquitaine"],
            correctIndex: 2,
            explanation: "Joan of Arc is a national heroine of France for her role in the Hundred Years' War.",
            funFact: "💡 She was later canonized as a saint."
        )
    ]
}
