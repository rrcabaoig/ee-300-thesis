function mpc = casemg1_peds																						
%   casemg1  Power flow data for microgrid 1																						
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
	1	2	60	45	0	0	1	1	0	12.66	1	1.05	0.95;	% if there are changes in Pd, also change the values in load_profiles_pd_qd_mgN.xlsx								
	2	1	20	15	0	0	1	1	0	12.66	1	1.05	0.95;									
	3	1	25	18.75	0	0	1	1	0	12.66	1	1.05	0.95;									
	4	2	30	22.5	0	0	1	1	0	12.66	1	1.05	0.95;									
	5	1	50	37.5	0	0	1	1	0	12.66	1	1.05	0.95;									
	6	3	0	0	0	0	1	1	0	12.66	1	1.05	0.95;									
];																						
																						
%% generator data																						
%	bus	Pg	Qg	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1	Pc2	Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf	
mpc.gen = [																						
	1	0	0	0.09	-0.09	1	100	1	0.1	0	0	0	0	0	0	0	0	0	0	0	0;	% diesel: 100 kW
	4	0	0	0.18	-0.16	1	100	1	0.125	0	0	0	0	0	0	0	0	0	0	0	0;	% diesel: 125 kW
	6	0	0	0	0	1	100	1	0	0	0	0	0	0	0	0	0	0	0	0	0;	% dummy
];																						
																						
%% branch data																						
%	fbus	tbus	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax									
mpc.branch = [  %% (r and x specified in ohms here, converted to p.u. below)																						
	1	2	0.0702	0.0232	0	0.18	0	0	0	0	1	-360	360;									
	1	4	0.0005	0.0012	0	0.15	0	0	0	0	1	-360	360;									
	2	3	0.0092	0.0116	0	0.18	0	0	0	0	1	-360	360;									
	3	5	0.1089	0.1373	0	0.21	0	0	0	0	1	-360	360;									
	3	6	0.0009	0.0012	0	0.18	0	0	0	0	1	-360	360;									
	4	5	0.0034	0.0084	0	0.21	0	0	0	0	1	-360	360;									
];																						
																						
%%-----  OPF Data  -----%%																						
%% generator cost data																						
%	1	startup	shutdown	n	x1	y1	...	xn	yn													
%	2	startup	shutdown	n	c(n-1)	...	c0															
mpc.gencost = [																						
	2	0	0	3	0.010567*10^6	15.682769*10^3	283.853589;	% diesel: 100 kW														
	2	0	0	3	0.006761*10^6	15.926193*10^3	310.245485;	% diesel: 125 kW														
	2	0	0	3	0	0	0;	% dummy														
	2	0	0	3	0	0	0;	% start of reactive power cost														
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
