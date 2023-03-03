//
//  preprocessing.swift
//  SwiftNLP
//
//  Created by Jim Wallace on 2023-03-02.
//

import Foundation
import NaturalLanguage


let STOPWORDS: Set<String> = [
"all", "six", "just", "less", "being", "indeed", "over", "move", "anyway", "four", "not", "own", "through", "using", "fifty", "where", "mill", "only", "find", "before", "one", "whose", "system", "how", "somewhere", "much", "thick", "show", "had", "enough", "should", "to", "must", "whom", "seeming", "yourselves", "under", "ours", "two", "has", "might", "thereafter", "latterly", "do", "them", "his", "around", "than", "get", "very", "de", "none", "cannot", "every", "un", "they", "front", "during", "thus", "now", "him", "nor", "name", "regarding", "several", "hereafter", "did", "always", "who", "didn", "whither", "this", "someone", "either", "each", "become", "thereupon", "sometime", "side", "towards", "therein", "twelve", "because", "often", "ten", "our", "doing", "km", "eg", "some", "back", "used", "up", "go", "namely", "computer", "are", "further", "beyond", "ourselves", "yet", "out", "even", "will", "what", "still", "for", "bottom", "mine", "since", "please", "forty", "per", "its", "everything", "behind", "does", "various", "above", "between", "it", "neither", "seemed", "ever", "across", "she", "somehow", "be", "we", "full", "never", "sixty", "however", "here", "otherwise", "were", "whereupon", "nowhere", "although", "found", "alone", "re", "along", "quite", "fifteen", "by", "both", "about", "last", "would", "anything", "via", "many", "could", "thence", "put", "against", "keep", "etc", "amount", "became", "ltd", "hence", "onto", "or", "con", "among", "already", "co", "afterwards", "formerly", "within", "seems", "into", "others", "while", "whatever", "except", "down", "hers", "everyone", "done", "least", "another", "whoever", "moreover", "couldnt", "throughout", "anyhow", "yourself", "three", "from", "her", "few", "together", "top", "there", "due", "been", "next", "anyone", "eleven", "cry", "call", "therefore", "interest", "then", "thru", "themselves", "hundred", "really", "sincere", "empty", "more", "himself", "elsewhere", "mostly", "on", "fire", "am", "becoming", "hereby", "amongst", "else", "amongst", "else", "part", "everywhere", "too", "kg", "herself", "former", "those", "he", "me", "myself", "made", "twenty", "these", "was", "bill", "cant", "us", "until", "besides", "nevertheless", "below", "anywhere", "nine", "can", "whether", "of", "your", "toward", "my", "say", "something", "and", "whereafter", "whenever", "give", "almost", "wherever", "is", "describe", "beforehand", "herein", "doesn", "an", "as", "itself", "at", "have", "in", "seem", "whence", "ie", "any", "fill", "again", "hasnt", "inc", "thereby", "thin", "no", "perhaps", "latter", "meanwhile", "when", "detail", "same", "wherein", "beside", "also", "that", "other", "take", "which", "becomes", "you", "if", "nobody", "unless", "whereas", "see", "though", "may", "after", "upon", "most", "hereupon", "eight", "but", "serious", "nothing", "such", "why", "off", "a", "don", "whereby", "third", "i", "whole", "noone", "sometimes", "well", "amoungst", "yours", "their", "rather", "without", "so", "five", "the", "first", "with", "make", "once"
]


// TODO: Built-in constants?
//let RE_PUNCT = try! NSRegularExpression(pattern: "([(NSRegularExpression.escapedPattern(for: String.punctuationCharacters))])+")
let RE_TAGS = try! NSRegularExpression(pattern: "<([^>]+)>")
let RE_NUMERIC = try! NSRegularExpression(pattern: "[0-9]+")
//let RE_NONALPHA = try! NSRegularExpression(pattern: "\W")
//let RE_AL_NUM = try! NSRegularExpression(pattern: "([a-z]+)([0-9]+)", options: .unicode)
//let RE_NUM_AL = try! NSRegularExpression(pattern: "([0-9]+)([a-z]+)", options: .unicode)
//let RE_WHITESPACE = try! NSRegularExpression(pattern: "(\s)+")

func removeStopwords(_ s: String, stopwords: Set<String>? = nil) -> String {
    var stopwords = stopwords ?? STOPWORDS
    //var tokens = tokenize(s)
    var resultTokens = [String]()
    //for token in tokens {
//        if !stopwords.contains(token) {
//            resultTokens.append(token)
//        }
//    }
    return resultTokens.joined(separator: " ")
}


func removeStopwordTokens(tokens: [String], stopwords: Set<String>? = nil) -> [String] {
    let stopWords = stopwords ?? STOPWORDS
    return tokens.filter { !stopWords.contains($0) }
}



/**
 Replaces ASCII punctuation characters with spaces in a string.
 - Parameter s: The input string to be processed.
 - Returns: A new string with punctuation characters replaced by spaces.
 - Example: `stripPunctuation("A semicolon is a stronger break than a comma, but not as much as a full stop!")`
 returns `"A semicolon is a stronger break than a comma  but not as much as a full stop "`
 */
func stripPunctuation(_ s: String) -> String {
    let regex = try! NSRegularExpression(pattern: #"[\p{P}]"#)
    let range = NSMakeRange(0, s.utf16.count)
    return regex.stringByReplacingMatches(in: s, options: [], range: range, withTemplate: " ")
}


/// Remove tags from the input string.
///
/// - Parameter s: The input string with tags.
///
/// - Returns: A string without any tags.
///
/// - Throws: An error if the regular expression pattern cannot be compiled.
///
/// - Example:
/// ```
/// stripTags("<i>Hello</i> <b>World</b>!")
/// // Returns: "Hello World!"
/// ```
func stripTags(_ s: String) -> String {
    let range = NSRange(location: 0, length: s.utf16.count)
    let strippedString = RE_TAGS.stringByReplacingMatches(in: s, range: range, withTemplate: "")
    return strippedString
}


/**
 Removes words with length lesser than `minsize` from `s`.
 
 - Parameters:
     - s: The input string.
     - minsize: The minimum length of words to keep.
 
 - Returns: A Unicode string without short words.
 
 - Example:
     ```
     let result1 = stripShort("salut les amis du 59")
     // result1 = "salut les amis"
     
     let result2 = stripShort("one two three four five six seven eight nine ten", minsize: 5)
     // result2 = "three seven eight"
     ```
 */
func stripShort(_ s: String, minsize: Int = 3) -> String {
    let tokens = s.split(separator: " ")
    let longTokens = tokens.filter { $0.count >= minsize }
    return longTokens.joined(separator: " ")
}


/**
 Removes tokens shorter than `minsize` characters.

 - Parameters:
    - tokens: A sequence of strings.
    - minsize: The minimal length of a token to keep (inclusive).
 
 - Returns: A list of strings without short tokens.
 */
func removeShortTokens(from tokens: [String], minsize: Int = 3) -> [String] {
    return tokens.filter { $0.count >= minsize }
}


/**
    Remove digits from a string.
     
    - Parameter s: A string.
    - Returns: A string without digits.
     
    - Example:
    ```
    let text = "0text24gensim365test"
    let result = stripNumeric(text)
    print(result) // "textgensimtest"
    ```
 */
func stripNumeric(_ s: String) -> String {
    //let s = utils.toUnicode(s)
    return RE_NUMERIC..sub("", s)
}

