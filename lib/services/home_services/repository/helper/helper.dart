enum FeedType {
  recommendedPosts('recommended-posts'),
  followedUserPosts('followed-user-posts'),
  randomPosts('random-posts');

  final String value;
  
  const FeedType(this.value);

}