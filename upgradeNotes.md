# upgradeNotes
Shunji's Kingdom 5.0 upgrade notes


## data


## code
**motivation**
I have been fragmentally written down some notes, but hard to recall them or reference back. So I hope to systematially organize my notes somewhere, so I decided to put everything in markdown, which in convenient to put text and codes togetehr. But there is still not consistent way to view all my notes, so I decided to build a App to be able to easily search and view all my notes.

**design**
Since I have a lot of notes, it is not efficient and feasible to hard code eveyrthing. So I designed an ideal app that can only pass minumum metadata `{ noteTitle: 'some_text', url: 'some_github_url'}` as props, and it will automatically build everything for me.

**implementation**
There are two main component of the app.

First component is a view component that takes an url, fetch data from github, and parse markdown data to render. I used a library called `ReactMarkdown` to achieve this. However this is not enough, since this will only render black and white content, which is not sufficient for code view. So I had to pull in another library `SyntaxHighlighter` and wrap this to be a custom render component. By combining these two libraries, the viewing componenet is able to take care of rendering everything just by given an url to the markdown notes.

Second component is the sidebar. Since one motivation that I created this app is to more clearly and conviniently organize my notes, so I need to sidebar navigation to show all contents and current reading content. One function that is hard to implement is the sync between sidebar and main content


