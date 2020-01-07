clear; clc;

%Tokenization of the raw text.

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

documentswx = replace(documents,"time"," ");

% Arrange for the frequency of words

bag1 = bagOfWords(documents);
Topk1 = topkwords(bag1,8391);
Topk1 = table2array(Topk1);
A = Topk1(:,1);

%Two word embeddings containing 'mirror' and not containing 'mirror'(convert to xxxxxx) resp.

emb(1) = trainWordEmbedding(documents,'Dimension',125,'NGramRange',[0 0],'NumEpochs',50);
emb(2) = trainWordEmbedding(documentswx,'Dimension',125,'NGramRange',[0 0],'NumEpochs',50);

% words1 = (emb(1).Vocabulary)';
% words2 = (emb(2).Vocabulary)';
% 
% WV1 = (word2vec(emb(1),words1))';
% WV2 = (word2vec(emb(2),words2))';

%Check the similarity(cosine) between 'mirror' and the other words.

mirror1 = word2vec(emb(1),"time");
[cosW1, dist1] = vec2word(emb(1),mirror1,8391,'Distance','cosine');

mirror2 = word2vec(emb(2),"xxxx");
[cosW2, dist2] = vec2word(emb(2),mirror2,100,'Distance','cosine');

presents1 = word2vec(emb(1),"presents");
[cosW3, dist3] = vec2word(emb(1),presents1,100,'Distance','cosine');

presents2 = word2vec(emb(2),"presents");
[cosW4, dist4] = vec2word(emb(2),presents2,100,'Distance','cosine');

horror1 = word2vec(emb(1),"horror");
[cosW5, dist5] = vec2word(emb(1),horror1,100,'Distance','cosine');

horror2 = word2vec(emb(2),"horror");
[cosW6, dist6] = vec2word(emb(2),horror2,100,'Distance','cosine');

% Comparison between cosW1 and cosW2

c = 0;

for n = 1:100
    for m = 1:100
        if cosW1(n) == cosW2(m)
            c = c+1;
        end
    end
end

Count1 = c

% Comparison between cosW3 and cosW4

c = 0;

for n = 1:100
    for m = 1:100
        if cosW3(n) == cosW4(m)
            c = c+1;
        end
    end
end

Count2 = c

% Comparison between cosW5 and cosW6

c = 0;

for n = 1:100
    for m = 1:100
        if cosW5(n) == cosW6(m)
            c = c+1;
        end
    end
end

Count3 = c

%Make the rotation matrix between two embedding vector spaces.

C1 = cosW1(8091:8391);

for n = 1:301
    for m = 1:8391
        if C1(n) == Topk1(m,1)
            F1(n) = Topk1(m,2);
        end
    end
end

F1 = str2double(F1');

m = 1;

for n = 1:301
    if F1(n) > 15
       C2(m) = C1(n);
       m = m + 1;
    end
end

C2 = C2';

TV1 = zeros(125);
TV2 = zeros(125);

for n = 1:125
    TV1(:,n) = word2vec(emb(1),C2(n));
    TV2(:,n) = word2vec(emb(2),C2(n));
end

T = TV2/TV1;

% Test the rotation matrix

r = randi([126 8391],1,125);

for n = 1:125
    AV1(:,n) = word2vec(emb(1),A(r(n)));
    AV2(:,n) = word2vec(emb(2),A(r(n)));
    QV(:,n) = T*AV1(:,n);
    QW(1:3,n) = vec2word(emb(2),QV(:,n),3);
    Err(n) = max(QV(:,n) - AV2(:,n));
    Err2(n) = norm(QV(:,n) - AV2(:,n));
end

Table = [A(r(1:125)) QW(1,1:125)' QW(2,1:125)' QW(3,1:125)'];

k = 0;
l = 0;
m = 0;

for n = 1:125
    if Table(n,1) == Table(n,2)
        k = k+1;
    elseif Table(n,1) == Table(n,3)
        l = l+1;
    elseif Table(n,1) == Table(n,4)
        m = m+1;
    end
end

Score1 = k
Score2 = l
Score3 = m