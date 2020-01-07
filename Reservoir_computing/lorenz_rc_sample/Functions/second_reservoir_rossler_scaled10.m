function second_reservoir_rossler_scaled10(r,N)
mkdir (['./Reservoirs/Lin1-1.3/Rossler/scaled10/N' num2str(N) ''])

load(['./order_sequence_diverse_Nodes/r' num2str(r) 'order_sequence_Node' num2str(N) '_lin113.mat'])
load('./Data/rossler_xyz.mat'); data = rossler_xyz(:,1); data = 10*(data/max(abs(data)));
limit = 7000; % 1000 remove 4000 use
K_step = -K_step_minus; K_final = 5;

    for K = K_start:K_step:K_final
        
        xyz_given = XYZ_position{round(K*K_step_inv)+1};
        tic
        [reservoir_x, ~ , ~] = LR_reservoir_xyz_news(r,N,A,q,K,limit,w,data,h,xyz_given);
        save(['./Reservoirs/Lin1-1.3/Rossler/scaled10/N' num2str(N) '/r' num2str(r) 'K' num2str(K) 'limit' num2str(limit) '.mat'])
        fprintf('r = %d, ep = %d \n', r, K)
        toc
    end

    
end