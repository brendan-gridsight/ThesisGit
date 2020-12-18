function [A, B, C, D] = state_space_model(C_i, C_w, R_w, A_e, A_w,Ts)
A = [-(1/(C_i*R_w)), (1/(C_i*R_w)); (1/(C_w*R_w)), -(2/(C_w*R_w))];
B = [0, (A_w/C_i), (1/C_i); (1/(R_w*C_w)), (A_e/C_w), 0];
C = [1, 0];
D = [0, 0, 0];
end

% function [A, B, C, D] = state_space_model(C_i, C_w, R_w, A_w,Ts)
% A = [-(1/(C_i*R_w)), (1/(C_i*R_w)); (1/(C_w*R_w)), -(2/(C_w*R_w))];
% B = [0, (A_w/C_i), (1/C_i); (1/(R_w*C_w)), 0, 0];
% C = [1, 0];
% D = [0, 0, 0];
% end
