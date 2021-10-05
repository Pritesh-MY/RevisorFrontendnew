class Types {
  static bool isSpecialTypeQuestion(int type) {
    return type != 4;
  }
}

abstract class QuestionType {
  static const MCQ = 1;
  static const CHECK_BOX = 2;
  static const MATCH_THE_FOLLOWING = 3;
  static const FILL_IN_THE_BLANKS = 4;
  static const ODD_ONE_OUT = 5;
  static const GIVE_ONE_WORD = 6;
  static const TRUE_OR_FALSE = 7;
  static const ASSERTION_AND_REASONING = 8;
  static const IMAGE = 9;
  static const ONE_LINER_WITH_KEYWORD = 10;
}

abstract class AnswerType {
  static const SINGLE_SELECT = 1;
  static const MULTIPLE_SELECT = 2;
  static const DRAG_DROP = 3;
  static const MATCH = 7;
  static const Text_Input_One_Word = 6;
  static const INPUT_TEXT = 4;
   static const GIVE_REASON = 5;
}

/*{
MCQs = 1,
Check_Box = 2,
Match_the_Column = 3,
Fill_in_the_blanks = 4,
Odd_One_Out = 5,
Give_One_Word = 6,
True_False = 7,
Assertion_Reasoning = 8,
Image_Type = 9,
}
public enum AnswerType
{
  Single_Select = 1,
Multi_Select = 2,
Drag_Drop = 3,
Text_Input = 4,
Give_Reason = 5,
Text_Input_One_Word = 6,
Match = 7,
}*/
