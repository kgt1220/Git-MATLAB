function [Yt] = output_average_summation(InitLen,ave_number,data)
%raw = load('data_MackeyGlass_t17.txt');
raw = data';
n = ave_number;
gagong1 = zeros(7000,1);
    for i = 1:n
    gagong1(:,i) = (raw(i:i+6999));
    end
    const1 = 1;% 10 0; %const2 = 0; const3 = 0;
    const2 = 3; const3 = 5;%;randn(1);
    summation = const1*gagong1+const2*gagong1.^2+const3*gagong1.^3;
    gagong2 = sum(summation,2)/n;
    gagong3 = [ones(n-1,1);gagong2];
 Yt = gagong3(InitLen+1:end);
end