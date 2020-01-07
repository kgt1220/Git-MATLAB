clear; clc;

% Tokenization of the raw text.

documents = novelsDocuments;
documents2 = replace(documents,"mirror","xxxx");

% Arrange for the frequency of words

bag1 = bagOfWords(documents);
Topk1 = topkwords(bag1,1555);
A = Topk1(:,1);
A = table2array(A);

for k = 1:25
    emb(k) = trainWordEmbedding(documents,'Dimension',125,'NumEpochs',50,'NGramRange',[0 0]);
end

for k = 26:50
    emb(k) = trainWordEmbedding(documents2,'Dimension',125,'NumEpochs',50,'NGramRange',[0 0]);
end

r = 136:73:1555;
N = zeros(50);

for p = 1:50
    for q = 1:50
        
        TV1 = zeros(125);
        TV2 = zeros(125);
        
        for n = 11:135
            TV1(:,n-10) = word2vec(emb(p),A(n,1));
            TV2(:,n-10) = word2vec(emb(q),A(n,1));
        end
        
        T = TV2/TV1;
        
        C = zeros(1,20);

        for n = 1:20
            AV1(:,n) = word2vec(emb(p),A(r(n)));
            AV2(:,n) = word2vec(emb(q),A(r(n)));
            QV(:,n) = T*AV1(:,n);
            C(n) = (QV(:,n)'*AV2(:,n))/(norm(QV(:,n))*norm(AV2(:,n)));
        end
        
        C = (1.-C).^2;
        N(p,q) = (sum(C))^0.5;
    end
end

N2 = N.^2;
%%
N3 = zeros(50);

for p = 1:50
    for q = 1:50
        
        TV1 = zeros(125);
        TV2 = zeros(125);
        
        for n = 11:135
            TV1(:,n-10) = word2vec(emb(p),A(n,1));
            TV2(:,n-10) = word2vec(emb(q),A(n,1));
        end
        
        T = TV2/TV1;
        
        C = zeros(1,20);

        for n = 1:20
            AV1(:,n) = word2vec(emb(p),A(r(n)));
            AV2(:,n) = word2vec(emb(q),A(r(n)));
            QV(:,n) = (T^2)*AV1(:,n);
            C(n) = (QV(:,n)'*AV2(:,n))/(norm(QV(:,n))*norm(AV2(:,n)));
        end
        
        C = (1.-C).^2;
        N3(p,q) = (sum(C))^0.5;
    end
end

N4 = N3.^2;
%%
N5 = zeros(50);

for p = 1:50
    for q = 1:50
        
        TV1 = zeros(125);
        TV2 = zeros(125);
        
        for n = 11:135
            TV1(:,n-10) = word2vec(emb(p),A(n,1));
            TV2(:,n-10) = word2vec(emb(q),A(n,1));
        end
        
        T = TV2/TV1;
        
        C = zeros(1,20);

        for n = 1:20
            AV1(:,n) = word2vec(emb(p),A(r(n)));
            AV2(:,n) = word2vec(emb(q),A(r(n)));
            QV(:,n) = T*AV1(:,n);
            if n == 1:19
                C(n) = (QV(:,n)'*AV2(:,n+1))/(norm(QV(:,n))*norm(AV2(:,n)));
            else
                C(n) = (QV(:,n)'*AV2(:,1))/(norm(QV(:,n))*norm(AV2(:,n)));
            end
        end
        
        C = (1.-C).^2;
        N5(p,q) = (sum(C))^0.5;
    end
end

N6 = N5.^2;
%%
N7 = zeros(50);

for p = 1:50
    for q = 1:50
        
        TV1 = zeros(125);
        TV2 = zeros(125);
        
        for n = 11:135
            TV1(:,n-10) = word2vec(emb(p),A(n,1));
            TV2(:,n-10) = word2vec(emb(q),A(n,1));
        end
        
        T = TV2/TV1;
        
        C = zeros(1,20);

        for n = 1:20
            AV1(:,n) = word2vec(emb(p),A(r(n)));
            AV2(:,n) = word2vec(emb(q),A(r(n)));
            QV(:,n) = inv(T)*AV1(:,n);
            C(n) = (QV(:,n)'*AV2(:,n))/(norm(QV(:,n))*norm(AV2(:,n)));
        end
        
        C = (1.-C).^2;
        N7(p,q) = (sum(C))^0.5;
    end
end

N8 = N7.^2;
