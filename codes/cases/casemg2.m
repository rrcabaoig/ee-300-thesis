function mpc = casemg2																						
%   casemg2  Power flow data for microgrid 2																						
%   Please see CASEFORMAT for details on the case file format.																						
%																						
																						
%% MATPOWER Case Format : Version 2																						
mpc.version = '2';																						
																						
%%-----  Power Flow Data  -----%%																						
%% system MVA base																						
mpc.baseMVA = 10;																						
																						
%% bus data																						
%	bus_i	type	Pd	Qd	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin									
mpc.bus = [ %% (Pd and Qd are specified in kW & kVAr here, converted to MW & MVAr below)																						
	1	2	35	16.95	0	0	1	1	0	12.66	1	1.05	0.95;	% if there are changes in Pd, also change the values in load_profiles_pd_qd_mgN.xlsx								
	2	1	45	21.79	0	0	1	1	0	12.66	1	1.05	0.95;									
	3	2	25	12.11	0	0	1	1	0	12.66	1	1.05	0.95;									
	4	1	56	27.12	0	0	1	1	0	12.66	1	1.05	0.95;									
	5	1	26	12.59	0	0	1	1	0	12.66	1	1.05	0.95;									
	6	1	56	27.12	0	0	1	1	0	12.66	1	1.05	0.95;									
	7	3	0	0	0	0	1	1	0	12.66	1	1	1;									
];																						
																						
%% generator data																						
%	bus	Pg	Qg	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1	Pc2	Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf	
mpc.gen = [																						
	1	0	0	0.085	-0.055	1	100	1	0.1	0	0	0.12	-0.06	0.09	-0.03	0.06	0	0	0	0	0;	% diesel: 100 kW
	3	0	0	0.10625	-0.06875	1	100	1	0.125	0	0	0.15	-0.075	0.1125	-0.0375	0.075	0	0	0	0	0;	% diesel: 125 kW
	5	0	0	0	0	1	100	1	0.05	0.05	0	0	0	0	0	0	0	0	0	0	0;	% solar: 50 kW
	7	0	0	0	0	1	100	1	0	0	0	0	0	0	0	0	0	0	0	0	0;	% dummy
];																						
																						
%% branch data																						
%	fbus	tbus	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax									
mpc.branch = [  %% (r and x specified in ohms here, converted to p.u. below)																						
	1	2	0.0044	0.0108	0	0.22	0	0	0	0	1	-5	5;									
	2	3	0.0034	0.0084	0	0.22	0	0	0	0	1	-5	5;									
	2	6	0.014	0.0046	0	0.22	0	0	0	0	1	-5	5;									
	3	4	0.0044	0.0108	0	0.22	0	0	0	0	1	-5	5;									
	4	6	0.0034	0.0084	0	0.22	0	0	0	0	1	-5	5;									
	4	7	0.0034	0.0084	0	0.24	0	0	0	0	1	-5	5;									
	5	6	0.0044	0.0108	0	0.22	0	0	0	0	1	-5	5;									
];																						
																						
%%-----  OPF Data  -----%%																						
%% generator cost data																						
%	1	startup	shutdown	n	x1	y1	...	xn	yn													
%	2	startup	shutdown	n	c(n-1)	...	c0															
mpc.gencost = [																						
	2	0	0	3	0.002055*10^6	17.713*10^3	264.096982;	% diesel: 100 kW														
	2	0	0	3	0.001398*10^6	17.718885*10^3	291.745069;	% diesel: 125 kW														
	2	0	0	3	0	0	0;	% solar: 50 kW														
	2	0	0	3	0	0	0;	% dummy														
	2	0	0	3	0	0	0;	% start of reactive power cost														
	2	0	0	3	0	0	0;															
	2	0	0	3	0	0	0;															
	2	0	0	3	0	0	0;	% dummy														
];																						
																						
																						
%% convert branch impedances from Ohms to p.u.																						
[PQ, PV, REF, NONE, BUS_I, BUS_TYPE, PD, QD, GS, BS, BUS_AREA, VM, ...																						
    VA, BASE_KV, ZONE, VMAX, VMIN, LAM_P, LAM_Q, MU_VMAX, MU_VMIN] = idx_bus;																						
[F_BUS, T_BUS, BR_R, BR_X, BR_B, RATE_A, RATE_B, RATE_C, ...																						
    TAP, SHIFT, BR_STATUS, PF, QF, PT, QT, MU_SF, MU_ST, ...																						
    ANGMIN, ANGMAX, MU_ANGMIN, MU_ANGMAX] = idx_brch;																						
Vbase = mpc.bus(1, BASE_KV) * 1e3;      %% in Volts																						
Sbase = mpc.baseMVA * 1e6;              %% in VA																						
mpc.branch(:, [BR_R BR_X]) = mpc.branch(:, [BR_R BR_X]) / (Vbase^2 / Sbase);																						
																						
%% convert loads from kW to MW																						
mpc.bus(:, [PD, QD]) = mpc.bus(:, [PD, QD]) / 1e3;																						
