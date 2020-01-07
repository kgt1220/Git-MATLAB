function documents = sonnetsDocuments()
%SONNETSDOCUMENTS tokenizedDocument array of preprocessed sonnets.
%   sonnetsDocuments imports the sonnets.txt data and prepares it for
%   analysis 

% import the sonnets text data
txt = extractFileText("sonnets.txt");

% split the sonnets into paragraphs
sonnets = split(txt,[newline newline]);

% remove the header
sonnets(1:4) = [];

% remove the titles
sonnets = sonnets(1:2:end);

% erase the punctuation
sonnets = erasePunctuation(sonnets);

% tokenize the data
documents = tokenizedDocument(sonnets);

% convert to lowercase
documents = lower(documents);

% remove stop words
documents = removeWords(documents,stopWords);

end