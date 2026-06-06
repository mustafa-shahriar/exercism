object Anagram {

  def findAnagrams(word: String, possible: List[String]): List[String] = {
    possible.filter(w =>
      w.length() == word.length() &&
        w.toLowerCase().sorted() == word.toLowerCase().sorted()
    )
  }
}
