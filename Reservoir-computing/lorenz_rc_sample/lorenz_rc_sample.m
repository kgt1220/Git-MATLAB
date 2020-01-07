clear; clc; close all;
% lorenz system을 이용해서 만든 reservoir computing 코드로
% 확인할 task는 rossler attractor의 x-data를 넣고 y-data를 만들어보는 것.
% 때문에 한번에 reservoir를 다 만들어놓고 train부분과 test부분을 그냥 잘라서 결과 비교 가능.
addpath Functions % 이 코드파일이 포함된 파일안의 폴더의 함수를 사용하겠다는 표시

%% Lorenz system을 reservoir로 사용하기 위한 initial condition 설정.
% N : 노드의 수 / K : system의 node간에 작용하는 힘 / xyz_given : initial position /
% 나머지는 lorenz system자체가 갖는 parameter
r = 28; N = 50;
load(['./order_sequence_diverse_Nodes/r' num2str(r) 'order_sequence_Node' num2str(N) '_lin113.mat'])
% 사전에 조건에 맞는 reservoir를 만들기 위한 설정된 값들을 저장해두고 불러옴. N은 10:10:200 가능, r은 28만 가능

load('./Data/rossler_xyz.mat'); data = rossler_xyz(:,1); data = 10*(data/max(abs(data))); 
%input으로 사용할 데이터를 불러오고 나름대로 scale시켜서 집어넣음. 실제로는 scale이 엄청 큰 영향을 주진 않음.
limit = 4000; % 만드려고 하는 총 reservoir 크기 여기에 initLen, trainLne, testLen 모두 포함

K = 3; xyz_given = XYZ_position{round(K*K_step_inv)+1}; 

%% reservoir matrix를 만드는 부분으로 해당 function 코드로 이동해서 lorenz system이 어떻게 reservoir를 만드는지 봐야함.
%% echo state network과는 달리 oscillator를 이용할 때는 euler method 이용시 system의 attractor를 제대로 못구할수도 있으므로 rk4 method를 이용.
[reservoir_x, ~ , ~] = LR_reservoir_xyz_news(r,N,A,q,K,limit,w,data,h,xyz_given);

%% reservoir 쪼갤 각 구간 설정.
InitLen = 1000;
TrainLen = 2000;
TestLen = 1000;

%% test부분
push = 0; % 무시 쌉가능 이거저거 테스트하다 생긴 변수
Y_recon  = rossler_xyz(:,2);  Z_recon  = rossler_xyz(:,3); % target output 설정

% train과 test에 사용할 output을 나누는 부분
Yt = Y_recon(InitLen+1:end);
Yt_train = Yt( push+1: push+TrainLen);
Yt_test = Yt( push+TrainLen+1: push+TrainLen+TestLen);

% train과 test에 사용할 reservoir를 나누는 부분
X_all = reservoir_x;
X_train = X_all(:, InitLen+push+1: InitLen+push+TrainLen);
X_test = X_all(:, InitLen+push+TrainLen+1: InitLen+push+TrainLen+TestLen);

%% Train Wout. Wout 훈련하는 부분으로 function들어가 보면 별거없음. 왜 굳이 function으로 만들었었는지 기억이 안남.
[Wout] = func_RC_training(X_train, Yt_train);
fprintf('Almost done \n')

%% Derive error하는 부분 relative error를 구함.
train_error = sum((Yt_train'-Wout*X_train).^2)./sum((Yt_train').^2);
test_error = sum((Yt_test'-Wout*X_test).^2)./sum((Yt_test').^2);

%% plotting
subplot(2,1,1)
plot(Yt_train','r'); hold on; plot(Wout*X_train,'b')
subplot(2,1,2)
plot(Yt_test','r'); hold on; plot(Wout*X_test,'b')