enum ImagePath {
  base('asset/image'),
  noPage('asset/png/nopage.png'),
  group5357('asset/svg/group5357.svg'),
  user('asset/svg/user.svg'),
  password('asset/svg/password.svg'),
  email('asset/svg/email.svg'),
  like('asset/navigation_bar_icon/heart.svg'),
  home('asset/navigation_bar_icon/home.svg'),
  basket('asset/navigation_bar_icon/shopping_bag.svg'),
  discover('asset/navigation_bar_icon/world.svg'),
  search('asset/navigation_bar_icon/search.svg'),

  pizza('asset/svg/icon_pizza.svg'),
  vegetarian('asset/svg/icon_vegetables.svg'),
  muffin('asset/svg/icon_muffin.svg'),
  chicken('asset/svg/icon_chicken.svg'),

  salad('asset/svg/icon_salad.svg'),
  bread('asset/svg/icon_bread.svg'),
  broccoli('asset/svg/icon_broccoli.svg'),
  carrot('asset/svg/icon_carrot.svg'),
  eggplant('asset/svg/icon_eggplant.svg'),
  egg('asset/svg/icon_eggs.svg'),
  fish('asset/svg/icon_fish.svg'),
  milk('asset/svg/icon_milk.svg'),
  onion('asset/svg/icon_onion.svg'),
  peas('asset/svg/icon_peas.svg'),
  potato('asset/svg/icon_potato.svg'),
  tomato('asset/svg/icon_tomato.svg'),

  dinner('asset/png/dinner.png'),
  appetizers('asset/png/appetizers.png'),
  breakfast('asset/png/breakfast.png'),
  desserts('asset/png/desserts.png'),
  lunch('asset/png/lunch.png'),
  drinks('asset/png/drinks.png'),
  refrigerator('asset/png/refrigerator.png'),
  login('asset/svg/login.svg');

  const ImagePath(this.path);
  final String path;
}
