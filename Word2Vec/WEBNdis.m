clear; clc;

% Tokenization of the raw text.

documents = novelsDocuments;

% Arrange for the frequency of words

bag1 = bagOfWords(documents);
Topk1 = topkwords(bag1,1555);
A = Topk1(:,1);
A = table2array(A);

%Two word embeddings.

emb(1) = trainWordEmbedding(documents,'Dimension',125,'NumEpochs',50,'NGramRange',[0 0]);

words1 = (emb(1).Vocabulary)';
WV1 = (word2vec(emb(1),words1))';

Score = zeros(1,200);
Det = zeros(1,200);

for k = 2:201
    
emb(k) = trainWordEmbedding(documents,'Dimension',125,'NumEpochs',50,'NGramRange',[0 0]);

% Make the rotation matrix between two embedding vector spaces.

TV1 = zeros(125);
TV2 = zeros(125);

for n = 11:135
    TV1(:,n-10) = word2vec(emb(1),A(n,1));
    TV2(:,n-10) = word2vec(emb(k),A(n,1));
end

T = TV2/TV1;

% Test the rotation matrix

r = randi([136 1555],1,125);

for n = 1:125
    AV1(:,n) = word2vec(emb(1),A(r(n)));
    AV2(:,n) = word2vec(emb(k),A(r(n)));
    QV(:,n) = T*AV1(:,n);
    QW(n) = vec2word(emb(k),QV(:,n));
    Err(n) = norm(QV(:,n) - AV2(:,n));
end

Table = [A(r(1:125)) QW(1:125)'];

m = 0;

for n = 1:125
    if Table(n,1) == Table(n,2)
        m = m+1;
    end
end

Score(k-1) = m;

Det(k-1) = det(T);

SDTable = [Score' Det'];
end

SDTable