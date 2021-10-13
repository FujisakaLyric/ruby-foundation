def substrings(string, dictionary)
    dictionary.reduce(Hash.new(0)) do |result, dictionary_word|
        string.downcase.gsub(/[^\w\s]/, '').split(" ").each do |word|
            result[dictionary_word] += 1 if word.include?(dictionary_word)
        end
        result
    end
end