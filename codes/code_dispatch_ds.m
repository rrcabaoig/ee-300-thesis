% Dispatching Stage - Distribution System (DS)
clear;
define_constants;

%%%%% =============== Headers =============== %%%%%
headers{1} = 'snapshot';
% Diesel generators (10 outputs)
headers{2} = 'pg_1';
headers{3} = 'pg_7';
headers{4} = 'pg_27';
headers{5} = 'pg_35';
headers{6} = 'pg_37';
headers{7} = 'pg_46';
headers{8} = 'pg_50';
headers{9} = 'pg_65';
headers{10} = 'pg_67';
headers{11} = 'pg_69';
% Microgrid real power exchange at the PCC (7 outputs)
headers{12} = 'ppcc_5';
headers{13} = 'ppcc_15';
headers{14} = 'ppcc_23';
headers{15} = 'ppcc_32';
headers{16} = 'ppcc_42';
headers{17} = 'ppcc_56';
headers{18} = 'ppcc_63';
% Microgrid reactive power exchange at the PCC (7 outputs)
headers{19} = 'qpcc_5';
headers{20} = 'qpcc_15';
headers{21} = 'qpcc_23';
headers{22} = 'qpcc_32';
headers{23} = 'qpcc_42';
headers{24} = 'qpcc_56';
headers{25} = 'qpcc_63';
% Bus voltage magnitudes of the DS (69 outputs)
for bus_num = 1:69
    headers{bus_num + 25} = sprintf('v_%d', bus_num);
end
% Bus voltage angles of the DS (69 outputs)
for bus_num = 1:69
    headers{bus_num + 25 + 69} = sprintf('vang_%d', bus_num);
end
% Bus LMP values of the DS (69 outputs)
for bus_num = 1:69
    headers{bus_num + 25 + 69*2} = sprintf('lmp_%d', bus_num);
end
% Objective function value
headers{1 + 25 + 69*3} = 'objective_val';
% Time
headers{2 + 25 + 69*3} = 'time';
% Success flag
headers{3 + 25 + 69*3} = 'success';

clear pg_ppcc_qpcc_v_lmp_obj_ds;

%%%%% =============== Read the load pd and qd values, and RE pwg and ppv values =============== %%%%%
pd_qd_pre = readmatrix('..\data\pd_qd_pre_trainvaltest\pd_qd_pre_trainvaltest_ds69.csv');

%%%%% =============== Read the export and import information of each MG =============== %%%%%
ppcc_qpcc_offer_mg1 = readmatrix('..\data\ppcc_qpcc_offer_trainvaltest_mg\ppcc_qpcc_offer_trainvaltest_mg1.csv');
ppcc_qpcc_offer_mg2 = readmatrix('..\data\ppcc_qpcc_offer_trainvaltest_mg\ppcc_qpcc_offer_trainvaltest_mg2.csv');
ppcc_qpcc_offer_mg3 = readmatrix('..\data\ppcc_qpcc_offer_trainvaltest_mg\ppcc_qpcc_offer_trainvaltest_mg3.csv');
ppcc_qpcc_offer_mg4 = readmatrix('..\data\ppcc_qpcc_offer_trainvaltest_mg\ppcc_qpcc_offer_trainvaltest_mg4.csv');
ppcc_qpcc_offer_mg5 = readmatrix('..\data\ppcc_qpcc_offer_trainvaltest_mg\ppcc_qpcc_offer_trainvaltest_mg5.csv');
ppcc_qpcc_offer_mg6 = readmatrix('..\data\ppcc_qpcc_offer_trainvaltest_mg\ppcc_qpcc_offer_trainvaltest_mg6.csv');
ppcc_qpcc_offer_mg7 = readmatrix('..\data\ppcc_qpcc_offer_trainvaltest_mg\ppcc_qpcc_offer_trainvaltest_mg7.csv');

%%%%% =============== Load the MATPOWER case file =============== %%%%%
mpc = loadcase('.\cases\case69rrc');

n_buses = size(mpc.bus, 1); % number of buses

