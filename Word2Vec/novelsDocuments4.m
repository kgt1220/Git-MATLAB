function documents = novelsDocuments4()
%SONNETSDOCUMENTS tokenizedDocument array of preprocessed sonnets.
%   sonnetsDocuments imports the sonnets.txt data and prepares it for
%   analysis 

% import the sonnets text data
txt = extractFileText("Harry Potter and the Goblet of Fire.txt");

% split the sonnets into paragraphs
novels = split(txt,["..",]);

% remove the header
novels(1) = [];

% remove the titles
novels = novels(2:2:end);

novels = replace(novels,"THE RIDDLE HOUSE","");
novels = replace(novels,"THE SCAR","");
novels = replace(novels,"THE INVITATION","");
novels = replace(novels,"BACK TO THE BURROW","");
novels = replace(novels,"WEASLEY","");
novels = replace(novels,"S","");
novels = replace(novels,"WIZARD","");
novels = replace(novels,"WHEEZES","");
novels = replace(novels,"THE PORTKEY","");
novels = replace(novels,"BAGMAN AND CROUCH","");
novels = replace(novels,"THE QUIDDITCH","");
novels = replace(novels,"WORLD CUP","");
novels = replace(novels,"THE DARK MARK","");
novels = replace(novels,"MAYHEM AT THE","");
novels = replace(novels,"MINISTRY","");
novels = replace(novels,"ABOARD THE","");
novels = replace(novels,"HOGWARTS EXPRESS","");
novels = replace(novels,"THE TRIWIZARD","");
novels = replace(novels,"TOURNAMENT","");
novels = replace(novels,"MAD-EYE MOODY","");
novels = replace(novels,"THE UNFORGIVABLE","");
novels = replace(novels,"CURSES","");
novels = replace(novels,"BEAUXBATONS AND","");
novels = replace(novels,"DURMSTRANG","");
novels = replace(novels,"THE GOBLET OF FIRE","");
novels = replace(novels,"THE FOUR CHAMPIONS","");
novels = replace(novels,"THE WEIGHING OF","");
novels = replace(novels,"THE WANDS","");
novels = replace(novels,"THE HUNGARIAN","");
novels = replace(novels,"HORNTAIL","");
novels = replace(novels,"THE FIRST TASK","");
novels = replace(novels,"THE HOUSE-ELF","");
novels = replace(novels,"LIBERATION FRONT","");
novels = replace(novels,"THE UNEXPECTED TASK","");
novels = replace(novels,"RITA SKEETER","");
novels = replace(novels,"SCOOP","");
novels = replace(novels,"THE EGG AND THE EYE","");
novels = replace(novels,"THE SECOND TASK","");
novels = replace(novels,"PADFOOT RETURNS","");
novels = replace(novels,"THE MADNESS OF","");
novels = replace(novels,"MR. CROUCH","");
novels = replace(novels,"THE DREAM","");
novels = replace(novels,"THE PENSIEVE","");
novels = replace(novels,"THE THIRD TASK","");
novels = replace(novels,"FLESH, BLOOD, AND BONE","");
novels = replace(novels,"THE DEATH EATERS","");
novels = replace(novels,"PRIORI INCANTATEM","");
novels = replace(novels,"VERITASERUM","");
novels = replace(novels,"THE PARTING OF","");
novels = replace(novels,"THE WAYS","");
novels = replace(novels,"THE BEGINNING","");

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
novels = replace(novels,"CHAPTER NINETEEN","");
novels = replace(novels,"C H A P T E R N I N E T E E N","");
novels = replace(novels,"CHAPTER TWENTY","");
novels = replace(novels,"C H A P T E R T W E N T Y","");
novels = replace(novels,"CHAPTER TWENTY-ONE","");
novels = replace(novels,"C H A P T E R T W E N T Y - O N E","");
novels = replace(novels,"CHAPTER TWENTY-TWO","");
novels = replace(novels,"C H A P T E R T W E N T Y - T W O","");
novels = replace(novels,"CHAPTER TWENTY-THREE","");
novels = replace(novels,"C H A P T E R T W E N T Y - T H R E E","");
novels = replace(novels,"CHAPTER TWENTY-FOUR","");
novels = replace(novels,"C H A P T E R T W E N T Y - F O U R","");
novels = replace(novels,"CHAPTER TWENTY-FIVE","");
novels = replace(novels,"C H A P T E R T W E N T Y - F I V E","");
novels = replace(novels,"CHAPTER TWENTY-SIX","");
novels = replace(novels,"C H A P T E R T W E N T Y - S I X","");
novels = replace(novels,"CHAPTER TWENTY-SEVEN","");
novels = replace(novels,"C H A P T E R T W E N T Y - S E V E N","");
novels = replace(novels,"CHAPTER TWENTY-EIGHT","");
novels = replace(novels,"C H A P T E R T W E N T Y - E I G H T","");
novels = replace(novels,"CHAPTER TWENTY-NINE","");
novels = replace(novels,"C H A P T E R T W E N T Y - N I N E","");
novels = replace(novels,"CHAPTER THIRTY","");
novels = replace(novels,"C H A P T E R T H I R T Y","");
novels = replace(novels,"CHAPTER THIRTY-ONE","");
novels = replace(novels,"C H A P T E R T H I R T Y - O N E","");
novels = replace(novels,"CHAPTER THIRTY-TWO","");
novels = replace(novels,"C H A P T E R T H I R T Y - T W O","");
novels = replace(novels,"CHAPTER THIRTY-THREE","");
novels = replace(novels,"C H A P T E R T H I R T Y - T H R E E","");
novels = replace(novels,"CHAPTER THIRTY-FOUR","");
novels = replace(novels,"C H A P T E R T H I R T Y - F O U R","");
novels = replace(novels,"CHAPTER THIRTY-FIVE","");
novels = replace(novels,"C H A P T E R T H I R T Y - F I V E","");
novels = replace(novels,"CHAPTER THIRTY-SIX","");
novels = replace(novels,"C H A P T E R T H I R T Y - S I X","");
novels = replace(novels,"CHAPTER THIRTY-SEVEN","");
novels = replace(novels,"C H A P T E R T H I R T Y - S E V E N","");

% erase the punctuation
novels = erasePunctuation(novels);

% tokenize the data
documents = tokenizedDocument(novels);

% convert to lowercase
documents = lower(documents);

% remove stop words
documents = removeWords(documents,stopWords);

end