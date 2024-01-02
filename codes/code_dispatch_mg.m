% Dispatching Stage - Microgrids (MGs)
clear;
define_constants;

%%%%% =============== Read the dispatch instruction of the DS =============== %%%%%
pg_qg_ppcc_qpcc_v_lmp_obj_ds = readmatrix('..\data\pg_qg_ppcc_qpcc_v_lmp_obj_trainvaltest_ds\pg_qg_ppcc_qpcc_v_lmp_obj_trainvaltest_ds69.csv');

%%%%% =============== Locate the MGs in the DS =============== %%%%%
%   mg - bus_ds - order
mg_ds_loc = [
    1   63  7;
    2   56  6;
    3   23  3;
    4   15  2;
    5   5   1;
    6   32  4;
    7   42  5;
    ];

for mg_num = 1:7
    clear pg_qg_v_lmp_obj_mg;
    clear headers;

    %%%%% =============== Read the load pd and qd values, and RE pwg and ppv values =============== %%%%%
    pd_qd_pre_file = sprintf('pd_qd_pre_trainvaltest_mg%d.csv', mg_num);
    pd_qd_pre_file_path = fullfile('..\data\pd_qd_pre_trainvaltest\', pd_qd_pre_file);
    pd_qd_pre = readmatrix(pd_qd_pre_file_path);

    %%%%% =============== Load the MATPOWER case file =============== %%%%%
    casemg_file = sprintf('casemg%d', mg_num);
    casemg_file_path = fullfile('.\cases\', casemg_file);
    mpc = loadcase(casemg_file_path);

    n_buses = size(mpc.bus, 1); % number of buses
    n_gen = size(mpc.gen, 1); % number of generators

    %%%%% =============== Headers =============== %%%%%
    col = 1;
    headers{col} = 'snapshot';
    % Diesel generator real power output
    for gen_num = 1:n_gen-1 % exclude the dummy generator at the PCC
        if mpc.gen(gen_num, PMAX) ~= mpc.gen(gen_num, PMIN) % diesel only, exclude RE resources
            col = col + 1;
            headers{col} = sprintf('pg_%d', mpc.gen(gen_num, GEN_BUS));
        end
    end
    % Diesel generator reactive power output
    for gen_num = 1:n_gen-1 % exclude the dummy generator at the PCC
        if mpc.gen(gen_num, PMAX) ~= mpc.gen(gen_num, PMIN) % diesel only, exclude RE resources
            col = col + 1;
            headers{col} = sprintf('qg_%d', mpc.gen(gen_num, GEN_BUS));
        end
    end
    % Bus voltage magnitudes
    for bus_num = 1:n_buses
        col = col + 1;
        headers{col} = sprintf('v_%d', bus_num);
    end
    % Bus voltage angles
    for bus_num = 1:n_buses
        col = col + 1;
        headers{col} = sprintf('vang_%d', bus_num);
    end
    % Bus LMP values
    for bus_num = 1:n_buses
        col = col + 1;
        headers{col} = sprintf('lmp_%d', bus_num);
    end
    % Objective function value
    col = col + 1;
    headers{col} = 'objective_val';
    % Time
    col = col + 1;
    headers{col} = 'time';
    % Success flag
    col = col + 1;
    headers{col} = 'success';
    clear col;

    for row = 1:35040
        %%%%%%%%%% ============================================= DISPATCH INPUTS ============================================= %%%%%%%%%%
        %%%%% =============== Change the load pd and qd values of the case file =============== %%%%%
        for col = 1:2*n_buses+1
            if col == 1
                pg_qg_v_lmp_obj_mg(row, 1) = pd_qd_pre(row, 1);
            else
                if col <= n_buses+1
                    mpc.bus(col - 1, PD) = pd_qd_pre(row, col);
                else
                    mpc.bus(col - n_buses - 1, QD) = pd_qd_pre(row, col);
                end
            end
        end

        %%%%% =============== Change the RE pwg and ppv values of the case file =============== %%%%%
        for gen_num = 1:n_gen-1 % exclude the dummy generator at the PCC
            if mpc.gen(gen_num, PMAX) == mpc.gen(gen_num, PMIN) % RE resources only
                col = col + 1;
                mpc.gen(gen_num, PMAX) = pd_qd_pre(row, col);
                mpc.gen(gen_num, PMIN) = pd_qd_pre(row, col);
            end
        end

        %%%%% =============== Change the voltage at the reference based on the DS dispatch instruction =============== %%%%%
        mpc.bus(n_buses, VMAX) = pg_qg_ppcc_qpcc_v_lmp_obj_ds(row, 1 + 20 + 7*2 + mg_ds_loc(mg_num, 2)); % 1 column for snapshot, 20 columns for DS-level diesel generators, 7*2 columns for PCC power exchange, number of columns to match the bus number of the DS with an MG
        mpc.bus(n_buses, VMIN) = pg_qg_ppcc_qpcc_v_lmp_obj_ds(row, 1 + 20 + 7*2 + mg_ds_loc(mg_num, 2));
        mpc.bus(n_buses, BUS_TYPE) = 3;

        %%%%% =============== Change the p and q values, and cost information at the PCC based on the DS dispatch instruction =============== %%%%%
        mpc.gen(n_gen, PMAX) = -pg_qg_ppcc_qpcc_v_lmp_obj_ds(row, 1 + 20 + mg_ds_loc(mg_num, 3)); % 1 column for snapshot, 20 columns for DS-level diesel generators, number of columns to match the location of the MG
        mpc.gen(n_gen, PMIN) = -pg_qg_ppcc_qpcc_v_lmp_obj_ds(row, 1 + 20 + mg_ds_loc(mg_num, 3));
        mpc.gen(n_gen, QMAX) = -pg_qg_ppcc_qpcc_v_lmp_obj_ds(row, 1 + 20 + 7 + mg_ds_loc(mg_num, 3)); % 1 column for snapshot, 20 columns for DS-level disesl generators, 7 columns for PCC real power exchange, number of columns to match the location of the MG
        mpc.gen(n_gen, QMIN) = -pg_qg_ppcc_qpcc_v_lmp_obj_ds(row, 1 + 20 + 7 + mg_ds_loc(mg_num, 3));
        mpc.gencost(n_gen, 6) = pg_qg_ppcc_qpcc_v_lmp_obj_ds(row, 1 + 20 + 7*2 + 69*2 + mg_ds_loc(mg_num, 2)); % 1 column for snapshot, 20 columns for DS-level diesel generators, 7*2 columns for PCC power exchange, 69*2 columns for voltage magnitude and angle, number of columns to match the bus number of the DS with an MG

        %%%%%%%%%% ============================================= DISPATCH AC OPF PROPER ============================================= %%%%%%%%%%
        start_time = tic;
        results = runopf(mpc);
        end_time = toc(start_time);

        %%%%%%%%%% ============================================= DISPATCH OUTPUTS ============================================= %%%%%%%%%%
        col = 1;
        %%%%% ===== Diesel pg ===== %%%%%
        for gen_num = 1:n_gen-1 % exclude the dummy generator at the PCC
            if mpc.gen(gen_num, PMAX) ~= mpc.gen(gen_num, PMIN) % diesel only, exclude RE resources
                col = col + 1;
                pg_qg_v_lmp_obj_mg(row, col) = results.gen(gen_num, PG);
            end
        end
        %%%%% ===== Diesel qg ===== %%%%%
        for gen_num = 1:n_gen-1 % exclude the dummy generator at the PCC
            if mpc.gen(gen_num, PMAX) ~= mpc.gen(gen_num, PMIN) % diesel only, exclude RE resources
                col = col + 1;
                pg_qg_v_lmp_obj_mg(row, col) = results.gen(gen_num, QG);
            end
        end
        %%%%% ===== Bus v ===== %%%%%
        for bus_num = 1:n_buses
            col = col + 1;
            pg_qg_v_lmp_obj_mg(row, col) = results.bus(bus_num, VM);
        end
        %%%%% ===== Bus vang ===== %%%%%
        for bus_num = 1:n_buses
            col = col + 1;
            pg_qg_v_lmp_obj_mg(row, col) = results.bus(bus_num, VA);
        end
        %%%%% ===== Bus lmp ===== %%%%%
        for bus_num = 1:n_buses
            col = col + 1;
            pg_qg_v_lmp_obj_mg(row, col) = results.bus(bus_num, LAM_P);
        end
        %%%%% ===== Objective function value ===== %%%%%
        col = col + 1;
        pg_qg_v_lmp_obj_mg(row, col) = results.f;
        %%%%% ===== Time ===== %%%%%
        col = col + 1;
        pg_qg_v_lmp_obj_mg(row, col) = end_time;
        %%%%% ===== Success flag ===== %%%%%
        col = col + 1;
        pg_qg_v_lmp_obj_mg(row, col) = results.success;
    end

    %%%%% =============== Combine the headers and the numerical dataset =============== %%%%%
    pg_qg_v_lmp_obj_mg = [headers; num2cell(pg_qg_v_lmp_obj_mg)];

    %%%%% =============== Write the outputs =============== %%%%%
    pg_qg_v_lmp_obj_mg_file = sprintf('pg_qg_v_lmp_obj_trainvaltest_mg%d.csv', mg_num);
    pg_qg_v_lmp_obj_mg_file_path = fullfile('..\data\pg_qg_v_lmp_obj_trainvaltest_mg\', pg_qg_v_lmp_obj_mg_file);
    writecell(pg_qg_v_lmp_obj_mg, pg_qg_v_lmp_obj_mg_file_path);
end