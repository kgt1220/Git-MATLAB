function documents = novelsDocuments2()
%SONNETSDOCUMENTS tokenizedDocument array of preprocessed sonnets.
%   sonnetsDocuments imports the sonnets.txt data and prepares it for
%   analysis 

% import the sonnets text data
txt = extractFileText("Harry Potter and the Chamber of Secrets.txt");

% split the sonnets into paragraphs
novels = split(txt,["..",]);

% remove the header
novels(1) = [];

% remove the titles
novels(369:371) = [];
novels(394:396) = [];
novels(480:482) = [];

novels = novels(2:2:end);

novels = replace(novels,"THE WORST BIRTHDAY","");
novels = replace(novels,"DOBBY","");
novels = replace(novels,"S","");
novels = replace(novels,"WARNING","");
novels = replace(novels,"THE BURROW","");
novels = replace(novels,"AT FLOURISH AND BLOTTS","");
novels = replace(novels,"AT FLOURISH","");
novels = replace(novels,"AND BLOTTS","");
novels = replace(novels,"THE WHOMPING WILLOW","");
novels = replace(novels,"THE WHOMPING","");
novels = replace(novels,"WILLOW","");
novels = replace(novels,"GILDEROY LOCKHART","");
novels = replace(novels,"MUDBLOODS AND MURMURS","");
novels = replace(novels,"MUDBLOODS","");
novels = replace(novels,"AND MURMURS","");
novels = replace(novels,"THE DEATHDAY PARTY","");
novels = replace(novels,"THE WRITING ON THE WALL","");
novels = replace(novels,"THE WRITING","");
novels = replace(novels,"ON THE WALL","");
novels = replace(novels,"THE ROGUE BLUDGER","");
novels = replace(novels,"THE DUELING CLUB","");
novels = replace(novels,"THE POLYJUICE POTION","");
novels = replace(novels,"THE VERY SECRET DIARY","");
novels = replace(novels,"CORNELIUS FUDGE","");
novels = replace(novels,"ARAGOG","");
novels = replace(novels,"THE CHAMBER OF SECRETS","");
novels = replace(novels,"THE CHAMBER","");
novels = replace(novels,"OF SECRETS","");
novels = replace(novels,"THE HEIR OF SLYTHERIN","");
novels = replace(novels,"REWARD","");

novels = replace(novels,"CHAPTER ONE","");
novels = replace(novels,"C H A P T E R O N E","");
novels = replace(novels,"CHAPTER TWO","");
novels = replace(novels,"C H A P T E R T W O","");
novels = replace(novels,"CHAPTER THREE","");
novels = replace(novels,"C H A P T E R T H R E E","");
novels = replace(novels,"CHAPTER FOUR","");
novels = replace(novels,"C H A P T E R F O U R","");
novels = replace(novels,"CHAPTER FIVE","");
novels = replace(novels,"C H A P T E R F I V E","");
novels = replace(novels,"CHAPTER SIX","");
novels = replace(novels,"C H A P T E R S I X","");
novels = replace(novels,"CHAPTER SEVEN","");
novels = replace(novels,"C H A P T E R S E V E N","");
novels = replace(novels,"CHAPTER EIGHT","");
novels = replace(novels,"C H A P T E R E I G H T","");
novels = replace(novels,"CHAPTER NINE","");
novels = replace(novels,"C H A P T E R N I N E","");
novels = replace(novels,"CHAPTER TEN","");
novels = replace(novels,"C H A P T E R T E N","");
novels = replace(novels,"CHAPTER ELEVEN","");
novels = replace(novels,"C H A P T E R E L E V E N","");
novels = replace(novels,"CHAPTER TWELVE","");
novels = replace(novels,"C H A P T E R T W E L V E","");
novels = replace(novels,"CHAPTER THIRTEEN","");
novels = replace(novels,"C H A P T E R T H I R T E E N","");
novels = replace(novels,"CHAPTER FOURTEEN","");
novels = replace(novels,"C H A P T E R F O U R T E E N","");
novels = replace(novels,"CHAPTER FIFTEEN","");
novels = replace(novels,"C H A P T E R F I F T E E N","");
novels = replace(novels,"CHAPTER SIXTEEN","");
novels = replace(novels,"C H A P T E R S I X T E E N","");
novels = replace(novels,"CHAPTER EIGHTEEN","");
novels = replace(novels,"C H A P T E R E I G H T E E N","");

% erase the punctuation
novels = erasePunctuation(novels);

% tokenize the data
documents = tokenizedDocument(novels);

% convert to lowercase
documents = lower(documents);

% remove stop words
documents = removeWords(documents,stopWords);

end