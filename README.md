## Introduction
### Background
With the expansion of the Internet, there has also been a growing interest in online news, which allows for
the easy and fast spread of information. The internet provides a constant stream of news articles, making
it difficult for audiences to keep up and make informed decisions about what news to consume. Hence,
understanding the factors influencing popularity is valuable for authors, content providers, advertisers,
and activists/politicians. Predicting the popularity of online news has emerged as a recent research
trend to better reach target audiences. Popularity is often measured by considering the number of
interactions on the Web and social networks (e.g., number of shares, likes, and comments). By identifying
what makes news popular, creators can focus on elements that resonate with the audience and increase
engagement and potentially higher revenue. This could involve specific writing styles, headlines, content
formats, or even publishing articles on certain days over others.
### Project Goals
The project aims to investigate various factors influencing the popularity of articles. We aim to explore
the relationship between image and video count and article popularity. Additionally, our goal is to
examine the influence of data channels on article shares, to reveal if any significant effects on popularity
exist. We seek to uncover patterns related to the day of publication (weekend, weekday, etc) to check if
this correlates with higher shares. Furthermore, our project endeavors to analyze the impact of title length
on popularity, recognizing variations across different categories. Lastly, we aim to understand the role of
keywords in influencing article popularity, recognizing their differential impact across categories.

#### Team Members:
|         Name         |      GitHub       |
|:--------------------:|:-----------------:|
| **Abhinav Duvvuri**  |    *abhinavdv*    |
|  **Mihir Ghatani**   |  *mihirghatani*   |
|   **Navya Eedula**   | *navya-eedula-uw* |
| **Sushma Vankayala** | *sushmavankayala* |
|  **Swarali Desai**   |  *swarali-desai*  |

## Dataset
### Description
The selected dataset comprises a total of 39,644 articles scraped from Mashable over two years,
sourced from the UCI repository. These articles span from January 7th, 2013, to January 7th, 2015. The
data contains a list of characteristics that describe different aspects of the article and that were considered
relevant to influence the number of shares. The variables used in this study include shares, number of
images, number of videos, type of data channel, day of publication, title length, content length, and
keyword metrics. The data has already been preprocessed - categorical and boolean variables have been
encoded, among other steps. Certain columns are calculated fields (ex: all the keyword-related fields).

The dataset is available here:  https://archive.ics.uci.edu/dataset/332/online+news+popularity

### Study Design
We assume that the articles present in this dataset are the population of all Mashable articles produced
within the specified timeframe. We operate under the assumption that the calculated fields are reliable for
our analysis. We confirm that there are no null values in the dataset. This dataset pertains to an
observational study, wherein we've aimed to offer valuable insights into variable relationships. However,
we acknowledge the limitations inherent in proving causation within observational studies.
For our analysis, we have used the number of shares as a measure of popularity. Additionally, in select
analyses, we defined a threshold to distinguish popular from non-popular articles, considering the top 1%
(those with over 30,000 shares) as popular. This user-defined column was utilized in analyses of logistic
regression. All data visualizations, as well as statistical analyses, were conducted using statistical software
(e.g., R, Python), and at a significance level set at α = 0.05.

## Questions

1. Does multimedia usage vary across categories, and does it impact article popularity?
   -  Is the proportion of articles with images/videos different across categories?
   -  Understanding the influence of multimedia content on the popularity of an article.
2. Do certain data channels produce less or more popular news articles online?
3. How do the publication day and channel affect the popularity of a news article?
    - Does news article popularity vary significantly among different days of the week?
    - Does news article popularity vary significantly between weekdays and weekends?
    - Are there specific news channels that outperform the rest on the weekends?
4. Do keywords affect the popularity of an article?
5. Do title length and content length impact the popularity of an article?