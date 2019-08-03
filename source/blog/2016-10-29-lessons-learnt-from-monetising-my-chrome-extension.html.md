---
layout: post
title: Lessons learnt from monetising my Chrome Extension
categories:
 – blog
published: true
meta:
  description: I made £170.35 over 3 months, and I made a bunch of mistakes along the way!
  index: true
  skip_monetization: true
  image: /uploads/2016/07/02/1400x560_marquee-halfsize.jpg
---

{% img src: /uploads/2016/07/02/1400x560_marquee-halfsize.jpg width: 1400 alt: "LivePage marquee image with it's new logo on a code background" href: https://chrome.google.com/webstore/detail/livepage/pilnojpmdoofaelbinaeodfpjheijkbh?hl=en?utm_source=blog&utm_medium=web&utm_campaign=followup %}

In July 2016 I [started charging for my Chrome Extension](/2016/07/03/why-im-charging-for-livepage.html) [LivePage](https://chrome.google.com/webstore/detail/livepage/pilnojpmdoofaelbinaeodfpjheijkbh?hl=en?utm_source=blog&utm_medium=web&utm_campaign=followup), a simple development tool that I had built back in 2011 to reload web pages as I was building them. 

I didn't have a massive "I'll be living on passive income soon" party, nor did I invest in advertising. I just changed the price, then went off to my local pub. I was a little sceptical people would be willing to pay for something that had been free for so many years, but as sales started I had no doubt it in my mind that it was the best move.

## Income after two months

After two months of being a paid chrome extension I had earned a total of £170.35, the bulk of that being after I removed the free trial.

| Install Type                     | Daily Average Impressions | Daily Average Installs | Monthly Sales Total |
| -------------------------------- | ------------------------- | ---------------------- | ------------------: |
| Free                             | 560                       | 55                     | £0                  |
| Annual Subscription (With trial) | 441                       | 32                     | £28.82              |
| Annual Subscription Only         | 489                       | 8                      | £141.53             |

For an extension that I had been developing in my spare time for free, these are fantastic results. 

If sales continue at roughly the same rate (~£100 a month), potentially I can spend up to one month a year working solely on supporting LivePage, or any other side projects that tickle my interest. This is incredible!

## Unpaid installs

As LivePage was initially open source, I've never been worried about people sharing the paid copies (it's super easy to do with chrome extensions!). In fact, on the [LivePage GitHub repo](https://github.com/MikeRogers0/LivePage#running-development-version-in-chrome) I even included instructions on getting the development version running.

{% img src: /uploads/2016/09/livepage-users.jpg width: 1015 alt: "Screenshot of chrome web store showing 90k users" title: "On 4th October 2016 I had a spike of 90k weekly active users" %}

To give an idea of the amount of unpaid installs, for most of 2016 when LivePage was free it had an average of 25,000 weekly users. After the first month of being a Annual Subscription (With trial), it had grown to ~30,000 weekly users while only achieving 95 sales.

It's crazy that adding a small price has increased the weekly users so much! I'm doubtful that I'll be able to convert these users to paid users, but I did add a note to the  options page requesting users leave a review in the Google Chrome Store.

## Dropping rankings & removing the free trial

When LivePage was free I ranked somewhere in the middle of the [Developer Tools](https://chrome.google.com/webstore/category/ext/11-web-development?_feature=4stars) Chrome Web Store category. After switching to a free trial, the rankings dropped suddenly. 

{% img src: /uploads/2016/09/livepage-chrome-store-rankings.jpg width: 967 alt: "Falling to the bottom makes investing in the promotional images so worth it." %}

A quick search online suggested adding translations to the extension would help remedy the drop in ranking. After investing in human translations via the Chrome Web Store tools, I noticed no change in the ranking. I did start getting a few more international (non English) sales.

It turned out the free trial was to blame. One of the main Chrome Web Store ranking signals is the uninstall rate. What I discovered was the uninstall rate increased dramatically when the free trial was enabled, I suspect because users would prefer to uninstall then to upgrade.

After removing the free trial, my sales increased and ranking stopped dropping. If I was to release a monetised extension again I would not bother with the free trial, instead I'd focus on internationalization (translations and simple copy) & possibly advertising.

## Keeping it open source & adding landing Page

I've managed to keep the extension totally open source (under the GNU Affero General Public License), which is awesome. But even better, since charging I've had my users pushing me (and helping me) towards adding useful features. I'd especially like to thank [Andy Richardson](https://github.com/andyrichardson), who helped me make a [decent landing page](https://livepage.mikerogers.io/)! 

I'd still be wary about developing a paid for product in an open source environment. Though I'd definitely push people towards open sourcing aspects of their source code so people can push some OSS on on it.

## Support 

Overall support requests (the main reason I switched to a paid model) have decreased to a sustainable level. I still receive emails from users requesting free copies, asking for help with their bat shit crazy development environments (Ask me about it over a beer!) or just submitting shitty reviews in the chrome web store (e.g. "The extension is great, but if it drove my car I'd give it 5 stars. So just 4 stars!"). Luckily they are few and far between now.

{% img src: /uploads/2016/09/livepage-support.jpg width: 991 alt: "The only way I know if a user has requested support was if (1) was added to the link" %}

I did experiment with the Chrome Web Stores built in support system (as pictured above), but it felt so lacking in functionality I opted to disable it. 
My main annoyance with the Chrome Web Store, is that it does not send a notification for when a user submits a ticket or review. The only way I could see if a user had submitted a ticket was by logging into the Chrome Web Stores developer panel and seeing the "(1)" in the "User Feedback" link. I decided to disable this feature as I could totally see myself forgetting to check the dashboard & inadvertently annoying a user.

## Conclusion

I'm really glad I decided to charge for something I had built. It validated to myself that LivePage is a product people will pay for & that I can build things people are happy to pay for. I'm not going to retire on it's sales, far from it, but I can justify more time to work on other side projects & keep developing LivePage.
