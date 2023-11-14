function mpc = casemg6_peds																						
%   casemg6  Power flow data for microgrid 6																						
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
	1	2	44	33	0	0	1	1	0	12.66	1	1.05	0.95;	% if there are changes in Pd, also change the values in load_profiles_pd_qd_mgN.xlsx								
	2	1	54	40.5	0	0	1	1	0	12.66	1	1.05	0.95;									
	3	1	45	33.75	0	0	1	1	0	12.66	1	1.05	0.95;	% 38 kW to 45 kW (force a supply deficiency to trigger importation)								
	4	1	94	70.5	0	0	1	1	0	12.66	1	1.05	0.95;									
	5	1	45	33.75	0	0	1	1	0	12.66	1	1.05	0.95;	% 40 kW to 45 kW (force a supply deficiency to trigger importation)								
	6	1	110	82.5	0	0	1	1	0	12.66	1	1.05	0.95;									
	7	2	8	6	0	0	1	1	0	12.66	1	1.05	0.95;									
	8	1	76	57	0	0	1	1	0	12.66	1	1.05	0.95;									
	9	1	80	60	0	0	1	1	0	12.66	1	1.05	0.95;									
	10	1	70	52.5	0	0	1	1	0	12.66	1	1.05	0.95;	% 60 kW to 70 kW (force a supply deficiency to trigger importation)								
	11	2	75	56.25	0	0	1	1	0	12.66	1	1.05	0.95;									
	12	3	0	0	0	0	1	1	0	12.66	1	1.05	0.95;									
];																						
																						
%% generator data																						
%	bus	Pg	Qg	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1	Pc2	Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf	
mpc.gen = [																						
	1	0	0	0.25	-0.19	1	100	1	0.2	0	0	0	0	0	0	0	0	0	0	0	0;	% diesel: 200 kW
	3	0	0	0	0	1	100	1	0.075	0.075	0	0	0	0	0	0	0	0	0	0	0;	% solar: 75 kW
	7	0	0	0.18	-0.16	1	100	1	0.125	0	0	0	0	0	0	0	0	0	0	0	0;	% diesel: 125 kW
	8	0	0	0	0	1	100	1	0.075	0.075	0	0	0	0	0	0	0	0	0	0	0;	% solar: 75 kW
	9	0	0	0	0	1	100	1	0.05	0.05	0	0	0	0	0	0	0	0	0	0	0;	% wind: 50 kW
	10	0	0	0	0	1	100	1	0.05	0.05	0	0	0	0	0	0	0	0	0	0	0;	% wind: 50 kW
	11	0	0	0.18	-0.16	1	100	1	0.125	0	0	0	0	0	0	0	0	0	0	0	0;	% diesel: 125 kW
	12	0	0	0	0	1	100	1	0	0	0	0	0	0	0	0	0	0	0	0	0;	% dummy
];																						
																						
%% branch data																						
%	fbus	tbus	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax									
mpc.branch = [  %% (r and x specified in ohms here, converted to p.u. below)																						
	1	2	0.0005	0.0012	0	0.94	0	0	0	0	1	-360	360;									
	2	3	0.0009	0.0012	0	0.94	0	0	0	0	1	-360	360;									
	2	6	0.0034	0.0084	0	0.94	0	0	0	0	1	-360	360;									
	3	4	0.0851	0.2083	0	0.94	0	0	0	0	1	-360	360;									
	4	5	0.2898	0.7091	0	0.94	0	0	0	0	1	-360	360;									
	5	8	0.014	0.0046	0	0.94	0	0	0	0	1	-360	360;									
	5	11	0.1591	0.0526	0	0.94	0	0	0	0	1	-360	360;									
	5	12	0.0005	0.0012	0	0.94	0	0	0	0	1	-360	360;									
	6	7	0.1053	0.123	0	0.94	0	0	0	0	1	-360	360;									
	7	8	0.0005	0.0012	0	0.94	0	0	0	0	1	-360	360;									
	7	9	0.0005	0.0012	0	0.94	0	0	0	0	1	-360	360;									
	9	10	0.1089	0.1373	0	0.94	0	0	0	0	1	-360	360;									
	10	11	0.0009	0.0012	0	0.94	0	0	0	0	1	-360	360;									
];																						
																						
%%-----  OPF Data  -----%%																						
%% generator cost data																						
%	1	startup	shutdown	n	x1	y1	...	xn	yn													
%	2	startup	shutdown	n	c(n-1)	...	c0															
mpc.gencost = [																						
	2	0	0	3	0.010561*10^6	14.468932*10^3	488.465727;	% diesel: 200 kW														
	2	0	0	3	0	0	0;	% solar: 75 kW														
	2	0	0	3	0.006761*10^6	15.926193*10^3	310.245485;	% diesel: 125 kW														
	2	0	0	3	0	0	0;	% solar: 75 kW														
	2	0	0	3	0	0	0;	% wind: 50 kW														
	2	0	0	3	0	0	0;	% wind: 50 kW														
	2	0	0	3	0.006761*10^6	15.926193*10^3	310.245485;	% diesel: 125 kW														
	2	0	0	3	0	0	0;	% dummy														
	2	0	0	3	0	0	0;	% start of reactive power cost														
	2	0	0	3	0	0	0;															
	2	0	0	3	0	0	0;															
	2	0	0	3	0	0	0;															
	2	0	0	3	0	0	0;															
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
