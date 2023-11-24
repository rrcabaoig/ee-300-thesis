function mpc = casemg3																						
%   casemg3  Power flow data for microgrid 3																						
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
	1	2	37	17.92	0	0	1	1	0	12.66	1	1.05	0.95;	% if there are changes in Pd, also change the values in load_profiles_pd_qd_mgN.xlsx								
	2	1	27	13.08	0	0	1	1	0	12.66	1	1.05	0.95;									
	3	1	23	11.14	0	0	1	1	0	12.66	1	1.05	0.95;	% 12 kW to 17 kW (force a supply deficiency to trigger importation)								
	4	2	27	13.08	0	0	1	1	0	12.66	1	1.05	0.95;	% 34 kW to 40 kW (force a supply deficiency to trigger importation)								
	5	1	69	33.42	0	0	1	1	0	12.66	1	1.05	0.95;									
	6	1	92	44.56	0	0	1	1	0	12.66	1	1.05	0.95;									
	7	2	22	10.66	0	0	1	1	0	12.66	1	1.05	0.95;									
	8	1	42	20.34	0	0	1	1	0	12.66	1	1.05	0.95;	% 64 kW to 70 kW (force a supply deficiency to trigger importation)								
	9	3	0	0	0	0	1	1	0	12.66	1	1	1;									
];																						
																						
%% generator data																						
%	bus	Pg	Qg	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1	Pc2	Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf	
mpc.gen = [																						
	1	0	0	0.06375	-0.04125	1	100	1	0.075	0	0	0.09	-0.045	0.0675	-0.0225	0.045	0	0	0	0	0;	% diesel: 75 kW
	2	0	0	0	0	1	100	1	0.05	0.05	0	0	0	0	0	0	0	0	0	0	0;	% solar: 50 kW
	4	0	0	0.06375	-0.04125	1	100	1	0.075	0	0	0.09	-0.045	0.0675	-0.0225	0.045	0	0	0	0	0;	% diesel: 75 kW
	7	0	0	0.1275	-0.0825	1	100	1	0.15	0	0	0.18	-0.09	0.135	-0.045	0.09	0	0	0	0	0;	% diesel: 150 kW
	8	0	0	0	0	1	100	1	0.05	0.05	0	0	0	0	0	0	0	0	0	0	0;	% wind: 50 kW
	9	0	0	0	0	1	100	1	0	0	0	0	0	0	0	0	0	0	0	0	0;	% dummy
];																						
																						
%% branch data																						
%	fbus	tbus	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax									
mpc.branch = [  %% (r and x specified in ohms here, converted to p.u. below)																						
	1	2	0.0044	0.0108	0	0.22	0	0	0	0	1	-5	5;									
	1	5	0.0034	0.0084	0	0.18	0	0	0	0	1	-5	5;									
	2	3	0.0034	0.0084	0	0.22	0	0	0	0	1	-5	5;									
	3	6	0.0044	0.0108	0	0.22	0	0	0	0	1	-5	5;									
	3	8	0.0092	0.0116	0	0.22	0	0	0	0	1	-5	5;									
	3	9	0.0044	0.0108	0	0.36	0	0	0	0	1	-5	5;									
	4	5	0.0044	0.0108	0	0.22	0	0	0	0	1	-5	5;									
	5	6	0.0044	0.0108	0	0.22	0	0	0	0	1	-5	5;									
	5	7	0.0034	0.0084	0	0.16	0	0	0	0	1	-5	5;									
	7	8	0.0034	0.0084	0	0.22	0	0	0	0	1	-5	5;									
];																						
																						
%%-----  OPF Data  -----%%																						
%% generator cost data																						
%	1	startup	shutdown	n	x1	y1	...	xn	yn													
%	2	startup	shutdown	n	c(n-1)	...	c0															
mpc.gencost = [																						
	2	0	0	3	0.098724*10^6	8.965789*10^3	465.1877;	% diesel: 75 kW														
	2	0	0	3	0	0	0;	% solar: 50 kW														
	2	0	0	3	0.098724*10^6	8.965789*10^3	465.1877;	% diesel: 75 kW														
	2	0	0	3	0.001933*10^6	17.830171*10^3	305.66648;	% diesel: 150 kW														
	2	0	0	3	0	0	0;	% wind: 50 kW														
	2	0	0	3	0	0	0;	% dummy														
	2	0	0	3	0	0	0;	% start of reactive power cost														
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
