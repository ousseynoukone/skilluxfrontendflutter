enum FeedType {
  recommendedPosts('recommended-posts'),
  followedUserPosts('followed-user-posts'),
  randomPosts('random-posts');

  final String value;
  
  const FeedType(this.value);

}


  String getFeedTypeDisplayName(FeedType value, var text) {
  switch (value) {
    case FeedType.recommendedPosts:
      return text.recommendedPosts; // Adjust based on your localization setup
    case FeedType.followedUserPosts:
      return text.followedUserPosts; // Adjust based on your localization setup
    case FeedType.randomPosts:
      return text.randomPosts; // Adjust based on your localization setup
    default:
      return text.defaultFeed; // Optional: handle default case
  }
}

