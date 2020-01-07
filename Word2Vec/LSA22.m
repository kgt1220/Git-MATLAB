
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
lcn2 = zeros(lcl2,1);
lcn3 = zeros(lcl3,1);

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
