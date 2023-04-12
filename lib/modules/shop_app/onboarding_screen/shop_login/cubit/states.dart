import 'package:untitled13/models/user/shop_app/add_favourites.dart';
import 'package:untitled13/models/user/shop_app/login_model.dart';

abstract class ShopStates{}
class ShopInitialState extends ShopStates{}
class ShopChangeBottomHomeDataState extends ShopStates{}
class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessBottomHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{}
class ShopSuccessCategoriesState extends ShopStates{}
class ShopErrorCategoriesState extends ShopStates{}
class ShopSuccessChangeFavouriteState extends ShopStates
{
  final ChangeFavoritesModel model;
  ShopSuccessChangeFavouriteState(this.model);
}
class ShopChangeFavouriteState extends ShopStates{}
class ShopErrorChangeFavouritesState extends ShopStates{}
class ShopSuccessGetFavouriteState extends ShopStates{}
class ShopLoadingGetFavouriteState extends ShopStates{}
class ShopErrorGetFavouriteState extends ShopStates{}
class ShopSuccessUserDataState extends ShopStates
{
  final ShopLoginModel loginModel;
  ShopSuccessUserDataState(this.loginModel);
}
class ShopLoadingUserDataState extends ShopStates{}
class ShopErrorUserDataState extends ShopStates{}
class ShopSuccessUpdateUserState extends ShopStates
{
  final ShopLoginModel loginModel;
  ShopSuccessUpdateUserState(this.loginModel);
}
class ShopLoadingUpdateUserState extends ShopStates{}
class ShopErrorUpdateUserState extends ShopStates{}