// https://newsapi.org/v2/everything?q=bi&apiKey=ca2b29db6d8e40bf94fc0386580f1f0d
import '../../modules/shop_app/onboarding_screen/shop_login/login/shop_login_screen.dart';
import '../network/local/cache.helper.dart';
import 'components.dart';

void signOut(context)
{
  CacheHelper.RemoveData(key: 'token').then((value) {
    if (value!) {
      navigateAndFinish(context, ShopLoginScreen());
    }
  });

}
void printFullText(String text)
{
  final pattern=RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match)=>print(match.group(0)));
}
String?token='';
String? uId='';