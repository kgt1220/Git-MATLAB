clear; clc;

%Tokenization of the raw text.

documents = sonnetsDocuments;

%Comparison the vectors of the word 'winter' on 10 word embeddings.

n = 1;
%for n = 1:10 
    emb(n) = trainWordEmbedding(documents)
    
    words = emb(n).Vocabulary;
    V = word2vec(emb(n),words);
       
    W(:,n) = word2vec(emb(n),"winter");
%end

%Check the similarity(distance) between 'winter' and other 10 words.

winter = word2vec(emb(1),"winter");
[words, dist] = vec2word(emb(1),winter,10,'Distance','euclidean');

figure
bar(dist)
xticklabels(words)
xlabel("Word")
ylabel("Distance")
title("Distances to Vector")

%Check the similarity(dot product) between 'winter' and other 10 words.

for n = 1:10
    S(:,n) = word2vec(emb(1),words(n)); 
    
    D(n) = winter*S(:,n);
end
