clear; clc;

%Tokenization of the raw text.

documents = sonnetsDocuments;
documents2 = replace(documents,"winter","");

% Arrange for the frequency of words.

bag1 = bagOfWords(documents);
Topk1 = topkwords(bag1,100);
A = Topk1(:,1);
A = table2array(A);

bag2 = bagOfWords(documents2);
Topk2 = topkwords(bag2,100);
B = Topk1(:,1);
B = table2array(B);

% Two word embeddings.

numComponents = 20;
mdl = fitlsa(bag1,numComponents)
mdl2 = fitlsa(bag2,numComponents)

dscores = mdl.WordScores;
dscores2 = mdl2.WordScores;
Voca = mdl.Vocabulary;
Voca2 = mdl2.Vocabulary;

nv = length(Voca);
nv2 = length(Voca2);

% Cosine similarity between word vectors. - 모든 단어끼리 각각 1-cosx

DotM = zeros(nv,nv);

% 
% for n=1:3092
%     S(n,:) = dscores(n,:)/norm(dscores(n,:));
% end
% 
% DotMt = 1 - S*S';

for n = 1:nv
    for m = 1:nv
        DotM(n,m) = 1-dscores(n,:)*dscores(m,:)'/(norm(dscores(n,:))*norm(dscores(m,:)));
    end
end

DotM2 = zeros(nv2,nv2);

for n = 1:nv2
    for m = 1:nv2
        DotM2(n,m) = 1-dscores2(n,:)*dscores2(m,:)'/(norm(dscores2(n,:))*norm(dscores2(m,:)));
    end
end

% Words close to 'winter' for cosine similarity.

for n = 1:nv
    if Voca(n) == 'winter'
        w = n;
    end
end

[SortDM,I] = sort(DotM(w,:));
SortDM = SortDM';

Win = string(zeros(nv,1));

for n = 1:nv
    Win(n) = Voca(I(n));
end

%% Transformation between two embeddings.

% Finding word non-related to 'winter'.

 for n = 1:nv
    if Voca(n) == 'growing'
        r = n;
    end
 end

 for n = 1:nv2
    if Voca2(n) == 'growing'
        r2 = n;
    end
 end
 
% Words close to non-related word for cosine similarity.

[SortDMr,Ir] = sort(DotM(r,:));
SortDMr = SortDMr';
Ir = Ir(1:100)';

rcosW1 = string(zeros(100,1));

for n = 1:100
    rcosW1(n) = Voca(Ir(n));
end

[SortDMr2,Ir2] = sort(DotM2(r2,:));
SortDMr2 = SortDMr2';
Ir2 = Ir2(1:100)';

rcosW2 = string(zeros(100,1));

for n = 1:100
    rcosW2(n) = Voca2(Ir2(n));
end

rC = zeros(1,100);
rTrans = zeros(1,100);

for n = 1:100
    for m = 1:100
        if rcosW1(n) == rcosW2(m)
            rC(n) = 1;
            rTrans(n) = m;
        end
    end
end

c = 0;

for n = 1:100
    if rC(n) == 1
        c = c+1;
    end
end

Count = c

% Transformation matrix.

rWV1 = zeros(100,20);
rWV2 = zeros(100,20);

for n = 1:100
    rWV1(n,:) = dscores(Ir(n),:);
    rWV2(n,:) = dscores2(Ir2(rTrans(n)),:);
end

rMWV1 = zeros(20,20);
rMWV1(1,:) = rWV1(1,:);
rIndexMV = zeros(20,1);
rIndexMV(1,1) = 1;
k = 2;

for n = 1:99
    if rWV1(n+1,:) ~= rMWV1(k-1,:)
        rMWV1(k,:) = rWV1(n+1,:);
        rIndexMV(k,1) = n+1;
        k = k+1;      
    end
end
   
for n = 1:41
    if rC(rIndexMV(n)) == 1
        rIndexMV(n) = rIndexMV(n);
    elseif rC(rIndexMV(n)) == 0
        rIndexMV(n) = 0;
    end
end

l = 1;

for n = 1:41
    if rIndexMV(n) ~= 0
        rFV1(l,:) = rWV1(rIndexMV(n),:);
        rFV2(l,:) = rWV2(rTrans(rIndexMV(n)),:);
        l = l+1;
    end
end

rFV1 = rFV1(1:20,1:20);
rFV2 = rFV2(1:20,1:20);

rT = rFV1/rFV2;

%% Words close to kth word for cosine similarity.

for n = 1:nv
    if Voca(n) == 'frost'
        f = n;
    end
end

for n = 1:nv2
    if Voca2(n) == 'frost'
        f2 = n;
    end
end

[SortDMf,If] = sort(DotM(f,:));
SortDMf = SortDMf';
If = If(1:100)';

cosW1 = string(zeros(100,1));

for n = 1:100
    cosW1(n) = Voca(If(n));
end

[SortDMf2,If2] = sort(DotM2(f2,:));
SortDMf2 = SortDMf2';
If2 = If2(1:100)';

