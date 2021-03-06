## Simple Twitter Client

This is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: Week 3 - `~ 20 hrs`, Week 4 - `~20 hrs`

### Features (Week 3)

#### Required

- [x] User can sign in using OAuth login flow
- [x] User can view last 20 tweets from their home timeline
- [x] The current signed in user will be persisted across restarts
- [x] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.  In other words, design the custom cell with the proper Auto Layout settings.  You will also need to augment the model classes.
- [x] User can pull to refresh
- [x] User can compose a new tweet by tapping on a compose button.
- [x] User can tap on a tweet to view it, with controls to retweet, favorite, and reply.
- [x] User can retweet, favorite, and reply to the tweet directly from the timeline feed.

#### Optional

- [ ] When composing, you should have a countdown in the upper right for the tweet limit.
- [ ] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [ ] Retweeting and favoriting should increment the retweet and favorite count.
- [ ] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count.
- [ ] Replies should be prefixed with the username and the reply_id should be set when posting the tweet,
- [ ] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.

### Walkthrough (Week 3)
![twitter-client-reply](https://cloud.githubusercontent.com/assets/1800895/6347678/9a750368-bbce-11e4-94b9-7ec7a6fbe846.gif) ![twitter-client-new](https://cloud.githubusercontent.com/assets/1800895/6347679/9a862a8a-bbce-11e4-9d9b-6c2a2c395bda.gif) ![twitter-client-retweet](https://cloud.githubusercontent.com/assets/1800895/6347680/9a8e28a2-bbce-11e4-9b8f-156b7232dd57.gif) ![twitter-client-fav](https://cloud.githubusercontent.com/assets/1800895/6347681/9a916d50-bbce-11e4-8342-a9aefc895ea0.gif)

### Feature (Week 4)
##### Hamburger menu
- [x] Dragging anywhere in the view should reveal the menu.
- [x] The menu should include links to your profile, the home timeline, and the mentions view.
- [x] The menu can look similar to the LinkedIn menu below or feel free to take liberty with the UI.

##### Profile page
- [x] Contains the user header view
- [x] Contains a section with the users basic stats: # tweets, # following, # followers
- [ ] Optional: Implement the paging view for the user description.
- [ ] Optional: As the paging view moves, increase the opacity of the background screen. See the actual Twitter app for this effect
- [ ] Optional: Pulling down the profile page should blur and resize the header image.

##### Home Timeline
- [x] Tapping on a user image should bring up that user's profile page

### Walkthrough (Week 4)
![twitter-client-menu](https://cloud.githubusercontent.com/assets/1800895/6436380/4470730a-c063-11e4-97cf-1b452be081e1.gif)  ![twitter-client-menu-function](https://cloud.githubusercontent.com/assets/1800895/6436382/46d35752-c063-11e4-88fd-0fa825e2d503.gif)  ![twitter-client-timeline-profile](https://cloud.githubusercontent.com/assets/1800895/6436384/48be858c-c063-11e4-83ba-5534020a9a9b.gif)
