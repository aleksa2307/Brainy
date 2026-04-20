import Foundation

extension ThemedQuizPools {

    static let music: [QuizQuestion] = [
        QuizQuestion(
            type: .multipleChoice,
            text: "How many keys does a standard modern piano have?",
            options: ["76", "88", "92", "66"],
            correctIndex: 1,
            explanation: "Most pianos span 88 keys from A0 to C8.",
            funFact: "💡 The piano combines percussion and string resonance in one instrument."
        ),
        QuizQuestion(
            type: .trueFalse,
            text: "The Beatles were originally from Liverpool.",
            options: ["True", "False"],
            correctIndex: 0,
            explanation: "The Fab Four emerged from Liverpool's Merseybeat scene.",
            funFact: "💡 They played the Cavern Club often in their early years."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "What does 'forte' mean in music dynamics?",
            options: ["Soft", "Loud", "Slow", "Fast"],
            correctIndex: 1,
            explanation: "'Forte' indicates a loud passage (often marked 'f').",
            funFact: "💡 'Piano' means soft — hence the instrument means 'soft-loud.'"
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Which composer became deaf later in life yet wrote symphonic masterpieces?",
            options: ["Mozart", "Beethoven", "Bach", "Haydn"],
            correctIndex: 1,
            explanation: "Ludwig van Beethoven continued composing as his hearing declined.",
            funFact: "💡 His Ninth Symphony choral finale is universally recognizable."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "In Western notation, how many flats are in F major's key signature?",
            options: ["None", "One", "Two", "Three"],
            correctIndex: 1,
            explanation: "F major uses one flat: B♭.",
            funFact: "💡 Key signatures group sharps or flats after the clef."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Which tempo marking means 'very slow'?",
            options: ["Allegro", "Adagio", "Presto", "Vivace"],
            correctIndex: 1,
            explanation: "'Adagio' indicates a slow, stately tempo.",
            funFact: "💡 'Allegro' means fast; 'presto' means very fast."
        ),
        QuizQuestion(
            type: .trueFalse,
            text: "A ukulele typically has four strings.",
            options: ["True", "False"],
            correctIndex: 0,
            explanation: "The standard ukulele is a four-stringed lute family instrument.",
            funFact: "💡 It became strongly associated with Hawaiian music."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Who is known as the 'King of Pop'?",
            options: ["Prince", "David Bowie", "Michael Jackson", "Elvis Presley"],
            correctIndex: 2,
            explanation: "Michael Jackson earned global fame for dance-pop innovation.",
            funFact: "💡 'Thriller' remains one of the best-selling albums."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "In a jazz 'swing' rhythm, what is often emphasized?",
            options: ["Downbeats only", "Offbeats / ride pattern feel", "Triple meter only", "Silent rests"],
            correctIndex: 1,
            explanation: "Swing subdivisions lean into a long-short pulse and ride cymbal patterns.",
            funFact: "💡 Duke Ellington and Count Basie helped define big-band swing."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Which ensemble typically has four string sections: 1st & 2nd violins, violas, cellos, basses?",
            options: ["Brass band", "Symphony orchestra", "Marching band", "Gamelan"],
            correctIndex: 1,
            explanation: "The classical orchestra core includes those bowed string families.",
            funFact: "💡 The string section often carries the melody and harmony together."
        ),
        QuizQuestion(
            type: .trueFalse,
            text: "The Grammy Awards primarily honor achievements in recorded music.",
            options: ["True", "False"],
            correctIndex: 0,
            explanation: "Recording Academy members vote on Grammy categories yearly.",
            funFact: "💡 The trophy depicts an antique gramophone."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "A major triad is built from root, third, and which interval?",
            options: ["Second", "Fourth", "Fifth", "Seventh"],
            correctIndex: 2,
            explanation: "Major chords stack root, major third, and perfect fifth.",
            funFact: "💡 Minor triads lower the third by a half step."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Which genre blends Jamaican mento, ska, and American R&B influences?",
            options: ["Reggae", "Flamenco", "Polka", "Tango"],
            correctIndex: 0,
            explanation: "Reggae evolved mid-20th century with artists like Bob Marley worldwide.",
            funFact: "💡 The offbeat guitar 'chop' is a reggae hallmark."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Opera combines staged drama with primarily what kind of singing?",
            options: ["Chanted rap", "Classically trained vocal technique", "Whisper vocals only", "Beatboxing"],
            correctIndex: 1,
            explanation: "Opera features trained voices (soprano, tenor, etc.) over orchestra.",
            funFact: "💡 Verdi and Puccini helped Italian opera conquer theatres globally."
        ),
        QuizQuestion(
            type: .trueFalse,
            text: "A metronome marks tempo in beats per minute (BPM).",
            options: ["True", "False"],
            correctIndex: 0,
            explanation: "Composers set metronome marks like ♩ = 120 for performers.",
            funFact: "💡 Digital DAWs replaced many mechanical wind-up devices."
        )
    ]