cosW2 = string(zeros(100,1));

for n = 1:100
    cosW2(n) = Voca2(If2(n));
end

% Comparison between cosW1 and cosW2

C = zeros(1,100);
Trans = zeros(1,100);

for n = 1:100
    for m = 1:100
        if cosW1(n) == cosW2(m)
            C(n) = 1;
            Trans(n) = m;
        end
    end
end

c = 0;

for n = 1:100
    if C(n) == 1
        c = c+1;
    end
end

Count = c

%% Words close to kth word for Euclidean distance.

WV1 = zeros(100,20);
WV2 = zeros(100,20);

for n = 1:100
    WV1(n,:) = dscores(If(n),:);
    WV2(n,:) = dscores2(If2(n),:);
end

N1 = zeros(100,1);
N2 = zeros(100,1);

for n = 1:100
    N1(n,1) = norm(dscores(f,:)-WV1(n,:));
    N2(n,1) = norm(dscores2(f2,:)-WV2(n,:));
end

%% Effect of winter on two embeddings.

MWV1 = zeros(numComponents,numComponents);
MWV1(1,:) = WV1(1,:);
IndexMV = zeros(numComponents,1);
IndexMV(1,1) = 1;
k = 2;

for n = 1:99
    if WV1(n+1,:) ~= MWV1(k-1,:)
        MWV1(k,:) = WV1(n+1,:);
        IndexMV(k,1) = n+1;
        k = k+1;      
    end
end
   
for n = 1:58
    if C(IndexMV(n)) == 1
        IndexMV(n) = IndexMV(n);
    elseif C(IndexMV(n)) == 0
        IndexMV(n) = 0;
    end
end

l = 1;

for n = 1:58
    if IndexMV(n) ~= 0
        FV1(l,:) = WV1(IndexMV(n),:);
        FV2(l,:) = WV2(Trans(IndexMV(n)),:);
        l = l+1;
    end
end

FV1 = FV1(1:numComponents,1:numComponents);
FV2 = FV2(1:numComponents,1:numComponents);

T = FV1/FV2;

%% Plot.

FV1n = zeros(numComponents,1);
FV2n = zeros(numComponents,1);
FVn = zeros(numComponents,1);

for n = 1:numComponents
    FV1n(n) = norm(FV1(n,:));
    FV2n(n) = norm(FV2(n,:));
    FVn(n) = FV1n(n)-FV2n(n);
end    

