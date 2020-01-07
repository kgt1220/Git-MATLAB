function first_order(r,N)

%% initial state for dynamics, series & backward synchronization
%dynamics, series
w = linspace(1,1.3,N)'; A = ones(N,N) - eye(N); h = 0.01; 
K_final = 5; K_step_minus = -0.1; K_start = 0; K_step_inv = round(1/abs(K_step_minus));
%backward synchronization
K = K_final; b = 8/3; sigma = 10; q = 0.7; init_time = 4000; 
x1ran_const = -sqrt((b*sigma*(r-1)-b*K*(1-q))/(sigma+K*(1-q))); y1ran_const = ((sigma+K*(1-q))*x1ran_const)/sigma; z1ran_const = (x1ran_const*y1ran_const)/b;
x1ran = x1ran_const*ones(N,1); y1ran = y1ran_const*ones(N,1); z1ran = z1ran_const*ones(N,1);

for K = K_final:K_step_minus:K_start
    
    [order_Vx,order_Vy,order_Vz,order_R,order_A,xyz_position] = LR_order_xyz_news(r,N,A,q,K,w,h,x1ran,y1ran,z1ran,init_time);
    x1ran = xyz_position(1:N);
    y1ran = xyz_position(N+1:2*N);
    z1ran = xyz_position(2*N+1:3*N);
    fprintf('For r = %d, K = %d, order = %d and %d \n', r, K, order_Vx,order_A)
    Order_Vx(1,round(K*K_step_inv)+1) = order_Vx; Order_Vy(1,round(K*K_step_inv)+1) = order_Vy;  Order_Vz(1,round(K*K_step_inv)+1) = order_Vz; Order_R(1,round(K*K_step_inv)+1) = order_R;
    Order_A(1,round(K*K_step_inv)+1) = order_A; XYZ_position{1,round(K*K_step_inv)+1} = xyz_position;

end
save(['./order_sequence_diverse_Nodes/r' num2str(r) 'order_sequence_Node' num2str(N) '_lin113.mat'])
end

