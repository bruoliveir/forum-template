module ProfanityFilter

  def dictionary
    @dictionary ||= YAML.load_file File.join(Rails.root, 'config', 'dictionary.yml')
  end

  def clean(text)
    return text if text.blank?
    text.split(/(\s)/).collect{ |word| clean_word(word) }.join
  end

  def clean_word(word)
    return word unless word.strip.size > 2
    if word.index(/[\W]/)
      word = word.split(/(\W)/).collect{ |subword| clean_word(subword) }.join
      concat = word.gsub(/\W/, '')
      word = concat if dictionary.include?(concat.downcase)
    end

    dictionary.include?(word) ? '*' * (word.size) : word
  end
end
