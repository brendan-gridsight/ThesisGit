
%% Intialise State Space Model and firrst guesses of identifiable paramters
odefun = 'state_space_model';

%Initial guesses
C_i = 0.75;
C_w = 22;
R_w = 8;
A_e = 20;
A_w = 1;

parameters = {'C_i',C_i;'C_w',C_w;'R_w',R_w;'A_e',A_e;'A_w',A_w};
%parameters = {'C_i',C_i;'C_w',C_w;'R_w',R_w;'A_w',A_w};
fcn_type = 'c';
init_sys = idgrey(odefun,parameters,fcn_type);


%% Place constraints on parameters
% %C_i
% init_sys.Structure.Parameters(1).Minimum = 0.01;
% init_sys.Structure.Parameters(1).Maximum = 5;
% 
% %C_w
% init_sys.Structure.Parameters(2).Minimum = 1;
% init_sys.Structure.Parameters(2).Maximum = 40;
% 
% %R_w
% init_sys.Structure.Parameters(3).Minimum = 2;
% init_sys.Structure.Parameters(3).Maximum = 20;
% 
% % A_w
% init_sys.Structure.Parameters(4).Minimum = 0.5;
% init_sys.Structure.Parameters(4).Maximum = 50;
% 
% %A_g
% init_sys.Structure.Parameters(5).Minimum = 0.01;
% init_sys.Structure.Parameters(5).Maximum = 5;

%% Import and split training data
T = readtable('training_data.csv');

train_time = [1:5726,8020:8353];
%train_time = 1:5200;
test_time = 5727:8021;

T_av = T(train_time,3);
T_e = T(train_time,5);
ghi = T(train_time,6);
h = T(train_time,7);

y = table2array([T_av]);
u = table2array([T_e, ghi, h]);


Ts=1/12; % minute time steps
data = iddata(y,u,Ts);
data.TimeUnit = 'hours'

%% Identify model
opt = greyestOptions('InitialState',[19.2; 19.2], 'EnforceStability',true);
[sys, x0] = greyest(data,init_sys, opt)

%% Compare with measure data

T_av_test = T(test_time,3);
T_e_test = T(test_time,5);
ghi_test = T(test_time,6);
h_test = T(test_time,7);


y = table2array([T_av_test]);
u = table2array([T_e_test, ghi_test, h_test]);

data = iddata(y,u,Ts);
data.TimeUnit = 'hours';

compare(data,sys)



