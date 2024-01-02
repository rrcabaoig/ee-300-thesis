% Power Exchange Determination Stage (PEDS)
clear;
define_constants;

%%%%% =============== Headers =============== %%%%%
headers{1} = 'snapshot';
headers{2} = 'ppcc_min';
headers{3} = 'qpcc_min';
headers{4} = 'qpcc_max';
headers{5} = 'offer_price_per_mwh_ppcc_min_export';
headers{6} = 'offer_price_per_mwh_ppcc_min_half_export';
headers{7} = 'with_markup_per_mwh_min_export';
headers{8} = 'with_markup_per_mwh_min_half_export';
headers{9} = 'with_markup_min_export';
headers{10} = 'with_markup_min_half_export';
headers{11} = 'success_ppcc_min';
headers{12} = 'success_qpcc_min';
headers{13} = 'success_qpcc_max';
headers{14} = 'success_offer_price_ppcc';
headers{15} = 'success_offer_price_half_ppcc';

for mg_num = 1:7
    clear ppcc_qpcc_offer;
    clear orig_gencost;

    %%%%% =============== Read the load pd and qd values, and RE pwg and ppv values =============== %%%%%
    pd_qd_pre_file = sprintf('pd_qd_pre_trainvaltest_mg%d.csv', mg_num);
    pd_qd_pre_file_path = fullfile('..\data\pd_qd_pre_trainvaltest\', pd_qd_pre_file);
    pd_qd_pre = readmatrix(pd_qd_pre_file_path);
    
    %%%%% =============== Load the MATPOWER case file =============== %%%%%
    casemg_file = sprintf('casemg%d', mg_num);
    casemg_file_path = fullfile('.\cases\', casemg_file);
    mpc = loadcase(casemg_file_path);

    n_buses = size(mpc.bus, 1); % number of buses
    n_gen = size(mpc.gen, 1); % number of generators including the dummy generator
    orig_gencost = mpc.gencost(:, 5:7); % original generator costs

    for row = 1:35040
        %%%%%%%%%% ============================================= PEDS INPUTS ============================================= %%%%%%%%%%
        %%%%% =============== Change the load pd and qd values of the case file =============== %%%%%
        for col = 1:2*n_buses+1
            if col == 1
                ppcc_qpcc_offer(row, 1) = pd_qd_pre(row, 1);
            else
                if col <= n_buses+1
                    mpc.bus(col - 1, PD) = pd_qd_pre(row, col);
                else
                    mpc.bus(col - n_buses - 1, QD) = pd_qd_pre(row, col);
                end
            end
        end

        %%%%% =============== Change the RE pwg and ppv values of the case file =============== %%%%%
        switch mg_num
            % case 1 % 0 wind, 0 solar
            case 2 % 0 wind, 1 solar
                mpc.gen(3, PMAX) = pd_qd_pre(row, 2*n_buses + 2);
                mpc.gen(3, PMIN) = pd_qd_pre(row, 2*n_buses + 2);
            case 3 % 1 wind, 1 solar
                mpc.gen(2, PMAX) = pd_qd_pre(row, 2*n_buses + 2);
                mpc.gen(2, PMIN) = pd_qd_pre(row, 2*n_buses + 2);
                mpc.gen(5, PMAX) = pd_qd_pre(row, 2*n_buses + 3);
                mpc.gen(5, PMIN) = pd_qd_pre(row, 2*n_buses + 3);
            case 4 % 2 wind, 0 solar
                mpc.gen(1, PMAX) = pd_qd_pre(row, 2*n_buses + 2);
                mpc.gen(1, PMIN) = pd_qd_pre(row, 2*n_buses + 2);
                mpc.gen(4, PMAX) = pd_qd_pre(row, 2*n_buses + 3);
                mpc.gen(4, PMIN) = pd_qd_pre(row, 2*n_buses + 3);
            case 5 % 1 wind, 1 solar
                mpc.gen(2, PMAX) = pd_qd_pre(row, 2*n_buses + 2);
                mpc.gen(2, PMIN) = pd_qd_pre(row, 2*n_buses + 2);
                mpc.gen(5, PMAX) = pd_qd_pre(row, 2*n_buses + 3);
                mpc.gen(5, PMIN) = pd_qd_pre(row, 2*n_buses + 3);
            case 6 % 2 wind, 2 solar
                mpc.gen(2, PMAX) = pd_qd_pre(row, 2*n_buses + 2);
                mpc.gen(2, PMIN) = pd_qd_pre(row, 2*n_buses + 2);
                mpc.gen(4, PMAX) = pd_qd_pre(row, 2*n_buses + 3);
                mpc.gen(4, PMIN) = pd_qd_pre(row, 2*n_buses + 3);
                mpc.gen(5, PMAX) = pd_qd_pre(row, 2*n_buses + 4);
                mpc.gen(5, PMIN) = pd_qd_pre(row, 2*n_buses + 4);
                mpc.gen(6, PMAX) = pd_qd_pre(row, 2*n_buses + 5);
                mpc.gen(6, PMIN) = pd_qd_pre(row, 2*n_buses + 5);
            case 7 % 1 wind, 1 solar
                mpc.gen(1, PMAX) = pd_qd_pre(row, 2*n_buses + 2);
                mpc.gen(1, PMIN) = pd_qd_pre(row, 2*n_buses + 2);
                mpc.gen(5, PMAX) = pd_qd_pre(row, 2*n_buses + 3);
                mpc.gen(5, PMIN) = pd_qd_pre(row, 2*n_buses + 3);
        end

        %%%%%%%%%% ============================================= PEDS OUTPUTS ============================================= %%%%%%%%%%
        %%%%% =============== Minimize p at the PCC =============== %%%%%
        % Set a wide range of PMAX and PMIN for the dummy generator at the PCC
        mpc.gen(n_gen, PMAX) = 9;
        mpc.gen(n_gen, PMIN) = -9;
    
        % Set QMAX and QMIN to zero for the dummy generator at the PCC
        mpc.gen(n_gen, QMAX) = 0;
        mpc.gen(n_gen, QMIN) = 0;
    
        % Clear all generator costs
        mpc.gencost(:, 5) = 0;
        mpc.gencost(:, 6) = 0;
        mpc.gencost(:, 7) = 0;
    
        % Set the generator real power cost of the dummy generator to a very large positive value
        mpc.gencost(n_gen, 5) = 9;
        mpc.gencost(n_gen, 6) = 9;
        mpc.gencost(n_gen, 7) = 9;

        % Run an AC OPF to get the minimum p at the PCC
        results_ppcc_min = runopf(mpc);
        ppcc_qpcc_offer(row, 2) = ceil(results_ppcc_min.gen(n_gen, PG)*1000)/1000;

        %%%%% =============== Minimize q at the PCC, while holding the minimum p value =============== %%%%%
        % Set PMAX and PMIN to the minimum p value solved earlier
        mpc.gen(n_gen, PMAX) = ppcc_qpcc_offer(row, 2);
        mpc.gen(n_gen, PMIN) = ppcc_qpcc_offer(row, 2);

        % Set a wide range of QMAX and QMIN for the dummy generator at the PCC
        mpc.gen(n_gen, QMAX) = 9;
        mpc.gen(n_gen, QMIN) = -9;

        % Clear all generator costs
        mpc.gencost(:, 5) = 0;
        mpc.gencost(:, 6) = 0;
        mpc.gencost(:, 7) = 0;

        % Set the generator reactive power cost of the dummy generator to a very large positive value
        mpc.gencost(2*n_gen, 5) = 9;
        mpc.gencost(2*n_gen, 6) = 9;
        mpc.gencost(2*n_gen, 7) = 9;

        % Run an AC OPF to get the minimum q at the PCC, while holding the minimum p value
        results_qpcc_min = runopf(mpc);
        ppcc_qpcc_offer(row, 3) = ceil(results_qpcc_min.gen(n_gen, QG)*1000)/1000;

        %%%%% =============== Maximize q at the PCC, while holding the minimum p value =============== %%%%%
        % Set PMAX and PMIN to the minimum p value solved earlier
        mpc.gen(n_gen, PMAX) = ppcc_qpcc_offer(row, 2);
        mpc.gen(n_gen, PMIN) = ppcc_qpcc_offer(row, 2);

        % Set a wide range of QMAX and QMIN for the dummy generator at the PCC
        mpc.gen(n_gen, QMAX) = 9;
        mpc.gen(n_gen, QMIN) = -9;

        % Clear all generator costs
        mpc.gencost(:, 5) = 0;
        mpc.gencost(:, 6) = 0;
        mpc.gencost(:, 7) = 0;

        % Set the generator reactive power cost of the dummy generator to a very large negative value
        mpc.gencost(2*n_gen, 5) = -9;
        mpc.gencost(2*n_gen, 6) = -9;
        mpc.gencost(2*n_gen, 7) = -9;

        % Run an AC OPF to get the maximum q at the PCC, while holding the minimum p value
        results_qpcc_max = runopf(mpc);
        ppcc_qpcc_offer(row, 4) = floor(results_qpcc_max.gen(n_gen, QG)*1000)/1000;

        %%%%% =============== Find the offer price (2 blocks of offers) =============== %%%%%
        if ppcc_qpcc_offer(row, 2) < 0 % for exporters only
            %%%%% =============== Solve the offer price for the block at the minimum p value =============== %%%%%
            % Restore the original generator costs
            mpc.gencost(:, 5:7) = orig_gencost;
    
            % Set PMAX and PMIN to the minimum p value solved earlier
            mpc.gen(n_gen, PMAX) = ppcc_qpcc_offer(row, 2);
            mpc.gen(n_gen, PMIN) = ppcc_qpcc_offer(row, 2);
    
            % Set QMAX and QMIN to zero for the dummy generator at the PCC
            mpc.gen(n_gen, QMAX) = 0;
            mpc.gen(n_gen, QMIN) = 0;
    
            % Run an AC OPF to get the LMP at the PCC
            results_offer_price_ppcc = runopf(mpc);
            ppcc_qpcc_offer(row, 5) = results_offer_price_ppcc.bus(n_buses, LAM_P);
    
            %%%%% =============== Solve the offer price for the block at half of the minimum p value =============== %%%%%
            % Restore the original generator costs
            mpc.gencost(:, 5:7) = orig_gencost;
    
            % Set PMAX and PMIN to half of the minimum p value solved earlier
            mpc.gen(n_gen, PMAX) = ceil(ppcc_qpcc_offer(row, 2)/2*1000)/1000;
            mpc.gen(n_gen, PMIN) = ceil(ppcc_qpcc_offer(row, 2)/2*1000)/1000;
    
            % Set QMAX and QMIN to zero for the dummy generator at the PCC
            mpc.gen(n_gen, QMAX) = 0;
            mpc.gen(n_gen, QMIN) = 0;
    
            % Run an AC OPF to get the LMP at the PCC
            results_offer_price_half_ppcc = runopf(mpc);
            ppcc_qpcc_offer(row, 6) = results_offer_price_half_ppcc.bus(n_buses, LAM_P);

            %%%%% =============== Impose markups =============== %%%%%
            ppcc_qpcc_offer(row, 7) = ppcc_qpcc_offer(row, 5)*1.052;
            ppcc_qpcc_offer(row, 8) = ppcc_qpcc_offer(row, 6)*1.052;

            %%%%% =============== Multiply the marked up offer price with its corresponding p value (minimum p value) =============== %%%%%
            ppcc_qpcc_offer(row, 9) = -ppcc_qpcc_offer(row, 2)*ppcc_qpcc_offer(row, 7);

            %%%%% =============== Multiply the marked up offer price with its corresponding p value (half of the minimum p value) =============== %%%%%
            ppcc_qpcc_offer(row, 10) = -ceil(ppcc_qpcc_offer(row, 2)/2*1000)/1000*ppcc_qpcc_offer(row, 8);

            %%%%% =============== Flag 1 if the AC OPF is successful =============== %%%%%
            ppcc_qpcc_offer(row, 11) = results_ppcc_min.success;
            ppcc_qpcc_offer(row, 12) = results_qpcc_min.success;
            ppcc_qpcc_offer(row, 13) = results_qpcc_max.success;
            ppcc_qpcc_offer(row, 14) = results_offer_price_ppcc.success;
            ppcc_qpcc_offer(row, 15) = results_offer_price_half_ppcc.success;
        else % for importers only, and if the minimum p is zero
            ppcc_qpcc_offer(row, 5) = -1;
            ppcc_qpcc_offer(row, 6) = -1;
            ppcc_qpcc_offer(row, 7) = -1;
            ppcc_qpcc_offer(row, 8) = -1;
            ppcc_qpcc_offer(row, 9) = -1;
            ppcc_qpcc_offer(row, 10) = -1;

            %%%%% =============== Flag 1 if the AC OPF is successful =============== %%%%%
            ppcc_qpcc_offer(row, 11) = results_ppcc_min.success;
            ppcc_qpcc_offer(row, 12) = results_qpcc_min.success;
            ppcc_qpcc_offer(row, 13) = results_qpcc_max.success;

            %%%%% =============== Flag 2 for importers, indicating no offer price =============== %%%%%
            ppcc_qpcc_offer(row, 14) = 2;
            ppcc_qpcc_offer(row, 15) = 2;
        end
        
    end

    %%%%% =============== Combine the headers and the numerical dataset =============== %%%%%
    ppcc_qpcc_offer = [headers; num2cell(ppcc_qpcc_offer)];

    %%%%% =============== Write the outputs =============== %%%%%
    ppcc_qpcc_offer_file = sprintf('ppcc_qpcc_offer_trainvaltest_mg%d.csv', mg_num);
    ppcc_qpcc_offer_file_path = fullfile('..\data\ppcc_qpcc_offer_trainvaltest_mg\', ppcc_qpcc_offer_file);
    writecell(ppcc_qpcc_offer, ppcc_qpcc_offer_file_path);
end