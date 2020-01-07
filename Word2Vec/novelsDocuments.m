function documents = novelsDocuments()
%SONNETSDOCUMENTS tokenizedDocument array of preprocessed sonnets.
%   sonnetsDocuments imports the sonnets.txt data and prepares it for
%   analysis 

% import the sonnets text data
txt = extractFileText("Harry Potter and the Sorcerer's Stone.txt");

words = string(txt);
% split the sonnets into paragraphs
novels = split(txt,["CHAPTER"]);

novels = split(novels);

% remove the header
novels(1) = [];

% erase the punctuation
novels = erasePunctuation(novels);

% tokenize the data
documents = tokenizedDocument(novels);

% convert to lowercase
documents = lower(documents);

% remove stop words
documents = removeWords(documents,stopWords);

end