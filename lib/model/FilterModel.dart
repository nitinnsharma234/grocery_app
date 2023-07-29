
class Filter{
  bool protein=false;
  bool carbs=false;
  bool sugar=false;
  bool fats=false;
  bool fiber=false;

  resetFilter(){
    protein=false;
     carbs=false;
     sugar=false;
     fats=false;
     fiber=false;
  }
  static final Filter _instance = Filter._internal();

  factory Filter() {
    return _instance;
  }
  Filter._internal();

}