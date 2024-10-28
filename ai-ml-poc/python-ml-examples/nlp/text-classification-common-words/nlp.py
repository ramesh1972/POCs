import nltk

def get_most_common_words(textual_data, n):
        """
        This function is used to extract the most common words from the submitted textual information.
        :param textual_data: Textual information
        :param n: The number of words to extract from the input.
        :return: The most common words from the input.
        :rtype: list
        """
        words = nltk.word_tokenize(textual_data.lower())
        frequency_distribution = nltk.FreqDist(words)
        most_common = frequency_distribution.most_common(n)
        return most_common

print(get_most_common_words("This is a bad movie. This movie needs a remake. The movie is bad and boring", 5))