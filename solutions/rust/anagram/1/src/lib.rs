use std::collections::HashSet;

fn sorted_chars(s: &str) -> String {
    let mut chars: Vec<char> = s.chars().collect();
    chars.sort();
    chars.into_iter().collect()
}

pub fn anagrams_for<'a>(word: &str, possible_anagrams: &[&'a str]) -> HashSet<&'a str> {
    let sorted_word = sorted_chars(word);

    let mut anagram_set = HashSet::new();

    for &possible_anagram in possible_anagrams {
        if sorted_chars(possible_anagram) == sorted_word {
            anagram_set.insert(possible_anagram);
        }
    }

    anagram_set
}
