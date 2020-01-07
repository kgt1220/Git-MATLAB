clear; clc;

%Tokenization of the raw text.

documents = novelsDocuments;
documents = replace(documents,"mirror"," ");

%Two word embeddings(mirror erased).

emb(1) = trainWordEmbedding(documents)
emb(2) = trainWordEmbedding(documents)

words1 = (emb(1).Vocabulary)';
words2 = (emb(2).Vocabulary)';

WV1 = (word2vec(emb(1),words1))';
WV2 = (word2vec(emb(2),words2))';

% Arrange for the frequency of words

bag1 = bagOfWords(documents);
Topk1 = topkwords(bag1,100);
A = Topk1(:,1);
A = table2array(A);

%Check the similarity(cosine) between 'mirror' and other 10 words.

mirror1 = word2vec(emb(1),"mirror");
[cosW1, dist1] = vec2word(emb(1),mirror1,100,'Distance','cosine');

mirror2 = word2vec(emb(2),"mirror");
[cosW2, dist2] = vec2word(emb(2),mirror2,100,'Distance','cosine');

figure
bar(dist1)
xticklabels(cosW1)
xlabel("Word")
ylabel("Distance")
title("Distances to Vector")

figure
bar(dist2)
xticklabels(cosW2)
xlabel("Word")
ylabel("Distance")
title("Distances to Vector")