xaxis = [1:numComponents];
figure
plot(xaxis,FVn');
title('Euclidean distance for each words between two embeddings')
xlabel('20 embedded words related to frost')
ylabel('Euclidean distance')

FVc = zeros(numComponents,1);

for n = 1:numComponents
    FVc(n) = FV1(n,:)*FV2(n,:)'/(norm(FV1(n,:))*norm(FV2(n,:)));
end

figure
plot(xaxis,FVc');
title('Cosine similarity for each words between two embeddings')
xlabel('20 embedded words related to frost')
ylabel('Cosine similarity')

rFVc = zeros(100,1);

for n = 1:100
    rFVc(n) = rWV1(n,:)*rWV2(n,:)'/(norm(rWV1(n,:))*norm(rWV2(n,:)));
end

rxaxis = [1:100];
figure
plot(rxaxis,rFVc')
title('Cosine similarity for each words between two embeddings')
xlabel('100 embedded words related to growing, non-related to winter')
ylabel('Cosine similarity')

for n = 1:numComponents
    FVc1(n) = 1 - dscores(211,:)*FV1(n,:)'/(norm(dscores(211,:))*norm(FV1(n,:)));
    
    FVc2(n) = 1 - dscores2(210,:)*FV2(n,:)'/(norm(dscores2(210,:))*norm(FV2(n,:)));
end

[FVc1' FVc2'];

figure
plot(xaxis,FVc1)
hold on
plot(xaxis,FVc2)

for n = 1:21
    if IndexMV(n) ~= 0
        X(n,1) = If(IndexMV(n),1);
    end
end

for n = 1:21
    if IndexMV(n) ~= 0
        XX(n,1) = If2(Trans(IndexMV(n)));
    end
end

%% Plot analysis

WT = zeros(nv,1);
WTD = zeros(nv,1);

for n = 1:nv
    for m = 1:nv2
        if Voca(n) == Voca2(m)
            WT(n) = m;
        end
    end
end

for n = 1:nv
    if WT(n) ~= 0
        WTD(n) = dscores(n,:)*dscores2(WT(n),:)'/(norm(dscores(n,:))*norm(dscores2(WT(n),:)));
    else
        WTD(n) = 0;
    end
end
m = 1;

for n = 1:nv
    if WTD(n) <= 0.5
        lc1(m) = n;
        m = m+1;
    end
end

m = 1;

for n = 1:nv
    if WTD(n) > 0.5 && WTD(n) < 0.8 
        lc2(m) = n;
        m = m+1;
    end
end

m = 1;

for n = 1:nv
    if WTD(n) >= 0.8
        lc3(m) = n;
        m = m+1;
    end
end

lcl1 = length(lc1);
lcl2 = length(lc2);
lcl3 = length(lc3);

lcn1 = zeros(lcl1,1);

lcw1 = string(zeros(lcl1,1));
lcw2 = string(zeros(lcl2,1));
lcw3 = string(zeros(lcl3,1));

for n = 1:lcl1
    lcw1(n) = Voca(lc1(n));
end

for n = 1:lcl2
    lcw2(n) = Voca(lc2(n));
end

for n = 1:lcl3
    lcw3(n) = Voca(lc3(n));
end

for n = 1:lcl1
    for m = 1:nv
        if lcw1(n) == Win(m)
            lcn1(n) = m;
        end
    end
end
        
lcn1 = sort(lcn1);

Table3 = zeros(lcl3,1);
Table2 = zeros(lcl2,1);
Table1 = zeros(lcl1,1);

for n = 1:lcl3
    [SDM3, I3] = sort(DotM(lc3(n),:));
    cosLW3 = string(zeros(20,1));
    [SDM32, I32] = sort(DotM2(WT(lc3(n)),:));
    cosLW32 = string(zeros(20,1));
    
    for m = 1:20
        cosLW3(m) = Voca(I3(m));
    end
    
    for m = 1:20
        cosLW32(m) = Voca2(I32(m));
    end
    
    C = zeros(1,20);
    Trans = zeros(1,20);
    
    for k = 1:20
        for l = 1:20
            if cosLW3(k) == cosLW32(l)
                C(k) = 1;
                Trans(k) = l;
            end    
        end
    end
    
    c = 0;
           
    for k = 1:20
        if C(k) == 1
            c = c+1;
        end
    end
 
    Table3(n) = c;
end

m = 0;

for n = 1:lcl3
    if Table3(n) <= 18
        m = m+1;
    end
end

Count3 = m

for n = 1:lcl2
    [SDM2, I2] = sort(DotM(lc2(n),:));
    cosLW2 = string(zeros(20,1));
    [SDM22, I22] = sort(DotM2(WT(lc2(n)),:));
    cosLW22 = string(zeros(20,1));
    
    for m = 1:20
        cosLW2(m) = Voca(I2(m));
    end
    
    for m = 1:20
        cosLW22(m) = Voca2(I22(m));
    end
    
    C = zeros(1,20);
    Trans = zeros(1,20);
    
    for k = 1:20
        for l = 1:20
            if cosLW2(k) == cosLW22(l)
                C(k) = 1;
                Trans(k) = l;
            end    
        end
    end
    
    c = 0;
           
    for k = 1:20
        if C(k) == 1
            c = c+1;
        end
    end
 
    Table2(n) = c;
end

m = 0;

for n = 1:lcl2
    if Table2(n) <= 18
        m = m+1;
    end
end

Count2 = m

for n = 1:lcl1
    [SDM1, I1] = sort(DotM(lc1(n),:));
    cosLW1 = string(zeros(20,1));
    [SDM12, I12] = sort(DotM2(WT(lc2(n)),:));
    cosLW12 = string(zeros(20,1));
    
    for m = 1:20
        cosLW1(m) = Voca(I1(m));
    end
    
    for m = 1:20
        cosLW12(m) = Voca2(I12(m));
    end
    
    C = zeros(1,20);
    Trans = zeros(1,20);
    
    for k = 1:20
        for l = 1:20
            if cosLW1(k) == cosLW12(l)
                C(k) = 1;
                Trans(k) = l;
            end    
        end
    end
    
    c = 0;
           
    for k = 1:20
        if C(k) == 1
            c = c+1;
        end
    end
 
    Table1(n) = c;
end

m = 0;

for n = 1:lcl1
    if Table1(n) <= 18
        m = m+1;
    end
end

Count1 = m

AA = zeros(lcl1,1);
BB = zeros(lcl1,1);
CC = zeros(lcl1,1);

for n = 1:282
    if WT(lc1(n)) ~= 0
        AA(n) = WTD(lc1(n));
        BB(n) = norm(dscores(lc1(n),:))-norm(dscores2(WT(lc1(n)),:));
        CC(n) = norm(dscores(lc1(n),:)-dscores2(WT(lc1(n)),:));
    else
        AA(n) = WTD(lc1(n));
        BB(n) = 0;
        CC(n) = norm(dscores(lc1(n),:));
    end
end

TAB = [AA BB CC];

[TTT ITT] = sort(AA);
[TTTT ITTT] = sort(CC,'descend');

for n = 1:10
    TWW(n) = lcw1(ITT(n));
    TWWW(n) = lcw1(ITTT(n));
end

DD = zeros(nv,1);

for n = 1:nv
    if WT(n) ~= 0
        DD(n) = norm(dscores(n,:)-dscores2(WT(n),:));
    else
        DD(n) = norm(dscores(n,:));
    end
end