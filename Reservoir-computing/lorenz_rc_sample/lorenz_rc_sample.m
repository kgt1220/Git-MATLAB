clear; clc; close all;
% lorenz system�� �̿��ؼ� ���� reservoir computing �ڵ��
% Ȯ���� task�� rossler attractor�� x-data�� �ְ� y-data�� ������ ��.
% ������ �ѹ��� reservoir�� �� �������� train�κа� test�κ��� �׳� �߶� ��� �� ����.
addpath Functions % �� �ڵ������� ���Ե� ���Ͼ��� ������ �Լ��� ����ϰڴٴ� ǥ��

%% Lorenz system�� reservoir�� ����ϱ� ���� initial condition ����.
% N : ����� �� / K : system�� node���� �ۿ��ϴ� �� / xyz_given : initial position /
% �������� lorenz system��ü�� ���� parameter
r = 28; N = 50;
load(['./order_sequence_diverse_Nodes/r' num2str(r) 'order_sequence_Node' num2str(N) '_lin113.mat'])
% ������ ���ǿ� �´� reservoir�� ����� ���� ������ ������ �����صΰ� �ҷ���. N�� 10:10:200 ����, r�� 28�� ����

load('./Data/rossler_xyz.mat'); data = rossler_xyz(:,1); data = 10*(data/max(abs(data))); 
%input���� ����� �����͸� �ҷ����� ������� scale���Ѽ� �������. �����δ� scale�� ��û ū ������ ���� ����.
limit = 4000; % ������� �ϴ� �� reservoir ũ�� ���⿡ initLen, trainLne, testLen ��� ����

K = 3; xyz_given = XYZ_position{round(K*K_step_inv)+1}; 

%% reservoir matrix�� ����� �κ����� �ش� function �ڵ�� �̵��ؼ� lorenz system�� ��� reservoir�� ������� ������.
%% echo state network���� �޸� oscillator�� �̿��� ���� euler method �̿�� system�� attractor�� ����� �����Ҽ��� �����Ƿ� rk4 method�� �̿�.
[reservoir_x, ~ , ~] = LR_reservoir_xyz_news(r,N,A,q,K,limit,w,data,h,xyz_given);

%% reservoir �ɰ� �� ���� ����.
InitLen = 1000;
TrainLen = 2000;
TestLen = 1000;

%% test�κ�
push = 0; % ���� �԰��� �̰����� �׽�Ʈ�ϴ� ���� ����
Y_recon  = rossler_xyz(:,2);  Z_recon  = rossler_xyz(:,3); % target output ����

% train�� test�� ����� output�� ������ �κ�
Yt = Y_recon(InitLen+1:end);
Yt_train = Yt( push+1: push+TrainLen);
Yt_test = Yt( push+TrainLen+1: push+TrainLen+TestLen);

% train�� test�� ����� reservoir�� ������ �κ�
X_all = reservoir_x;
X_train = X_all(:, InitLen+push+1: InitLen+push+TrainLen);
X_test = X_all(:, InitLen+push+TrainLen+1: InitLen+push+TrainLen+TestLen);

%% Train Wout. Wout �Ʒ��ϴ� �κ����� function�� ���� ���ž���. �� ���� function���� ����������� ����� �ȳ�.
[Wout] = func_RC_training(X_train, Yt_train);
fprintf('Almost done \n')

%% Derive error�ϴ� �κ� relative error�� ����.
train_error = sum((Yt_train'-Wout*X_train).^2)./sum((Yt_train').^2);
test_error = sum((Yt_test'-Wout*X_test).^2)./sum((Yt_test').^2);

%% plotting
subplot(2,1,1)
plot(Yt_train','r'); hold on; plot(Wout*X_train,'b')
subplot(2,1,2)
plot(Yt_test','r'); hold on; plot(Wout*X_test,'b')