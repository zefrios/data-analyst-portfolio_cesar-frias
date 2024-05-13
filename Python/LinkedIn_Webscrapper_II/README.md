# LinkedIn Webscrapper II: EDA

Continuing our analysis from [LinkedIn Webscrapper I](Python/LinkedIn_Webscrapper_I/README.md).

## Finding Keywords
The following code uses the spacy Python library to detect LinkedIn job posts in French versus those in English. Then, as a final output we have the words with the highest count for both English and French job posts.

```Python
import pandas as pd
import re
from collections import Counter
import spacy
from langdetect import detect

import requests
import certifi

nlp_en = spacy.load("en_core_web_sm")
nlp_fr = spacy.load("fr_core_news_sm")

df = pd.read_excel(r'LinkedInJobData_MarketingAutomation.xlsx')

def detect_language(text):
    try:
        return detect(text)
    except:
        return None
    
def preprocess_text(text, detected_language):
    if not isinstance(text, str):
        return ''
    
    text = text.lower()

    combined_stopwords = nlp_en.Defaults.stop_words.union(nlp_fr.Defaults.stop_words)


    if detected_language == 'en':
        doc = nlp_en(text)
    elif detected_language == 'fr':
        doc = nlp_fr(text)
    else:
        return ' '.join([word for word in text.split() if word not in combined_stopwords and len(word) > 1])
    
    tokens = [token.text for token in doc if token.text not in combined_stopwords and not token.is_punct and len(token.text) > 1]
    return ' '.join(tokens)


df['Detected_Language'] = df['description'].apply(detect_language)
df['Processed_Description'] = df.apply(lambda x: preprocess_text(x['description'], x['Detected_Language']), axis=1)


english_descriptions = ' '.join(df[df['Detected_Language'] == 'en']['Processed_Description'])
french_descriptions = ' '.join(df[df['Detected_Language'] == 'fr']['Processed_Description'])


english_tokens = re.findall(r'\b\w+\b', english_descriptions)
english_keyword_counts = Counter(english_tokens)
french_tokens = re.findall(r'\b\w+\b', french_descriptions)
french_keyword_counts = Counter(french_tokens)


top_english_keywords = english_keyword_counts.most_common(10)
top_french_keywords = french_keyword_counts.most_common(10)

print("Top English Keywords:")
for keyword, count in top_english_keywords:
    print(f'{keyword}: {count}')

print("\nTop French Keywords:")
for keyword, count in top_french_keywords:
    print(f'{keyword}: {count}')
```

This is what our final output would look like:  

### Top English Keywords:  
marketing: 81  
experience: 53  
canonical: 51  
data: 44  
team: 42  
skills: 36  
work: 35  
technology: 28  
business: 28  
content: 28  

### Top French Keywords:  
marketing: 117  
équipe: 68  
communication: 45  
expérience: 41  
entreprise: 37  
poste: 37  
clients: 36  
mise: 35  
suivi: 34  

The result turned out to be quite literal and it is evident that there must be context added. Further research needs to be done to imporve our results. Investigation is needed to find if a machine learning model or a dictionary with more relevant terms would yield a better result.

To finish this exercise, a good way to visualize these results would be a word cloud. Python was chosen for the data visualization part since the WordCloud library covers our needs. This is the code used:

```Python
from wordcloud import WordCloud
import matplotlib.pyplot as plt

english_freq_dict = dict(english_keyword_counts)
french_freq_dict = dict(french_keyword_counts)

wordcloud_en = WordCloud(width=800, height=400, background_color='white', color_func=lambda *args, **kwargs: 'blue').generate_from_frequencies(english_freq_dict)
wordcloud_fr = WordCloud(width=800, height=400, background_color='white', color_func=lambda *args, **kwargs: 'red').generate_from_frequencies(french_freq_dict)

plt.figure(figsize=(30, 15))
```

Do mind that the list provided (keyword_counts) needs to be a list of tuples for the code above to work.  

Now, we visualize the English keywords:  

```Python
plt.subplot(1, 2, 1)
plt.imshow(wordcloud_en, interpolation='bilinear')
plt.axis('off')
plt.title('Top English Keywords')
```
![Python_WebScrapperII_1](https://github.com/zefrios/Python/assets/83305620/2473a9f2-d938-46ca-97c3-d1aee2040a05)


Then, the French keywords:  

```Python
plt.subplot(1, 2, 2)
plt.imshow(wordcloud_fr, interpolation='bilinear')
plt.axis('off')
plt.title('Top French Keywords')
```
![Python_WebScrapperII_2](https://github.com/zefrios/Python/assets/83305620/461dce8a-9491-4655-a724-6e3bb6462bef)
