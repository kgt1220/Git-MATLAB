clear; clc;

% Tokenization of the raw text.

documents1 = novelsDocuments;
documents2 = novelsDocuments2;
documents3 = novelsDocuments3;
documents4 = novelsDocuments4;
documents5 = novelsDocuments5;
documents6 = novelsDocuments6;
documents7 = novelsDocuments7;

documents(1:17,1) = documents1;
documents(18:358,1) = documents2;
documents(359:380,1) = documents3;
documents(381:1114,1) = documents4;
documents(1115:1991,1) = documents5;
documents(1992:2021,1) = documents6;
documents(2022:2777,1) = documents7;

% Arrange for the frequency of words

bag1 = bagOfWords(documents);
Topk1 = topkwords(bag1,8391);
A = Topk1(:,1);
A = table2array(A);

Count = zeros(1,10);
Score = zeros(1,10);
Det(k) = zeros(1,10);

for k = 1:10
%Two word embeddings(not use N-gram).

emb(1) = trainWordEmbedding(documents,'Dimension',125,'NGramRange',[0 0],'NumEpochs',50);
emb(2) = trainWordEmbedding(documents,'Dimension',125,'NGramRange',[0 0],'NumEpochs',50);

% words1 = (emb(1).Vocabulary)';
% words2 = (emb(2).Vocabulary)';
% 
% WV1 = (word2vec(emb(1),words1))';
% WV2 = (word2vec(emb(2),words2))';

% Check the similarity(cosine) between 'mirror' and other 100 words.

mirror1 = word2vec(emb(1),"mirror");
[cosW1, dist1] = vec2word(emb(1),mirror1,100,'Distance','cosine');

mirror2 = word2vec(emb(2),"mirror");
[cosW2, dist2] = vec2word(emb(2),mirror2,100,'Distance','cosine');

% figure
% bar(dist1)
% xticklabels(cosW1)
% xlabel("Word")
% ylabel("Distance")
% title("Distances to Vector")
% 
% figure
% bar(dist2)
% xticklabels(cosW2)
% xlabel("Word")
% ylabel("Distance")
% title("Distances to Vector")

% Comparison between cosW1 and cosW2

c = 0;

for n = 1:100
    for m = 1:100
        if cosW1(n) == cosW2(m)
            c = c+1;
        end
    end
end

Count(1,k) = c;

% Make the rotation matrix between two embedding vector spaces.

TV1 = zeros(125);
TV2 = zeros(125);

for n = 1:125
    TV1(:,n) = word2vec(emb(1),A(n,1));
    TV2(:,n) = word2vec(emb(2),A(n,1));
end

T = TV2/TV1;

% Test the rotation matrix

r = randi([126 8391],1,125);

for n = 1:125
    AV1(:,n) = word2vec(emb(1),A(r(n)));
    AV2(:,n) = word2vec(emb(2),A(r(n)));
    QV(:,n) = T*AV1(:,n);
    QW(n) = vec2word(emb(2),QV(:,n));
    Err(n) = norm(QV(:,n) - AV2(:,n));
end

Table = [A(r(1:125)) QW(1:125)'];

m = 0;

for n = 1:125
    if Table(n,1) == Table(n,2)
        m = m+1;
    end
end

Score(1,k) = m;

Det(1,k) = det(T);
end

Count
SDTable = [Score' Det']