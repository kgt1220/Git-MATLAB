function documents = novelsDocuments5()
%SONNETSDOCUMENTS tokenizedDocument array of preprocessed sonnets.
%   sonnetsDocuments imports the sonnets.txt data and prepares it for
%   analysis 

% import the sonnets text data
txt = extractFileText("Harry Potter and the Order of the Phoenix.txt");

% split the sonnets into paragraphs
novels = split(txt,["..",]);

% remove the header
novels(1) = [];

% remove the titles
novels = novels(2:2:end);

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
novels = replace(novels,"CHAPTER THIRTY-EIGHT","");
novels = replace(novels,"C H A P T E R T H I R T Y - E I G H T","");

% erase the punctuation
novels = erasePunctuation(novels);

% tokenize the data
documents = tokenizedDocument(novels);

% convert to lowercase
documents = lower(documents);

% remove stop words
documents = removeWords(documents,stopWords);

end