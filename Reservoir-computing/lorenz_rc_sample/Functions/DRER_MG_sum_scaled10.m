function DRER_MG_sum_scaled10(r,N)
InitLen = 1000;
TrainLen = 4000;
TestLen = 1000; 
K_start = 0; K_step = 0.1; K_final = 5;
push = 0;
data = load('./Data/data_MackeyGlass_t17.txt'); ave_number = 20;
Yt  =  output_average_summation(InitLen,ave_number,data);


%Yt = Y_sum(InitLen+1:end);
Yt_train = Yt( push+1: push+TrainLen);
Yt_test = Yt( push+TrainLen+1: push+TrainLen+TestLen);

for K = K_start:K_step:K_final
  %  tic
    time = round(K*(1/K_step)-K_start*(1/K_step)+1);
    
    %load(['./trash/new system/r' num2str(r) 'K' num2str(K) 'reservoir4000_news_rosslerx.mat']);

    load(['./Reservoirs/Lin1-1.3/MG/scaled10/N' num2str(N) '/r' num2str(r) 'K' num2str(K) 'limit7000.mat']);
      
    X_all = reservoir_x;
    X_train = X_all(:, InitLen+push+1: InitLen+push+TrainLen);
    X_test = X_all(:, InitLen+push+TrainLen+1: InitLen+push+TrainLen+TestLen);
    
    %% Train Wout
    [Wout] = func_RC_training(X_train, Yt_train);
  %  fprintf('Almost done \n')
    
    %% Derive error
    train_error = sum((Yt_train'-Wout*X_train).^2)./sum((Yt_train').^2);
    test_error = sum((Yt_test'-Wout*X_test).^2)./sum((Yt_test').^2);
    
    %[train_error, test_error] = func_Error(Yt_train, Yt_test, Wout, X_train, X_test);
    Train_mse(1,time) = train_error;
    Test_mse(1,time) = test_error;
    fprintf('For %i, train error is %i \n', K, train_error)
    fprintf('For %i, test error is %i \n\n', K, test_error)
    
  %  toc
end
    fprintf('For r = %d done',r)
save(['./Errors/Lin1-1.3/MG/scaled10_train' num2str(TrainLen) ',r' num2str(r) 'N' num2str(N) 'K' num2str(K) '.mat'],'K','N','Train_mse','Test_mse','InitLen','TrainLen','TestLen','data','Yt','w')
end