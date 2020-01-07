clear; clc;

%Tokenization of the raw text.

documents = novelsDocuments;
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

% Cosine similarity between word vectors.

DotM = zeros(length(mdl.Vocabulary),length(mdl.Vocabulary));

for n = 1:length(mdl.Vocabulary)
    for m = 1:length(mdl.Vocabulary)
        DotM(n,m) = 1-dscores(n,:)*dscores(m,:)'/(norm(dscores(n,:))*norm(dscores(m,:)));
    end
end

DotM2 = zeros(length(mdl2.Vocabulary),length(mdl2.Vocabulary));

for n = 1:length(mdl2.Vocabulary)
    for m = 1:length(mdl2.Vocabulary)
        DotM2(n,m) = 1-dscores2(n,:)*dscores2(m,:)'/(norm(dscores2(n,:))*norm(dscores2(m,:)));
    end
end

% Words close to 'winter' for cosine similarity.
 
% for n = 1:length(mdl.Vocabulary)
%     if mdl.Vocabulary(n) == 'winter'
%         w = n;
%     end
% end
% 
% SortDM = sort(DotM(w,:))';
% n = 1;
% 
% while n <= 3092
%     for m = 1:length(mdl.Vocabulary)
%         if SortDM(n) == DotM(w,m)
%             Win(n) = mdl.Vocabulary(m);
%             n = n + 1;
%         end
%     end
% end
% 
% Win = Win(1,1:length(mdl.Vocabulary))';

%% Transformation between two embeddings.

% Finding word non-related to 'winter'.

 for n = 1:length(mdl.Vocabulary)
    if mdl.Vocabulary(n) == 'growing'
        r = n;
    end
 end

 for n = 1:length(mdl2.Vocabulary)
    if mdl2.Vocabulary(n) == 'growing'
        r2 = n;
    end
 end
 
% Words close to non-related word for cosine similarity.

SortDM = sort(DotM(r,:))';
n = 1;

while n <= 100
    for m = 1:length(mdl.Vocabulary)
        if SortDM(n) == DotM(r,m)
            rW1(n) = m;
            rcosW1(n) = mdl.Vocabulary(m);
            n = n + 1;
        end
    end
end

rW1 = rW1(1,1:100)';
rcosW1 = rcosW1(1,1:100)';

SortDM2 = sort(DotM2(r2,:))';
n = 1;

while n <= 100
    for m = 1:length(mdl2.Vocabulary)
       if SortDM2(n) == DotM2(r2,m)
           rW2(n) = m;
           rcosW2(n) = mdl2.Vocabulary(m);
           n = n + 1;
       end
    end
end

rW2 = rW2(1,1:100)';
rcosW2 = rcosW2(1,1:100)';

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
    rWV1(n,:) = dscores(rW1(n),:);
    rWV2(n,:) = dscores2(rW2(n),:);
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

for n = 1:length(bag1.Vocabulary)
    if mdl.Vocabulary(n) == 'frost'
        f = n;
    end
end

for n = 1:length(bag2.Vocabulary)
    if mdl2.Vocabulary(n) == 'frost'
        f2 = n;
    end
end

SortDM = sort(DotM(f,:))';
n = 1;

while n <= 100
    for m = 1:length(bag1.Vocabulary)
        if SortDM(n) == DotM(f,m)
            W1(n) = m;
            cosW1(n) = mdl.Vocabulary(m);
            n = n + 1;
        end
    end
end

W1 = W1(1,1:100)';
cosW1 = cosW1(1,1:100)';

SortDM2 = sort(DotM2(f2,:))';
n = 1;

while n <= 100
    for m = 1:length(bag2.Vocabulary)
       if SortDM2(n) == DotM2(f2,m)
           W2(n) = m;
           cosW2(n) = mdl2.Vocabulary(m);
           n = n + 1;
       end
    end
end

W2 = W2(1,1:100)';
cosW2 = cosW2(1,1:100)';

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
    WV1(n,:) = dscores(W1(n),:);
    WV2(n,:) = dscores2(W2(n),:);
end

N1 = zeros(100,1);
N2 = zeros(100,1);

for n = 1:100
    N1(n,1) = norm(dscores(f,:)-WV1(n,:));
    N2(n,1) = norm(dscores2(f2,:)-WV2(n,:));
end

%% Effect of winter on two embeddings.

MWV1 = zeros(20,20);
MWV1(1,:) = WV1(1,:);
IndexMV = zeros(20,1);
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

FV1 = FV1(1:20,1:20);
FV2 = FV2(1:20,1:20);

T = FV1/FV2;

%% Plot.

FV1n = zeros(20,1);
FV2n = zeros(20,1);
FVn = zeros(20,1);

for n = 1:20
    FV1n(n) = norm(FV1(n,:));
    FV2n(n) = norm(FV2(n,:));
    FVn(n) = FV1n(n)-FV2n(n);
end    

xaxis = [1:20];
figure
plot(xaxis,FVn');
title('Euclidean distance for each words between two embeddings')
xlabel('20 embedded words related to frost')
ylabel('Euclidean distance')

FVc = zeros(20,1);

for n = 1:20
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