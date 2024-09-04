import '../../utils/app_constants.dart';
import '../model/language.dart';

class LanguageRepo {
  List<LanguageModel> getAllLanguages() {
    return AppConstants.languages;
  }
}
