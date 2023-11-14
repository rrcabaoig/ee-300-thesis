function mpc = case69rrc																						
%CASE69RRC  Power flow data for 69 bus distribution system																						
%   Please see CASEFORMAT for details on the case file format.																						
%																						
%   Data from ...																						
%       M. E. Baran and F. F. Wu, "Optimal capacitor placement on radial																						
%       distribution systems," in IEEE Transactions on Power Delivery,																						
%       vol. 4, no. 1, pp. 725-734, Jan. 1989, doi: 10.1109/61.19265.																						
%       https://doi.org/10.1109/61.19265																						
%																						
%   Derived "from a portion of the PG&E distribution system".																						
%																						
%   Also in ...																						
%       D. Das, Optimal placement of capacitors in radial distribution																						
%       system using a Fuzzy-GA method, International Journal of Electrical																						
%       Power & Energy Systems, Volume 30, Issues 6â€“7, Julyâ€“September 2008,																						
%       Pages 361-367																						
%       https://doi.org/10.1016/j.ijepes.2007.08.004																						
%																						
%   Modifications:																						
%     v2 - 2020-09-30 (RDZ)																						
%         - Cite original source (Baran & Wu)																						
%         - Specify branch parameters in Ohms, loads in kW.																						
%         - Added code for explicit conversion of loads from kW to MW and																						
%           branch parameters from Ohms to p.u.																						
%         - Set BASE_KV to 12.66 kV (instead of 12.7)																						
%         - Slack bus Vmin = Vmax = 1.0																						
%         - Gen Qmin, Qmax, Pmax magnitudes set to 10 (instead of 999)																						
%         - Branch flow limits disabled, i.e. set to 0 (instead of 999)																						
%         - Add gen cost.																						
%     v3 - 2023-10-19 (RRC)																						
%         - Added new loads																						
%         - Imposed a tighter Vmax (1.05) and Vmin (0.95)																						
%         - Included 10 diesel generators																						
%     v4 - 2023-10-26 (RRC)																						
%         - Added lines to have a weakly meshed system (data from: Load Flow Solution for Meshed Distribution Networks by D. Kumar and S. Agrawal, https://core.ac.uk/download/pdf/53189751.pdf)																						
																						
%% MATPOWER Case Format : Version 2																						
mpc.version = '2';																						
																						
%%-----  Power Flow Data  -----%%																						
%% system MVA base																						
mpc.baseMVA = 10;																						
																						
%% bus data																						
%	bus_i	type	Pd	Qd	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin									
mpc.bus = [ %% (Pd and Qd are specified in kW & kVAr here, converted to MW & MVAr below)																						
	1	3	0	0	0	0	1	1	0	12.66	1	1	1;									
	2	1	8	6	0	0	1	1	0	12.66	1	1.05	0.95;									
	3	1	0	0	0	0	1	1	0	12.66	1	1.05	0.95;									
	4	1	8	6	0	0	1	1	0	12.66	1	1.05	0.95;									
	5	1	0	0	0	0	1	1	0	12.66	1	1.05	0.95;									
	6	1	2.6	2.2	0	0	1	1	0	12.66	1	1.05	0.95;									
	7	2	40.4	30	0	0	1	1	0	12.66	1	1.05	0.95;									
	8	1	75	54	0	0	1	1	0	12.66	1	1.05	0.95;									
	9	1	30	22	0	0	1	1	0	12.66	1	1.05	0.95;									
	10	1	28	19	0	0	1	1	0	12.66	1	1.05	0.95;									
	11	1	145	104	0	0	1	1	0	12.66	1	1.05	0.95;									
	12	1	145	104	0	0	1	1	0	12.66	1	1.05	0.95;									
	13	1	8	5.5	0	0	1	1	0	12.66	1	1.05	0.95;									
	14	1	8	5.5	0	0	1	1	0	12.66	1	1.05	0.95;									
	15	1	0	0	0	0	1	1	0	12.66	1	1.05	0.95;									
	16	1	45.5	30	0	0	1	1	0	12.66	1	1.05	0.95;									
	17	1	60	35	0	0	1	1	0	12.66	1	1.05	0.95;									
	18	1	60	35	0	0	1	1	0	12.66	1	1.05	0.95;									
	19	1	8	6	0	0	1	1	0	12.66	1	1.05	0.95;									
	20	1	1	0.6	0	0	1	1	0	12.66	1	1.05	0.95;									
	21	1	114	81	0	0	1	1	0	12.66	1	1.05	0.95;									
	22	1	5.3	3.5	0	0	1	1	0	12.66	1	1.05	0.95;									
	23	1	0	0	0	0	1	1	0	12.66	1	1.05	0.95;									
	24	1	28	20	0	0	1	1	0	12.66	1	1.05	0.95;									
	25	1	6	4.5	0	0	1	1	0	12.66	1	1.05	0.95;									
	26	1	14	10	0	0	1	1	0	12.66	1	1.05	0.95;									
	27	2	14	10	0	0	1	1	0	12.66	1	1.05	0.95;									
	28	1	26	18.6	0	0	1	1	0	12.66	1	1.05	0.95;									
	29	1	26	18.6	0	0	1	1	0	12.66	1	1.05	0.95;									
	30	1	10	7.5	0	0	1	1	0	12.66	1	1.05	0.95;									
	31	1	10	7.5	0	0	1	1	0	12.66	1	1.05	0.95;									
	32	1	0	0	0	0	1	1	0	12.66	1	1.05	0.95;									
	33	1	14	10	0	0	1	1	0	12.66	1	1.05	0.95;									
	34	1	19.5	14	0	0	1	1	0	12.66	1	1.05	0.95;									
	35	2	6	4	0	0	1	1	0	12.66	1	1.05	0.95;									
	36	1	26	18.6	0	0	1	1	0	12.66	1	1.05	0.95;									
	37	2	26	18.6	0	0	1	1	0	12.66	1	1.05	0.95;									
	38	1	12	9	0	0	1	1	0	12.66	1	1.05	0.95;									
	39	1	24	17	0	0	1	1	0	12.66	1	1.05	0.95;									
	40	1	24	17	0	0	1	1	0	12.66	1	1.05	0.95;									
	41	1	1.2	1	0	0	1	1	0	12.66	1	1.05	0.95;									
	42	1	0	0	0	0	1	1	0	12.66	1	1.05	0.95;									
	43	1	6	4.3	0	0	1	1	0	12.66	1	1.05	0.95;									
	44	1	10	7.5	0	0	1	1	0	12.66	1	1.05	0.95;									
	45	1	39.2	26.3	0	0	1	1	0	12.66	1	1.05	0.95;									
	46	2	39.2	26.3	0	0	1	1	0	12.66	1	1.05	0.95;									
	47	1	12	9	0	0	1	1	0	12.66	1	1.05	0.95;									
	48	1	79	56.4	0	0	1	1	0	12.66	1	1.05	0.95;									
	49	1	384.7	274.5	0	0	1	1	0	12.66	1	1.05	0.95;									
	50	2	384.7	274.5	0	0	1	1	0	12.66	1	1.05	0.95;									
	51	1	40.5	28.3	0	0	1	1	0	12.66	1	1.05	0.95;									
	52	1	3.6	2.7	0	0	1	1	0	12.66	1	1.05	0.95;									
	53	1	4.3	3.5	0	0	1	1	0	12.66	1	1.05	0.95;									
	54	1	26.4	19	0	0	1	1	0	12.66	1	1.05	0.95;									
	55	1	24	17.2	0	0	1	1	0	12.66	1	1.05	0.95;									
	56	1	0	0	0	0	1	1	0	12.66	1	1.05	0.95;									
	57	1	15	11.25	0	0	1	1	0	12.66	1	1.05	0.95;									
	58	1	12	9	0	0	1	1	0	12.66	1	1.05	0.95;									
	59	1	100	72	0	0	1	1	0	12.66	1	1.05	0.95;									
	60	1	12	9	0	0	1	1	0	12.66	1	1.05	0.95;									
	61	1	1244	888	0	0	1	1	0	12.66	1	1.05	0.95;									
	62	1	32	23	0	0	1	1	0	12.66	1	1.05	0.95;									
	63	1	0	0	0	0	1	1	0	12.66	1	1.05	0.95;									
	64	1	227	162	0	0	1	1	0	12.66	1	1.05	0.95;									
	65	2	59	42	0	0	1	1	0	12.66	1	1.05	0.95;									
	66	1	18	13	0	0	1	1	0	12.66	1	1.05	0.95;									
	67	2	18	13	0	0	1	1	0	12.66	1	1.05	0.95;									
	68	1	28	20	0	0	1	1	0	12.66	1	1.05	0.95;									
	69	2	28	20	0	0	1	1	0	12.66	1	1.05	0.95;									
];																						
																						
%% generator data																						
%	bus	Pg	Qg	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1	Pc2	Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf	
mpc.gen = [																						
	1	0	0	0.66	-0.62	1	100	1	0.5	0	0	0	0	0	0	0	0	0	0	0	0;	% diesel: 500 kW
	5	0	0	0	0	1	100	1	0	0	0	0	0	0	0	0	0	0	0	0	0;	% MG 5
	7	0	0	0.46	-0.4	1	100	1	0.35	0	0	0	0	0	0	0	0	0	0	0	0;	% diesel: 350 kW
	15	0	0	0	0	1	100	1	0	0	0	0	0	0	0	0	0	0	0	0	0;	% MG 4
	18	0	0	0	0	1	100	1	0.1	0.1	0	0	0	0	0	0	0	0	0	0	0;	% solar: 100 kW
	20	0	0	0	0	1	100	1	0.05	0.05	0	0	0	0	0	0	0	0	0	0	0;	% wind: 50 kW
	23	0	0	0	0	1	100	1	0	0	0	0	0	0	0	0	0	0	0	0	0;	% MG 3
	27	0	0	0.53	-0.52	1	100	1	0.4	0	0	0	0	0	0	0	0	0	0	0	0;	% diesel: 400 kW
	28	0	0	0	0	1	100	1	0.05	0.05	0	0	0	0	0	0	0	0	0	0	0;	% wind: 50 kW
	29	0	0	0	0	1	100	1	0.075	0.075	0	0	0	0	0	0	0	0	0	0	0;	% solar: 75 kW
	32	0	0	0	0	1	100	1	0	0	0	0	0	0	0	0	0	0	0	0	0;	% MG 6
	35	0	0	0.53	-0.52	1	100	1	0.4	0	0	0	0	0	0	0	0	0	0	0	0;	% diesel: 400 kW
	36	0	0	0	0	1	100	1	0.1	0.1	0	0	0	0	0	0	0	0	0	0	0;	% wind: 100 kW
	37	0	0	0.46	-0.4	1	100	1	0.35	0	0	0	0	0	0	0	0	0	0	0	0;	% diesel: 350 kW
	39	0	0	0	0	1	100	1	0.05	0.05	0	0	0	0	0	0	0	0	0	0	0;	% solar: 50 kW
	42	0	0	0	0	1	100	1	0	0	0	0	0	0	0	0	0	0	0	0	0;	% MG 7
	44	0	0	0	0	1	100	1	0.075	0.075	0	0	0	0	0	0	0	0	0	0	0;	% wind: 75 kW
	46	0	0	0.53	-0.52	1	100	1	0.4	0	0	0	0	0	0	0	0	0	0	0	0;	% diesel: 400 kW
	50	0	0	0.53	-0.52	1	100	1	0.4	0	0	0	0	0	0	0	0	0	0	0	0;	% diesel: 400 kW
	52	0	0	0	0	1	100	1	0.05	0.05	0	0	0	0	0	0	0	0	0	0	0;	% solar: 50 kW
	56	0	0	0	0	1	100	1	0	0	0	0	0	0	0	0	0	0	0	0	0;	% MG 2
	59	0	0	0	0	1	100	1	0.075	0.075	0	0	0	0	0	0	0	0	0	0	0;	% solar: 75 kW
	62	0	0	0	0	1	100	1	0.15	0.15	0	0	0	0	0	0	0	0	0	0	0;	% wind: 150 kW
	63	0	0	0	0	1	100	1	0	0	0	0	0	0	0	0	0	0	0	0	0;	% MG 1
	65	0	0	0.66	-0.62	1	100	1	0.5	0	0	0	0	0	0	0	0	0	0	0	0;	% diesel: 500 kW
	67	0	0	0.46	-0.4	1	100	1	0.35	0	0	0	0	0	0	0	0	0	0	0	0;	% diesel: 350 kW
	69	0	0	0.53	-0.52	1	100	1	0.4	0	0	0	0	0	0	0	0	0	0	0	0;	% diesel: 400 kW
];																						
																						
%% branch data																						
%	fbus	tbus	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax									
mpc.branch = [  %% (r and x specified in ohms here, converted to p.u. below)																						
	1	2	0.0005	0.0012	0	0.67	0	0	0	0	1	-360	360;									
	2	3	0.0005	0.0012	0	0.67	0	0	0	0	1	-360	360;									
	3	4	0.0015	0.0036	0	0.67	0	0	0	0	1	-360	360;									
	4	5	0.0251	0.0294	0	0.67	0	0	0	0	1	-360	360;									
	5	6	0.366	0.1864	0	0.7	0	0	0	0	1	-360	360;									
	6	7	0.381	0.1941	0	0.7	0	0	0	0	1	-360	360;									
	7	8	0.0922	0.047	0	0.7	0	0	0	0	1	-360	360;									
	8	9	0.0493	0.0251	0	0.7	0	0	0	0	1	-360	360;									
	9	10	0.819	0.2707	0	0.7	0	0	0	0	1	-360	360;									
	10	11	0.1872	0.0619	0	0.7	0	0	0	0	1	-360	360;									
	11	12	0.7114	0.2351	0	0.7	0	0	0	0	1	-360	360;									
	12	13	1.03	0.34	0	0.72	0	0	0	0	1	-360	360;									
	13	14	1.044	0.34	0	0.72	0	0	0	0	1	-360	360;									
	14	15	1.058	0.3496	0	0.72	0	0	0	0	1	-360	360;									
	15	16	0.1966	0.065	0	0.72	0	0	0	0	1	-360	360;									
	16	17	0.3744	0.1238	0	0.72	0	0	0	0	1	-360	360;									
	17	18	0.0047	0.0016	0	0.72	0	0	0	0	1	-360	360;									
	18	19	0.3276	0.1083	0	0.72	0	0	0	0	1	-360	360;									
	19	20	0.2106	0.069	0	0.72	0	0	0	0	1	-360	360;									
	20	21	0.3416	0.1129	0	0.72	0	0	0	0	1	-360	360;									
	21	22	0.014	0.0046	0	0.72	0	0	0	0	1	-360	360;									
	22	23	0.1591	0.0526	0	0.72	0	0	0	0	1	-360	360;									
	23	24	0.3463	0.1145	0	0.72	0	0	0	0	1	-360	360;									
	24	25	0.7488	0.2475	0	0.72	0	0	0	0	1	-360	360;									
	25	26	0.3089	0.1021	0	0.72	0	0	0	0	1	-360	360;									
	26	27	0.1732	0.0572	0	0.72	0	0	0	0	1	-360	360;									
	3	28	0.0044	0.0108	0	0.5	0	0	0	0	1	-360	360;									
	28	29	0.064	0.1565	0	0.5	0	0	0	0	1	-360	360;									
	29	30	0.3978	0.1315	0	0.5	0	0	0	0	1	-360	360;									
	30	31	0.0702	0.0232	0	0.5	0	0	0	0	1	-360	360;									
	31	32	0.351	0.116	0	0.5	0	0	0	0	1	-360	360;									
	32	33	0.839	0.2816	0	0.5	0	0	0	0	1	-360	360;									
	33	34	1.708	0.5646	0	0.5	0	0	0	0	1	-360	360;									
	34	35	1.474	0.4873	0	0.5	0	0	0	0	1	-360	360;									
	3	36	0.0044	0.0108	0	0.96	0	0	0	0	1	-360	360;									
	36	37	0.064	0.1565	0	0.96	0	0	0	0	1	-360	360;									
	37	38	0.1053	0.123	0	0.96	0	0	0	0	1	-360	360;									
	38	39	0.0304	0.0355	0	0.96	0	0	0	0	1	-360	360;									
	39	40	0.0018	0.0021	0	0.96	0	0	0	0	1	-360	360;									
	40	41	0.7283	0.8509	0	0.96	0	0	0	0	1	-360	360;									
	41	42	0.31	0.3623	0	0.96	0	0	0	0	1	-360	360;									
	42	43	0.041	0.0478	0	0.96	0	0	0	0	1	-360	360;									
	43	44	0.0092	0.0116	0	0.96	0	0	0	0	1	-360	360;									
	44	45	0.1089	0.1373	0	0.96	0	0	0	0	1	-360	360;									
	45	46	0.0009	0.0012	0	0.96	0	0	0	0	1	-360	360;									
	4	47	0.0034	0.0084	0	0.6	0	0	0	0	1	-360	360;									
	47	48	0.0851	0.2083	0	0.6	0	0	0	0	1	-360	360;									
	48	49	0.2898	0.7091	0	0.6	0	0	0	0	1	-360	360;									
	49	50	0.0822	0.2011	0	0.6	0	0	0	0	1	-360	360;									
	8	51	0.0928	0.0473	0	0.5	0	0	0	0	1	-360	360;									
	51	52	0.3319	0.114	0	0.5	0	0	0	0	1	-360	360;									
	9	53	0.174	0.0886	0	1.5	0	0	0	0	1	-360	360;									
	53	54	0.203	0.1034	0	1.5	0	0	0	0	1	-360	360;									
	54	55	0.2842	0.1447	0	1.5	0	0	0	0	1	-360	360;									
	55	56	0.2813	0.1433	0	1.5	0	0	0	0	1	-360	360;									
	56	57	1.59	0.5337	0	1.5	0	0	0	0	1	-360	360;									
	57	58	0.7837	0.263	0	1.5	0	0	0	0	1	-360	360;									
	58	59	0.3042	0.1006	0	1.5	0	0	0	0	1	-360	360;									
	59	60	0.3861	0.1172	0	1.5	0	0	0	0	1	-360	360;									
	60	61	0.5075	0.2585	0	1.5	0	0	0	0	1	-360	360;									
	61	62	0.0974	0.0496	0	1.5	0	0	0	0	1	-360	360;									
	62	63	0.145	0.0738	0	1.5	0	0	0	0	1	-360	360;									
	63	64	0.7105	0.3619	0	1.5	0	0	0	0	1	-360	360;									
	64	65	1.041	0.5302	0	1.5	0	0	0	0	1	-360	360;									
	11	66	0.2012	0.0611	0	0.62	0	0	0	0	1	-360	360;									
	66	67	0.0047	0.0014	0	0.62	0	0	0	0	1	-360	360;									
	12	68	0.7394	0.2444	0	0.5	0	0	0	0	1	-360	360;									
	68	69	0.0047	0.0016	0	0.5	0	0	0	0	1	-360	360;									
	21	65	0.2012	0.0611	0	0.67	0	0	0	0	1	-360	360;	% data from: Load Flow Solution for Meshed Distribution Networks by D. Kumar and S. Agrawal, https://core.ac.uk/download/pdf/53189751.pdf)								
	25	32	0.3861	0.1172	0	0.67	0	0	0	0	1	-360	360;									
	26	69	0.1089	0.1373	0	0.67	0	0	0	0	1	-360	360;									
	35	43	0.3744	0.1238	0	0.67	0	0	0	0	1	-360	360;									
	52	40	0.0015	0.0036	0	0.67	0	0	0	0	1	-360	360;									
];																						
																						
%%-----  OPF Data  -----%%																						
%% generator cost data																						
%	1	startup	shutdown	n	x1	y1	...	xn	yn													
%	2	startup	shutdown	n	c(n-1)	...	c0															
mpc.gencost = [																						
	2	0	0	6	0	0	0	0.007604*10^6	12.567926*10^3	1227.752915;	% diesel: 500 kW		bus 1									
	1	0	0	3	0	0	0.000001	0.000001	0.000002	0.000002;	% MG 5		bus 5									
	2	0	0	6	0	0	0	0.010346*10^6	12.733896*10^3	897.711019;	% diesel: 350 kW		bus 7									
	1	0	0	3	0	0	0.000001	0.000001	0.000002	0.000002;	% MG 4		bus 15									
	2	0	0	6	0	0	0	0	0	0;	% solar: 100 kW		bus 18									
	2	0	0	6	0	0	0	0	0	0;	% wind: 50 kW		bus 20									
	1	0	0	3	0	0	0.000001	0.000001	0.000002	0.000002;	% MG 3		bus 23									
	2	0	0	6	0	0	0	0.008581*10^6	13.003589*10^3	970.319336;	% diesel: 400 kW		bus 27									
	2	0	0	6	0	0	0	0	0	0;	% wind: 50 kW		bus 28									
	2	0	0	6	0	0	0	0	0	0;	% solar: 75 kW		bus 29									
	1	0	0	3	0	0	0.000001	0.000001	0.000002	0.000002;	% MG 6		bus 32									
	2	0	0	6	0	0	0	0.008581*10^6	13.003589*10^3	970.319336;	% diesel: 400 kW		bus 35									
	2	0	0	6	0	0	0	0	0	0;	% wind: 100 kW		bus 36									
	2	0	0	6	0	0	0	0.010346*10^6	12.733896*10^3	897.711019;	% diesel: 350 kW		bus 37									
	2	0	0	6	0	0	0	0	0	0;	% solar: 50 kW		bus 39									
	1	0	0	3	0	0	0.000001	0.000001	0.000002	0.000002;	% MG 7		bus 42									
	2	0	0	6	0	0	0	0	0	0;	% wind: 75 kW		bus 44									
	2	0	0	6	0	0	0	0.008581*10^6	13.003589*10^3	970.319336;	% diesel: 400 kW		bus 46									
	2	0	0	6	0	0	0	0.008581*10^6	13.003589*10^3	970.319336;	% diesel: 400 kW		bus 50									
	2	0	0	6	0	0	0	0	0	0;	% solar: 50 kW		bus 52									
	1	0	0	3	0	0	0.000001	0.000001	0.000002	0.000002;	% MG 2		bus 56									
	2	0	0	6	0	0	0	0	0	0;	% solar: 75 kW		bus 59									
	2	0	0	6	0	0	0	0	0	0;	% wind: 150 kW		bus 62									
	1	0	0	3	0	0	0.000001	0.000001	0.000002	0.000002;	% MG 1		bus 63									
	2	0	0	6	0	0	0	0.007604*10^6	12.567926*10^3	1227.752915;	% diesel: 500 kW		bus 65									
	2	0	0	6	0	0	0	0.010346*10^6	12.733896*10^3	897.711019;	% diesel: 350 kW		bus 67									
	2	0	0	6	0	0	0	0.008581*10^6	13.003589*10^3	970.319336;	% diesel: 400 kW		bus 69									
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
