class VideosList {
  String userName, daysAgo, title, location, category;
  VideosList({
    required this.category,
    required this.daysAgo,
    required this.location,
    required this.title,
    required this.userName,
  });
}

List<VideosList> videoslist = [
  VideosList(
    category: "funny",
    daysAgo: "5 days",
    location: "tripoli",
    title: "lol 1",
    userName: "test1",
  ),
  VideosList(
    category: "politics",
    daysAgo: "1 day",
    location: "tripoli",
    title: "lol 5",
    userName: "test2",
  ),
  VideosList(
    category: "kitchen",
    daysAgo: "2 days",
    location: "bangazi",
    title: "lol 4",
    userName: "test3",
  ),
  VideosList(
    category: "design",
    daysAgo: "7 days",
    location: "tarhuna",
    title: "lol 3",
    userName: "test4",
  ),
  VideosList(
    category: "WOW",
    daysAgo: "1 day",
    location: "Libya",
    title: "lol 2",
    userName: "test5",
  ),
];
