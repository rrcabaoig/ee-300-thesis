function mpc = casemg7																						
%   casemg7  Power flow data for microgrid 7																						
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
	1	1	50	24.22	0	0	1	1	0	12.66	1	1.05	0.95;	% if there are changes in Pd, also change the values in load_profiles_pd_qd_mgN.xlsx								
	2	1	69	33.42	0	0	1	1	0	12.66	1	1.05	0.95;									
	3	2	40	19.37	0	0	1	1	0	12.66	1	1.05	0.95;									
	4	1	25	12.11	0	0	1	1	0	12.66	1	1.05	0.95;									
	5	2	23	11.14	0	0	1	1	0	12.66	1	1.05	0.95;									
	6	1	82	39.71	0	0	1	1	0	12.66	1	1.05	0.95;									
	7	1	36	17.44	0	0	1	1	0	12.66	1	1.05	0.95;									
	8	2	67	32.45	0	0	1	1	0	12.66	1	1.05	0.95;									
	9	1	86	41.65	0	0	1	1	0	12.66	1	1.05	0.95;									
	10	1	69	33.42	0	0	1	1	0	12.66	1	1.05	0.95;									
	11	1	36	17.44	0	0	1	1	0	12.66	1	1.05	0.95;									
	12	2	35	16.95	0	0	1	1	0	12.66	1	1.05	0.95;									
	13	1	22	10.66	0	0	1	1	0	12.66	1	1.05	0.95;									
	14	3	0	0	0	0	1	1	0	12.66	1	1	1;									
];																						
																						
%% generator data																						
%	bus	Pg	Qg	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1	Pc2	Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf	
mpc.gen = [																						
	1	0	0	0	0	1	100	1	0.1	0.1	0	0	0	0	0	0	0	0	0	0	0;	% wind: 100 kW
	3	0	0	0.1275	-0.0825	1	100	1	0.15	0	0	0.18	-0.09	0.135	-0.045	0.09	0	0	0	0	0;	% diesel: 150 kW
	5	0	0	0.1275	-0.0825	1	100	1	0.15	0	0	0.18	-0.09	0.135	-0.045	0.09	0	0	0	0	0;	% diesel: 150 kW
	8	0	0	0.14875	-0.09625	1	100	1	0.175	0	0	0.21	-0.105	0.1575	-0.0525	0.105	0	0	0	0	0;	% diesel: 175 kW
	11	0	0	0	0	1	100	1	0.1	0.1	0	0	0	0	0	0	0	0	0	0	0;	% solar: 100 kW
	12	0	0	0.085	-0.055	1	100	1	0.1	0	0	0.12	-0.06	0.09	-0.03	0.06	0	0	0	0	0;	% diesel: 100 kW
	14	0	0	0	0	1	100	1	0	0	0	0	0	0	0	0	0	0	0	0	0;	% dummy
];																						
																						
%% branch data																						
%	fbus	tbus	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax									
mpc.branch = [  %% (r and x specified in ohms here, converted to p.u. below)																						
	1	2	0.0044	0.0108	0	0.35	0	0	0	0	1	-5	5;									
	2	3	0.0034	0.0084	0	0.35	0	0	0	0	1	-5	5;									
	2	5	0.0044	0.0108	0	0.2	0	0	0	0	1	-5	5;									
	3	4	0.014	0.0046	0	0.35	0	0	0	0	1	-5	5;									
	4	7	0.0047	0.0014	0	0.35	0	0	0	0	1	-5	5;									
	4	10	0.0034	0.0084	0	0.35	0	0	0	0	1	-5	5;									
	4	13	0.0092	0.0116	0	0.35	0	0	0	0	1	-5	5;									
	4	14	0.0034	0.0084	0	0.64	0	0	0	0	1	-5	5;									
	5	6	0.0034	0.0084	0	0.35	0	0	0	0	1	-5	5;									
	5	8	0.0034	0.0084	0	0.2	0	0	0	0	1	-5	5;									
	6	7	0.0044	0.0108	0	0.35	0	0	0	0	1	-5	5;									
	8	9	0.0034	0.0084	0	0.35	0	0	0	0	1	-5	5;									
	9	10	0.0047	0.0014	0	0.35	0	0	0	0	1	-5	5;									
	9	13	0.0044	0.0108	0	0.2	0	0	0	0	1	-5	5;									
	11	12	0.0092	0.0116	0	0.35	0	0	0	0	1	-5	5;									
	12	13	0.0044	0.0108	0	0.35	0	0	0	0	1	-5	5;									
];																						
																						
%%-----  OPF Data  -----%%																						
%% generator cost data																						
%	1	startup	shutdown	n	x1	y1	...	xn	yn													
%	2	startup	shutdown	n	c(n-1)	...	c0															
mpc.gencost = [																						
	2	0	0	3	0	0	0;	% wind: 100 kW														
	2	0	0	3	0.001933*10^6	17.830171*10^3	305.66648;	% diesel: 150 kW														
	2	0	0	3	0.001933*10^6	17.830171*10^3	305.66648;	% diesel: 150 kW														
	2	0	0	3	0.00018*10^6	19.681215*10^3	105.934988;	% diesel: 175 kW														
	2	0	0	3	0	0	0;	% solar: 100 kW														
	2	0	0	3	0.002055*10^6	17.713*10^3	264.096982;	% diesel: 100 kW														
	2	0	0	3	0	0	0;	% dummy														
	2	0	0	3	0	0	0;	% start of reactive power cost														
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
