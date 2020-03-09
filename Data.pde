class Data {
  Score[] score;
  String[] data;

  Data(String filename) {
    data = loadStrings(filename);
    score = new Score[data.length];
    println(data.length);
    for (int i = 0; i < data.length; i++) {
      if (data[i] != null) {
        String[] s = data[i].split(": ");
        score[i] = new Score(s[0], int(s[1]));
      }
    }
  }

  boolean find(String name_, int score_)
  {
    String news = name_ + ": " + score_;
    for (int i = 0; i < data.length; i++)
    {
      if (news.equals(data[i]))
      {
        return true;
      }
    }
    return false;
  }

  void set_Name(String name_, int score_) {
    String news = name_ + ": " + score_;
    Score temp = new Score(name_, score_);
    score = (Score[]) append(score, temp);
    data = append(data, news);
  }

  void saveNames(String filename) {
    saveStrings(filename, data);
  }

  void sortNames() {
    for (int i = 1; i < score.length; i++) {
      Score temp = score[i];
      int j = i-1;
      while (j >= 0 && score[j].getScore() > temp.getScore())
      {  
        score[j+1] = score[j];
        j--;
      }
      score[j+1] = temp;
    }
    for (int i = 0; i < data.length; i++) {
      data[i] = score[i].getScoreName() + ": " + score[i].getScore();
    }
    data = reverse(data);
    score = (Score[]) reverse(score);
  }

  int length() {
    return data.length;
  }

  String print(int i)
  {
    return data[i];
  }
}

class Score {
  int score;
  String name;

  Score(String name_, int score_) {
    score = score_;
    name = name_;
  }

  String getScoreName() {
    return name;
  }

  int getScore()
  { 
    return score;
  }
}
