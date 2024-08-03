import 'package:skilluxfrontendflutter/models/post/post.dart';

bool areListsEqual(List<String> list1, List<String> list2) {
  // Check if both lists are the same length
  if (list1.length != list2.length) {
    return false;
  }

  // Check if all elements are equal
  for (int i = 0; i < list1.length; i++) {
    if (list1[i] != list2[i]) {
      return false;
    }
  }

  return true;
}

bool checkEquality(Post postA, Post postB) {
  return postA.id == postB.id &&
      postA.title == postB.title &&
      postA.content == postB.content &&
      areListsEqual(postA.tags, postB.tags);
}