for row = 1:35040
    %%%%%%%%%% ============================================= DISPATCH INPUTS ============================================= %%%%%%%%%%
    %%%%% =============== Change the load pd and qd values of the case file =============== %%%%%
    for col = 1:2*n_buses+1
        if col == 1
            pg_ppcc_qpcc_v_lmp_obj_ds(row, 1) = pd_qd_pre(row, 1);
        else
            if col <= n_buses+1
                mpc.bus(col - 1, PD) = pd_qd_pre(row, col);
            else
                mpc.bus(col - n_buses - 1, QD) = pd_qd_pre(row, col);
            end
        end
    end

    %%%%% =============== Change the RE pwg and ppv values of the case file =============== %%%%%
    %%%%% ===== Solar; Bus: 18; Gen Number: 5 ===== %%%%%
    mpc.gen(5, PMAX) = pd_qd_pre(row, 2*n_buses + 2);
    mpc.gen(5, PMIN) = pd_qd_pre(row, 2*n_buses + 2);
    %%%%% ===== Wind; Bus: 20; Gen Number: 6 ===== %%%%%
    mpc.gen(6, PMAX) = pd_qd_pre(row, 2*n_buses + 3);
    mpc.gen(6, PMIN) = pd_qd_pre(row, 2*n_buses + 3);
    %%%%% ===== Wind; Bus: 28; Gen Number: 9 ===== %%%%%
    mpc.gen(9, PMAX) = pd_qd_pre(row, 2*n_buses + 4);
    mpc.gen(9, PMIN) = pd_qd_pre(row, 2*n_buses + 4);
    %%%%% ===== Solar; Bus: 29; Gen Number: 10 ===== %%%%%
    mpc.gen(10, PMAX) = pd_qd_pre(row, 2*n_buses + 5);
    mpc.gen(10, PMIN) = pd_qd_pre(row, 2*n_buses + 5);
    %%%%% ===== Wind; Bus: 36; Gen Number: 13 ===== %%%%%
    mpc.gen(13, PMAX) = pd_qd_pre(row, 2*n_buses + 6);
    mpc.gen(13, PMIN) = pd_qd_pre(row, 2*n_buses + 6);
    %%%%% ===== Solar; Bus: 39; Gen Number: 15 ===== %%%%%
    mpc.gen(15, PMAX) = pd_qd_pre(row, 2*n_buses + 7);
    mpc.gen(15, PMIN) = pd_qd_pre(row, 2*n_buses + 7);
    %%%%% ===== Wind; Bus: 44; Gen Number: 17 ===== %%%%%
    mpc.gen(17, PMAX) = pd_qd_pre(row, 2*n_buses + 8);
    mpc.gen(17, PMIN) = pd_qd_pre(row, 2*n_buses + 8);
    %%%%% ===== Solar; Bus: 52; Gen Number: 20 ===== %%%%%
    mpc.gen(20, PMAX) = pd_qd_pre(row, 2*n_buses + 9);
    mpc.gen(20, PMIN) = pd_qd_pre(row, 2*n_buses + 9);
    %%%%% ===== Solar; Bus: 59; Gen Number: 22 ===== %%%%%
    mpc.gen(22, PMAX) = pd_qd_pre(row, 2*n_buses + 10);
    mpc.gen(22, PMIN) = pd_qd_pre(row, 2*n_buses + 10);
    %%%%% ===== Wind; Bus: 62; Gen Number: 23 ===== %%%%%
    mpc.gen(23, PMAX) = pd_qd_pre(row, 2*n_buses + 11);
    mpc.gen(23, PMIN) = pd_qd_pre(row, 2*n_buses + 11);
    
    %%%%% =============== Include the export and import information of each MG =============== %%%%%
    % Include very small values in the gencost matrix to avoid the following error (makeAy: bad x axis data in row 2 of gencost matrix)
    %%%%% ===== MG 1; Bus: 63; Gen Number: 24 ===== %%%%%
    gen_num = 24;
    if ppcc_qpcc_offer_mg1(row, 2) <= 0 % MG export
        mpc.gen(gen_num, PMAX) = -ppcc_qpcc_offer_mg1(row, 2);
        mpc.gen(gen_num, PMIN) = 0;
        mpc.gen(gen_num, QMAX) = -ppcc_qpcc_offer_mg1(row, 3);
        mpc.gen(gen_num, QMIN) = -ppcc_qpcc_offer_mg1(row, 4);

        mpc.gencost(gen_num, 5) = 0;
        mpc.gencost(gen_num, 6) = 0;
        mpc.gencost(gen_num, 7) = -ceil(ppcc_qpcc_offer_mg1(row, 2)/2*1000)/1000 + 0.00000001; % first offer block
        mpc.gencost(gen_num, 8) = ppcc_qpcc_offer_mg1(row, 10) + 0.00000001; % first offer block
        mpc.gencost(gen_num, 9) = -ppcc_qpcc_offer_mg1(row, 2) + 0.00000002; % second offer block
        mpc.gencost(gen_num, 10) = ppcc_qpcc_offer_mg1(row, 9) + 0.00000002; % second offer block
    else % MG import
        mpc.gen(gen_num, PMAX) = -ppcc_qpcc_offer_mg1(row, 2);
        mpc.gen(gen_num, PMIN) = -ppcc_qpcc_offer_mg1(row, 2);
        mpc.gen(gen_num, QMAX) = -ppcc_qpcc_offer_mg1(row, 3);
        mpc.gen(gen_num, QMIN) = -ppcc_qpcc_offer_mg1(row, 4);

        mpc.gencost(gen_num, 5) = 0;
        mpc.gencost(gen_num, 6) = 0;
        mpc.gencost(gen_num, 7) = 0.00000001; % first offer block
        mpc.gencost(gen_num, 8) = 0.00000001; % first offer block
        mpc.gencost(gen_num, 9) = 0.00000002; % second offer block
        mpc.gencost(gen_num, 10) = 0.00000002; % second offer block
    end

    %%%%% ===== MG 2; Bus: 56; Gen Number: 21 ===== %%%%%
    gen_num = 21;
    if ppcc_qpcc_offer_mg2(row, 2) <= 0 % MG export
        mpc.gen(gen_num, PMAX) = -ppcc_qpcc_offer_mg2(row, 2);
        mpc.gen(gen_num, PMIN) = 0;
        mpc.gen(gen_num, QMAX) = -ppcc_qpcc_offer_mg2(row, 3);
        mpc.gen(gen_num, QMIN) = -ppcc_qpcc_offer_mg2(row, 4);

        mpc.gencost(gen_num, 5) = 0;
        mpc.gencost(gen_num, 6) = 0;
        mpc.gencost(gen_num, 7) = -ceil(ppcc_qpcc_offer_mg2(row, 2)/2*1000)/1000 + 0.00000001; % first offer block
        mpc.gencost(gen_num, 8) = ppcc_qpcc_offer_mg2(row, 10) + 0.00000001; % first offer block
        mpc.gencost(gen_num, 9) = -ppcc_qpcc_offer_mg2(row, 2) + 0.00000002; % second offer block
        mpc.gencost(gen_num, 10) = ppcc_qpcc_offer_mg2(row, 9) + 0.00000002; % second offer block
    else % MG import
        mpc.gen(gen_num, PMAX) = -ppcc_qpcc_offer_mg2(row, 2);
        mpc.gen(gen_num, PMIN) = -ppcc_qpcc_offer_mg2(row, 2);
        mpc.gen(gen_num, QMAX) = -ppcc_qpcc_offer_mg2(row, 3);
        mpc.gen(gen_num, QMIN) = -ppcc_qpcc_offer_mg2(row, 4);

        mpc.gencost(gen_num, 5) = 0;
        mpc.gencost(gen_num, 6) = 0;
        mpc.gencost(gen_num, 7) = 0.00000001; % first offer block
        mpc.gencost(gen_num, 8) = 0.00000001; % first offer block
        mpc.gencost(gen_num, 9) = 0.00000002; % second offer block
        mpc.gencost(gen_num, 10) = 0.00000002; % second offer block
    end

    %%%%% ===== MG 3; Bus: 23; Gen Number: 7 ===== %%%%%
    gen_num = 7;
    if ppcc_qpcc_offer_mg3(row, 2) <= 0 % MG export
        mpc.gen(gen_num, PMAX) = -ppcc_qpcc_offer_mg3(row, 2);
        mpc.gen(gen_num, PMIN) = 0;
        mpc.gen(gen_num, QMAX) = -ppcc_qpcc_offer_mg3(row, 3);
        mpc.gen(gen_num, QMIN) = -ppcc_qpcc_offer_mg3(row, 4);

        mpc.gencost(gen_num, 5) = 0;
        mpc.gencost(gen_num, 6) = 0;
        mpc.gencost(gen_num, 7) = -ceil(ppcc_qpcc_offer_mg3(row, 2)/2*1000)/1000 + 0.00000001; % first offer block
        mpc.gencost(gen_num, 8) = ppcc_qpcc_offer_mg3(row, 10) + 0.00000001; % first offer block
        mpc.gencost(gen_num, 9) = -ppcc_qpcc_offer_mg3(row, 2) + 0.00000002; % second offer block
        mpc.gencost(gen_num, 10) = ppcc_qpcc_offer_mg3(row, 9) + 0.00000002; % second offer block
    else % MG import
        mpc.gen(gen_num, PMAX) = -ppcc_qpcc_offer_mg3(row, 2);
        mpc.gen(gen_num, PMIN) = -ppcc_qpcc_offer_mg3(row, 2);
        mpc.gen(gen_num, QMAX) = -ppcc_qpcc_offer_mg3(row, 3);
        mpc.gen(gen_num, QMIN) = -ppcc_qpcc_offer_mg3(row, 4);

        mpc.gencost(gen_num, 5) = 0;
        mpc.gencost(gen_num, 6) = 0;
        mpc.gencost(gen_num, 7) = 0.00000001; % first offer block
        mpc.gencost(gen_num, 8) = 0.00000001; % first offer block
        mpc.gencost(gen_num, 9) = 0.00000002; % second offer block
        mpc.gencost(gen_num, 10) = 0.00000002; % second offer block
    end

    %%%%% ===== MG 4; Bus: 15; Gen Number: 4 ===== %%%%%
    gen_num = 4;
    if ppcc_qpcc_offer_mg4(row, 2) <= 0 % MG export
        mpc.gen(gen_num, PMAX) = -ppcc_qpcc_offer_mg4(row, 2);
        mpc.gen(gen_num, PMIN) = 0;
        mpc.gen(gen_num, QMAX) = -ppcc_qpcc_offer_mg4(row, 3);
        mpc.gen(gen_num, QMIN) = -ppcc_qpcc_offer_mg4(row, 4);

        mpc.gencost(gen_num, 5) = 0;
        mpc.gencost(gen_num, 6) = 0;
        mpc.gencost(gen_num, 7) = -ceil(ppcc_qpcc_offer_mg4(row, 2)/2*1000)/1000 + 0.00000001; % first offer block
        mpc.gencost(gen_num, 8) = ppcc_qpcc_offer_mg4(row, 10) + 0.00000001; % first offer block
        mpc.gencost(gen_num, 9) = -ppcc_qpcc_offer_mg4(row, 2) + 0.00000002; % second offer block
        mpc.gencost(gen_num, 10) = ppcc_qpcc_offer_mg4(row, 9) + 0.00000002; % second offer block
    else % MG import
        mpc.gen(gen_num, PMAX) = -ppcc_qpcc_offer_mg4(row, 2);
        mpc.gen(gen_num, PMIN) = -ppcc_qpcc_offer_mg4(row, 2);
        mpc.gen(gen_num, QMAX) = -ppcc_qpcc_offer_mg4(row, 3);
        mpc.gen(gen_num, QMIN) = -ppcc_qpcc_offer_mg4(row, 4);

        mpc.gencost(gen_num, 5) = 0;
        mpc.gencost(gen_num, 6) = 0;
        mpc.gencost(gen_num, 7) = 0.00000001; % first offer block
        mpc.gencost(gen_num, 8) = 0.00000001; % first offer block
        mpc.gencost(gen_num, 9) = 0.00000002; % second offer block
        mpc.gencost(gen_num, 10) = 0.00000002; % second offer block
    end

    %%%%% ===== MG 5; Bus: 5; Gen Number: 2 ===== %%%%%
    gen_num = 2;
    if ppcc_qpcc_offer_mg5(row, 2) <= 0 % MG export
        mpc.gen(gen_num, PMAX) = -ppcc_qpcc_offer_mg5(row, 2);
        mpc.gen(gen_num, PMIN) = 0;
        mpc.gen(gen_num, QMAX) = -ppcc_qpcc_offer_mg5(row, 3);
        mpc.gen(gen_num, QMIN) = -ppcc_qpcc_offer_mg5(row, 4);

        mpc.gencost(gen_num, 5) = 0;
        mpc.gencost(gen_num, 6) = 0;
        mpc.gencost(gen_num, 7) = -ceil(ppcc_qpcc_offer_mg5(row, 2)/2*1000)/1000 + 0.00000001; % first offer block
        mpc.gencost(gen_num, 8) = ppcc_qpcc_offer_mg5(row, 10) + 0.00000001; % first offer block
        mpc.gencost(gen_num, 9) = -ppcc_qpcc_offer_mg5(row, 2) + 0.00000002; % second offer block
        mpc.gencost(gen_num, 10) = ppcc_qpcc_offer_mg5(row, 9) + 0.00000002; % second offer block
    else % MG import
        mpc.gen(gen_num, PMAX) = -ppcc_qpcc_offer_mg5(row, 2);
        mpc.gen(gen_num, PMIN) = -ppcc_qpcc_offer_mg5(row, 2);
        mpc.gen(gen_num, QMAX) = -ppcc_qpcc_offer_mg5(row, 3);
        mpc.gen(gen_num, QMIN) = -ppcc_qpcc_offer_mg5(row, 4);

        mpc.gencost(gen_num, 5) = 0;
        mpc.gencost(gen_num, 6) = 0;
        mpc.gencost(gen_num, 7) = 0.00000001; % first offer block
        mpc.gencost(gen_num, 8) = 0.00000001; % first offer block
        mpc.gencost(gen_num, 9) = 0.00000002; % second offer block
        mpc.gencost(gen_num, 10) = 0.00000002; % second offer block
    end

    %%%%% ===== MG 6; Bus: 32; Gen Number: 11 ===== %%%%%
    gen_num = 11;
    if ppcc_qpcc_offer_mg6(row, 2) <= 0 % MG export
        mpc.gen(gen_num, PMAX) = -ppcc_qpcc_offer_mg6(row, 2);
        mpc.gen(gen_num, PMIN) = 0;
        mpc.gen(gen_num, QMAX) = -ppcc_qpcc_offer_mg6(row, 3);
        mpc.gen(gen_num, QMIN) = -ppcc_qpcc_offer_mg6(row, 4);

        mpc.gencost(gen_num, 5) = 0;
        mpc.gencost(gen_num, 6) = 0;
        mpc.gencost(gen_num, 7) = -ceil(ppcc_qpcc_offer_mg6(row, 2)/2*1000)/1000 + 0.00000001; % first offer block
        mpc.gencost(gen_num, 8) = ppcc_qpcc_offer_mg6(row, 10) + 0.00000001; % first offer block
        mpc.gencost(gen_num, 9) = -ppcc_qpcc_offer_mg6(row, 2) + 0.00000002; % second offer block
        mpc.gencost(gen_num, 10) = ppcc_qpcc_offer_mg6(row, 9) + 0.00000002; % second offer block
    else % MG import
        mpc.gen(gen_num, PMAX) = -ppcc_qpcc_offer_mg6(row, 2);
        mpc.gen(gen_num, PMIN) = -ppcc_qpcc_offer_mg6(row, 2);
        mpc.gen(gen_num, QMAX) = -ppcc_qpcc_offer_mg6(row, 3);
        mpc.gen(gen_num, QMIN) = -ppcc_qpcc_offer_mg6(row, 4);

        mpc.gencost(gen_num, 5) = 0;
        mpc.gencost(gen_num, 6) = 0;
        mpc.gencost(gen_num, 7) = 0.00000001; % first offer block
        mpc.gencost(gen_num, 8) = 0.00000001; % first offer block
        mpc.gencost(gen_num, 9) = 0.00000002; % second offer block
        mpc.gencost(gen_num, 10) = 0.00000002; % second offer block
    end

    %%%%% ===== MG 7; Bus: 42; Gen Number: 16 ===== %%%%%
    gen_num = 16;
    if ppcc_qpcc_offer_mg7(row, 2) <= 0 % MG export
        mpc.gen(gen_num, PMAX) = -ppcc_qpcc_offer_mg7(row, 2);
        mpc.gen(gen_num, PMIN) = 0;
        mpc.gen(gen_num, QMAX) = -ppcc_qpcc_offer_mg7(row, 3);
        mpc.gen(gen_num, QMIN) = -ppcc_qpcc_offer_mg7(row, 4);

        mpc.gencost(gen_num, 5) = 0;
        mpc.gencost(gen_num, 6) = 0;
        mpc.gencost(gen_num, 7) = -ceil(ppcc_qpcc_offer_mg7(row, 2)/2*1000)/1000 + 0.00000001; % first offer block
        mpc.gencost(gen_num, 8) = ppcc_qpcc_offer_mg7(row, 10) + 0.00000001; % first offer block
        mpc.gencost(gen_num, 9) = -ppcc_qpcc_offer_mg7(row, 2) + 0.00000002; % second offer block
        mpc.gencost(gen_num, 10) = ppcc_qpcc_offer_mg7(row, 9) + 0.00000002; % second offer block
    else % MG import
        mpc.gen(gen_num, PMAX) = -ppcc_qpcc_offer_mg7(row, 2);
        mpc.gen(gen_num, PMIN) = -ppcc_qpcc_offer_mg7(row, 2);
        mpc.gen(gen_num, QMAX) = -ppcc_qpcc_offer_mg7(row, 3);
        mpc.gen(gen_num, QMIN) = -ppcc_qpcc_offer_mg7(row, 4);

        mpc.gencost(gen_num, 5) = 0;
        mpc.gencost(gen_num, 6) = 0;
        mpc.gencost(gen_num, 7) = 0.00000001; % first offer block
        mpc.gencost(gen_num, 8) = 0.00000001; % first offer block
        mpc.gencost(gen_num, 9) = 0.00000002; % second offer block
        mpc.gencost(gen_num, 10) = 0.00000002; % second offer block
    end

    %%%%%%%%%% ============================================= DISPATCH AC OPF PROPER ============================================= %%%%%%%%%%
    start_time = tic;
    results = runopf(mpc);
    end_time = toc(start_time);

    %%%%%%%%%% ============================================= DISPATCH OUTPUTS ============================================= %%%%%%%%%%
    %%%%% ===== Diesel pg ===== %%%%%
    pg_ppcc_qpcc_v_lmp_obj_ds(row, 2) = results.gen(1, PG); % Diesel; Bus: 1; Gen Number: 1
    pg_ppcc_qpcc_v_lmp_obj_ds(row, 3) = results.gen(3, PG); % Diesel; Bus: 7; Gen Number: 3
    pg_ppcc_qpcc_v_lmp_obj_ds(row, 4) = results.gen(8, PG); % Diesel; Bus: 27; Gen Number: 8
    pg_ppcc_qpcc_v_lmp_obj_ds(row, 5) = results.gen(12, PG); % Diesel; Bus: 35; Gen Number: 12
    pg_ppcc_qpcc_v_lmp_obj_ds(row, 6) = results.gen(14, PG); % Diesel; Bus: 37; Gen Number: 14
    pg_ppcc_qpcc_v_lmp_obj_ds(row, 7) = results.gen(18, PG); % Diesel; Bus: 46; Gen Number: 18
    pg_ppcc_qpcc_v_lmp_obj_ds(row, 8) = results.gen(19, PG); % Diesel; Bus: 50; Gen Number: 19
    pg_ppcc_qpcc_v_lmp_obj_ds(row, 9) = results.gen(25, PG); % Diesel; Bus: 65; Gen Number: 25
    pg_ppcc_qpcc_v_lmp_obj_ds(row, 10) = results.gen(26, PG); % Diesel; Bus: 67; Gen Number: 26
    pg_ppcc_qpcc_v_lmp_obj_ds(row, 11) = results.gen(27, PG); % Diesel; Bus: 69; Gen Number: 27
    %%%%% ===== MG ppcc ===== %%%%%
    pg_ppcc_qpcc_v_lmp_obj_ds(row, 12) = results.gen(2, PG); % MG 5; Bus: 5; Gen Number: 2
    pg_ppcc_qpcc_v_lmp_obj_ds(row, 13) = results.gen(4, PG); % MG 4; Bus: 15; Gen Number: 4
    pg_ppcc_qpcc_v_lmp_obj_ds(row, 14) = results.gen(7, PG); % MG 3; Bus: 23; Gen Number: 7
    pg_ppcc_qpcc_v_lmp_obj_ds(row, 15) = results.gen(11, PG); % MG 6; Bus: 32; Gen Number: 11
    pg_ppcc_qpcc_v_lmp_obj_ds(row, 16) = results.gen(16, PG); % MG 7; Bus: 42; Gen Number: 16
    pg_ppcc_qpcc_v_lmp_obj_ds(row, 17) = results.gen(21, PG); % MG 2; Bus: 56; Gen Number: 21
    pg_ppcc_qpcc_v_lmp_obj_ds(row, 18) = results.gen(24, PG); % MG 1; Bus: 63; Gen Number: 24
    %%%%% ===== MG qpcc ===== %%%%%
    pg_ppcc_qpcc_v_lmp_obj_ds(row, 19) = results.gen(2, QG); % MG 5; Bus: 5; Gen Number: 2
    pg_ppcc_qpcc_v_lmp_obj_ds(row, 20) = results.gen(4, QG); % MG 4; Bus: 15; Gen Number: 4
    pg_ppcc_qpcc_v_lmp_obj_ds(row, 21) = results.gen(7, QG); % MG 3; Bus: 23; Gen Number: 7
    pg_ppcc_qpcc_v_lmp_obj_ds(row, 22) = results.gen(11, QG); % MG 6; Bus: 32; Gen Number: 11
    pg_ppcc_qpcc_v_lmp_obj_ds(row, 23) = results.gen(16, QG); % MG 7; Bus: 42; Gen Number: 16
    pg_ppcc_qpcc_v_lmp_obj_ds(row, 24) = results.gen(21, QG); % MG 2; Bus: 56; Gen Number: 21
    pg_ppcc_qpcc_v_lmp_obj_ds(row, 25) = results.gen(24, QG); % MG 1; Bus: 63; Gen Number: 24
    %%%%% ===== Bus v ===== %%%%%
    for bus_num = 1:69
        pg_ppcc_qpcc_v_lmp_obj_ds(row, bus_num + 25) = results.bus(bus_num, VM);
    end
    %%%%% ===== Bus vang ===== %%%%%
    for bus_num = 1:69
        pg_ppcc_qpcc_v_lmp_obj_ds(row, bus_num + 25 + 69) = results.bus(bus_num, VA);
    end
    %%%%% ===== Bus lmp ===== %%%%%
    for bus_num = 1:69
        pg_ppcc_qpcc_v_lmp_obj_ds(row, bus_num + 25 + 69*2) = results.bus(bus_num, LAM_P);
    end
    %%%%% ===== Objective function value ===== %%%%%
    pg_ppcc_qpcc_v_lmp_obj_ds(row, 1 + 25 + 69*3) = results.f;
    %%%%% ===== Time ===== %%%%%
    pg_ppcc_qpcc_v_lmp_obj_ds(row, 2 + 25 + 69*3) = end_time;
    %%%%% ===== Success flag ===== %%%%%
    pg_ppcc_qpcc_v_lmp_obj_ds(row, 3 + 25 + 69*3) = results.success;
end

%%%%% =============== Combine the headers and the numerical dataset =============== %%%%%
pg_ppcc_qpcc_v_lmp_obj_ds = [headers; num2cell(pg_ppcc_qpcc_v_lmp_obj_ds)];

%%%%% =============== Write the outputs =============== %%%%%
writecell(pg_ppcc_qpcc_v_lmp_obj_ds, '..\data\pg_ppcc_qpcc_v_lmp_obj_trainvaltest_ds\pg_ppcc_qpcc_v_lmp_obj_trainvaltest_ds69.csv');