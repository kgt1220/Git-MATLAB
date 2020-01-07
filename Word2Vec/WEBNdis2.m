m1 = 1;
m2 = 1;
m3 = 1;
m4 = 1;
m5 = 1;
m6 = 1;

for n = 1: 200
    if SDTable(n,1) >= 80
        A1(m1) = n;
        m1 = m1+1;
    elseif SDTable(n,1) < 80 && SDTable(n,1) >= 70
        A2(m2) = n;
        m2 = m2+1;
    elseif SDTable(n,1) < 70 && SDTable(n,1) >= 60
        A3(m3) = n;
        m3 = m3+1;
    elseif SDTable(n,1) < 60 && SDTable(n,1) >= 50
        A4(m4) = n;
        m4 = m4+1;
    elseif SDTable(n,1) < 50 && SDTable(n,1) >= 40
        A5(m5) = n;
        m5 = m5+1;
    elseif SDTable(n,1) < 40
        A6(m6) = n;
        m6 = m6+1;
    end
end

Score1 = zeros(1,length(A1)-1);
Score2 = zeros(1,length(A2)-1);
Score3 = zeros(1,length(A3)-1);
Score4 = zeros(1,length(A4)-1);
Score5 = zeros(1,length(A5)-1);
Score6 = zeros(1,length(A6)-1);

for k = 1:length(A1)-1
    
    TV1 = zeros(125);
    TV2 = zeros(125);

    for m = 11:135
        TV1(:,m-10) = word2vec(emb(A1(k)),A(m,1));
        TV2(:,m-10) = word2vec(emb(A1(k+1)),A(m,1));
    end
    
    T = TV2/TV1;

    for n = 1:125
        AV1(:,n) = word2vec(emb(A1(k)),A(r(n)));
        AV2(:,n) = word2vec(emb(A1(k+1)),A(r(n)));
        QV(:,n) = T*AV1(:,n);
        QW(n) = vec2word(emb(A1(k+1)),QV(:,n));
        Err(n) = norm(QV(:,n) - AV2(:,n));
    end

    Table = [A(r(1:100)) QW(1:100)'];

    q = 0;

    for p = 1:100
        if Table(p,1) == Table(p,2)
            q = q+1;
        end
    end
    
    Score1(k) = q;
end

for k = 1:length(A2)-1
    
    TV1 = zeros(125);
    TV2 = zeros(125);

    for m = 11:135
        TV1(:,m-10) = word2vec(emb(A2(k)),A(m,1));
        TV2(:,m-10) = word2vec(emb(A2(k+1)),A(m,1));
    end
    
    T = TV2/TV1;

    for n = 1:125
        AV1(:,n) = word2vec(emb(A2(k)),A(r(n)));
        AV2(:,n) = word2vec(emb(A2(k+1)),A(r(n)));
        QV(:,n) = T*AV1(:,n);
        QW(n) = vec2word(emb(A2(k+1)),QV(:,n));
        Err(n) = norm(QV(:,n) - AV2(:,n));
    end

    Table = [A(r(1:100)) QW(1:100)'];

    q = 0;

    for p = 1:100
        if Table(p,1) == Table(p,2)
            q = q+1;
        end
    end
    
    Score2(k) = q;
end

for k = 1:length(A3)-1
    
    TV1 = zeros(125);
    TV2 = zeros(125);

    for m = 11:135
        TV1(:,m-10) = word2vec(emb(A3(k)),A(m,1));
        TV2(:,m-10) = word2vec(emb(A3(k+1)),A(m,1));
    end
    
    T = TV2/TV1;

    for n = 1:125
        AV1(:,n) = word2vec(emb(A3(k)),A(r(n)));
        AV2(:,n) = word2vec(emb(A3(k+1)),A(r(n)));
        QV(:,n) = T*AV1(:,n);
        QW(n) = vec2word(emb(A3(k+1)),QV(:,n));
        Err(n) = norm(QV(:,n) - AV2(:,n));
    end

    Table = [A(r(1:100)) QW(1:100)'];

    q = 0;

    for p = 1:100
        if Table(p,1) == Table(p,2)
            q = q+1;
        end
    end
    
    Score3(k) = q;
end

for k = 1:length(A4)-1
    
    TV1 = zeros(125);
    TV2 = zeros(125);

    for m = 11:135
        TV1(:,m-10) = word2vec(emb(A4(k)),A(m,1));
        TV2(:,m-10) = word2vec(emb(A4(k+1)),A(m,1));
    end
    
    T = TV2/TV1;

    for n = 1:125
        AV1(:,n) = word2vec(emb(A4(k)),A(r(n)));
        AV2(:,n) = word2vec(emb(A4(k+1)),A(r(n)));
        QV(:,n) = T*AV1(:,n);
        QW(n) = vec2word(emb(A4(k+1)),QV(:,n));
        Err(n) = norm(QV(:,n) - AV2(:,n));
    end

    Table = [A(r(1:100)) QW(1:100)'];

    q = 0;

    for p = 1:100
        if Table(p,1) == Table(p,2)
            q = q+1;
        end
    end
    
    Score4(k) = q;
end

for k = 1:length(A5)-1
    
    TV1 = zeros(125);
    TV2 = zeros(125);

    for m = 11:135
        TV1(:,m-10) = word2vec(emb(A5(k)),A(m,1));
        TV2(:,m-10) = word2vec(emb(A5(k+1)),A(m,1));
    end
    
    T = TV2/TV1;

    for n = 1:125
        AV1(:,n) = word2vec(emb(A5(k)),A(r(n)));
        AV2(:,n) = word2vec(emb(A5(k+1)),A(r(n)));
        QV(:,n) = T*AV1(:,n);
        QW(n) = vec2word(emb(A5(k+1)),QV(:,n));
        Err(n) = norm(QV(:,n) - AV2(:,n));
    end

    Table = [A(r(1:100)) QW(1:100)'];

    q = 0;

    for p = 1:100
        if Table(p,1) == Table(p,2)
            q = q+1;
        end
    end
    
    Score5(k) = q;
end

for k = 1:length(A6)-1
    
    TV1 = zeros(125);
    TV2 = zeros(125);

    for m = 11:135
        TV1(:,m-10) = word2vec(emb(A6(k)),A(m,1));
        TV2(:,m-10) = word2vec(emb(A6(k+1)),A(m,1));
    end
    
    T = TV2/TV1;

    for n = 1:125
        AV1(:,n) = word2vec(emb(A6(k)),A(r(n)));
        AV2(:,n) = word2vec(emb(A6(k+1)),A(r(n)));
        QV(:,n) = T*AV1(:,n);
        QW(n) = vec2word(emb(A6(k+1)),QV(:,n));
        Err(n) = norm(QV(:,n) - AV2(:,n));
    end

    Table = [A(r(1:100)) QW(1:100)'];

    q = 0;

    for p = 1:100
        if Table(p,1) == Table(p,2)
            q = q+1;
        end
    end
    
    Score6(k) = q;
end

Score1
Score2
Score3
Score4
Score5
Score6