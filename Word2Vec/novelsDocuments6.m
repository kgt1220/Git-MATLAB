function documents = novelsDocuments6()
%SONNETSDOCUMENTS tokenizedDocument array of preprocessed sonnets.
%   sonnetsDocuments imports the sonnets.txt data and prepares it for
%   analysis 

% import the sonnets text data
txt = extractFileText("Harry Potter and the Half Blood Prince.txt");

% split the sonnets into paragraphs
novels = split(txt,["CHAPTER"]);

% remove the header
novels(1) = [];

% remove the titles

novels = replace(novels,"ONE","");
novels = replace(novels,"TWO","");
novels = replace(novels,"THREE","");
novels = replace(novels,"FOUR","");
novels = replace(novels,"FIVE","");
novels = replace(novels,"SIX","");
novels = replace(novels,"SEVEN","");
novels = replace(novels,"EIGHT","");
novels = replace(novels,"NINE","");
novels = replace(novels,"TEN","");
novels = replace(novels,"ELEVEN","");
novels = replace(novels,"TWELVE","");
novels = replace(novels,"THIRTEEN","");
novels = replace(novels,"FOURTEEN","");
novels = replace(novels,"FIFTEEN","");
novels = replace(novels,"SIXTEEN","");
novels = replace(novels,"SEVENTEEN","");
novels = replace(novels,"EIGHTEEN","");
novels = replace(novels,"NINETEEN","");
novels = replace(novels,"TWENTY","");
novels = replace(novels,"TWENTY-ONE","");
novels = replace(novels,"TWENTY-TWO","");
novels = replace(novels,"TWENTY-THREE","");
novels = replace(novels,"TWENTY-FOUR","");
novels = replace(novels,"TWENTY-FIVE","");
novels = replace(novels,"TWENTY-SIX","");
novels = replace(novels,"TWENTY-SEVEN","");
novels = replace(novels,"TWENTY-EIGHT","");
novels = replace(novels,"TWENTY-NINE","");
novels = replace(novels,"THIRTY","");
novels = replace(novels,"TEEN","");
novels = replace(novels,"EEN","");

% erase the punctuation
novels = erasePunctuation(novels);

% tokenize the data
documents = tokenizedDocument(novels);

% convert to lowercase
documents = lower(documents);

% remove stop words
documents = removeWords(documents,stopWords);

end