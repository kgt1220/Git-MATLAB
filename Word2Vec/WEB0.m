clear; clc;

%Tokenization of the raw text.

documents = sonnetsDocuments;

%Comparison the vectors of the word 'winter' on 2 word embeddings.

emb(1) = trainWordEmbedding(documents,'NGramRange',[0 0])
emb(2) = trainWordEmbedding(documents,'NGramRange',[0 0])

words1 = (emb(1).Vocabulary)';
words2 = (emb(2).Vocabulary)';

WV1 = (word2vec(emb(1),words1))';
WV2 = (word2vec(emb(2),words2))';

for n = 1:2
    Win(:,n) = word2vec(emb(n),"winter");
end

%Check the similarity(cosine) between 'winter' and other 10 words.

winter1 = word2vec(emb(1),"winter");
[cosW1, dist1] = vec2word(emb(1),winter1,100,'Distance','cosine');

winter2 = word2vec(emb(2),"winter");
[cosW2, dist2] = vec2word(emb(2),winter2,100,'Distance','cosine');

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

C = zeros(1,100);

for n = 1:100
    for m = 1:100
        if cosW1(n) == cosW2(m)
            C(n) = 1;
        end
    end
end

m = 0;

for n = 1:100
    if C(n) == 1
        m = m+1;
    end
end

Count = m

%Check the relation between two embedding spaces.

bag = bagOfWords(documents);
Topk = topkwords(bag,401);
A = Topk(:,1);
A = table2array(A);

for n = 1:100
    TV1(:,n) = word2vec(emb(1),A(n,1));
end

for n = 1:100
    TV2(:,n) = word2vec(emb(2),A(n,1));
end

T = TV2*inv(TV1);

r = randi([101 401],1,100);

for n = 1:100
    A(r(n));
    AV1(:,n) = word2vec(emb(1),A(r(n)));
    AV2(:,n) = word2vec(emb(2),A(r(n)));
    QV(:,n) = T*AV1(:,n);
    QW(n) = vec2word(emb(2),QV(:,n));
    Err(n) = norm(QV(:,n) - AV2(:,n));
end

Table = [A(r(1:100)) QW(1:100)'];

D = zeros(1,100);

for n = 1:100
    if Table(n,1) == Table(n,2)
        D(n) = 1;
    end
end

m = 0;

for n = 1:100
    if D(n) == 1
        m = m+1;
    end
end

Score = m