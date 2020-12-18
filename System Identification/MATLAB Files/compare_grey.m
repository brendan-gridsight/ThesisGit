Ts = 5;


T_av = T(5000:7150,3);
T_e = T(5000:7150,5);
ghi = T(5000:7150,6);
h = T(5000:7150,7);


y = table2array([T_av]);
u = table2array([T_e ghi h]);

data = iddata(y,u,Ts);
data.TimeUnit = 'minutes';

compare(data,sys)