    static let sports: [QuizQuestion] = [
        QuizQuestion(
            type: .multipleChoice,
            text: "How many players does each team field in association football (soccer) during play?",
            options: ["10", "11", "12", "9"],
            correctIndex: 1,
            explanation: "Eleven outfield roles include goalkeeper regulations.",
            funFact: "💡 FIFA governs the Laws of the Game worldwide."
        ),
        QuizQuestion(
            type: .trueFalse,
            text: "The Olympic Games are held every four years (summer/winter alternating in modern era).",
            options: ["True", "False"],
            correctIndex: 0,
            explanation: "The Summer and Winter Games now offset on a four-year cycle since 1994.",
            funFact: "💡 The five rings symbolize continents (as traditionally grouped)."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "In basketball, how many points is a shot made behind the NBA three-point arc worth?",
            options: ["1", "2", "3", "4"],
            correctIndex: 2,
            explanation: "A successful shot from beyond the arc counts for three points.",
            funFact: "💡 The three-point line distance varies slightly by league."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "In tennis, holding advantage and winning the next point wins the ____.",
            options: ["set", "match", "tiebreak", "game"],
            correctIndex: 3,
            explanation: "A game finishes when a player leads by two points after deuce or converts advantage.",
            funFact: "💡 Love may derive from French 'l'œuf' (egg) for zero."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Which distance is a standard marathon?",
            options: ["32.195 km", "40.000 km", "42.195 km", "50 km"],
            correctIndex: 2,
            explanation: "The marathon is standardized at 42.195 km (26 miles 385 yards).",
            funFact: "💡 The legend traces to Pheidippides — accuracy debated."
        ),
        QuizQuestion(
            type: .trueFalse,
            text: "Cricket uses wickets and overs.",
            options: ["True", "False"],
            correctIndex: 0,
            explanation: "Batting and bowling revolve around balls, overs, and wicket dismissals.",
            funFact: "💡 Test matches can last up to five days."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "In American football, a touchdown is typically worth how many points before the extra try?",
            options: ["3", "6", "7", "2"],
            correctIndex: 1,
            explanation: "A touchdown scores six; teams often add one or two on conversion attempts.",
            funFact: "💡 A field goal counts three points."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Which major golf tournament is played annually at Augusta National?",
            options: ["The Open", "US Open", "The Masters", "PGA Championship"],
            correctIndex: 2,
            explanation: "The Masters is one of golf's four majors with the famous Green Jacket.",
            funFact: "💡 Amen Corner is a famous stretch of holes."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "In baseball, how many strikes retire a batter?",
            options: ["2", "3", "4", "5"],
            correctIndex: 1,
            explanation: "Three strikes and you're out — unless the third is a foul with two strikes.",
            funFact: "💡 Four balls award a walk."
        ),
        QuizQuestion(
            type: .trueFalse,
            text: "Ice hockey goals are guarded by a goaltender ('goalie').",
            options: ["True", "False"],
            correctIndex: 0,
            explanation: "Nets behind creases are defended by padded goaltenders.",
            funFact: "💡 The Stanley Cup is the NHL's championship trophy."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Which sport features a scrum?",
            options: ["Volleyball", "Rugby", "Badminton", "Curling"],
            correctIndex: 1,
            explanation: "Rugby union packs contest the ball in scrums after certain stoppages.",
            funFact: "💡 Rugby sevens is a faster Olympic variant."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "How long is a standard professional boxing round (men's championship)?",
            options: ["2 minutes", "3 minutes", "5 minutes", "4 minutes"],
            correctIndex: 1,
            explanation: "Many men's pro title fights use three-minute rounds (women's often two).",
            funFact: "💡 The bell between rounds is a boxing tradition."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "In Formula 1, what flag signals the end of a race?",
            options: ["Red", "Yellow", "Black", "Chequered"],
            correctIndex: 3,
            explanation: "The chequered flag waves as the winner crosses the line — ending the session.",
            funFact: "💡 DRS helps overtaking on certain straights."
        ),
        QuizQuestion(
            type: .trueFalse,
            text: "Swimming Olympic pool length for long course is 50 metres.",
            options: ["True", "False"],
            correctIndex: 0,
            explanation: "Long-course meets use 50 m lanes; short course is often 25 m.",
            funFact: "💡 Michael Phelps holds the record for most Olympic golds among swimmers."
        ),
        QuizQuestion(
            type: .multipleChoice,
            text: "Which sport awards the yellow jersey (maillot jaune) for overall race classification?",
            options: ["Tour de France cycling", "Ski jumping", "Sailing America's Cup", "Sumo"],
            correctIndex: 0,
            explanation: "The Tour leader in general classification wears yellow.",
            funFact: "💡 The race has been staged since 1903."
        )
    ]
}
