clear; clc;

%Tokenization of the raw text.

documents = sonnetsDocuments;

%Comparison the vectors of the word 'winter' on 2 word embeddings.

emb(1) = trainWordEmbedding(documents)
emb(2) = trainWordEmbedding(documents)

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

%
% for n = 1:100
%     CWV1(:,n) = word2vec(emb(1),CW1(n,1));
% end
% 
% for n = 1:100
%     CWV2(:,n) = word2vec(emb(2),CW2(n,1));
% end
% 
% CT1 = winter1*CWV1;
% CTT1 = CT1/(norm(winter1));
% 
% for n = 1:100
%     CTT1(n) = CTT1(n)/norm(CWV1(:,n));
% end
% 
% CTT1 = double(CTT1)';

%Check the similarity(cosine) between 'winter' and other 10 words.

% DP1 = (winter1*WV1)'/(norm(winter1));
% DP2 = (winter2*WV2)'/(norm(winter1));
% 
% for n = 1:401
%     DPP1(n) = DP1(n)/norm(WV1(:,n));
% end
% 
% for n = 1:401
%     DPP2(n) = DP2(n)/norm(WV2(:,n));
% end
% 
% SDP1 = sort(DPP1,'descend');
% SDP2 = sort(DPP2,'descend');
% 
% T1 = zeros(401);
% 
% for n = 1:401
%     for m = 1:401
%         if DPP1(n) == SDP1(m)
%            T1(n,m) = 1;
%         end
%     end
% end
% 
% T2 = zeros(401);
% for n = 1:401
%     for m = 1:401
%         if DPP2(n) == SDP2(m)
%            T2(n,m) = 1;
%         end
%     end
% end
% 
% TWV1 = inv(T1)*WV1';
% TWV2 = inv(T2)*WV2';
% 
% DPW1 = vec2word(emb(1),TWV1(1:100,:));
% DPW2 = vec2word(emb(2),TWV2(1:100,:));
% 
% DPW1 = DPW1';
% DPW2 = DPW2';
% 
% %Check the similarity(dot product) between 'winter' and other 10 words.
% 
% DP1 = (winter1*WV1)';
% DP2 = (winter2*WV2)';
% 
% SDP1 = sort(DP1,'descend');
% SDP2 = sort(DP2,'descend');
% 
% T1 = zeros(401);
% for n = 1:401
%     for m = 1:401
%         if DP1(n) == SDP1(m)
%             T1(n,m) = 1;
%         end
%     end
% end
% 
% T2 = zeros(401);
% for n = 1:401
%     for m = 1:401
%         if DP2(n) == SDP2(m)
%             T2(n,m) = 1;
%         end
%     end
% end
% 
% TWV1 = inv(T1)*WV1';
% TWV2 = inv(T2)*WV2';
% 
% DPW1 = vec2word(emb(1),TWV1(1:100,:));
% DPW2 = vec2word(emb(2),TWV2(1:100,:));
% 
% DPW1 = DPW1';
% DPW2 = DPW2';

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
