# Assignment 3 - Twitter

Twitter is a client using twitter API

Submitted by: **Randy Zhao**

Time spent: **25** hours spent in total

## User Stories

The following stories have been implemented.

- [x] User can sign in using OAuth login flow
- [x] User can view last 20 tweets from their home timeline
- [x] The current signed in user will be persisted across restarts
- [x] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp. In other words, design the custom cell with the proper Auto Layout settings. You will also need to augment the model classes.
- [x] User can pull to refresh
- [x] User can compose a new tweet by tapping on a compose button.
- [x] User can tap on a tweet to view it, with controls to retweet, favorite, and reply.

Hamburger menu
- [x] Dragging anywhere in the view should reveal the menu.
- [x] The menu should include links to your profile, the home timeline, and the mentions view.

Profile page
- [x] Contains the user header view (implemented as a custom view)
- [x] Contains a section with the users basic stats: # tweets, # following, # followers

Home Timeline
- [x] Tapping on a user image should bring up that user's profile page
- [x] Optional: Retweeting and favoriting should increment the retweet and favorite count.
- [x] Optional: Replies should be prefixed with the username and the reply_id should be set when posting the tweet,

## Video walkthrough

The following stories have been implemented.

![1](http://i.imgur.com/BoZgHVt.gif)

![2](http://i.imgur.com/YEJsm2w.gif)

## Bugs

1. The profile page does not have a scrollview. User may find the tweets table view too short
2. The profile image in the profile page is not centered in wider screen


## License

    Copyright [2016] [Randy Zhao]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
