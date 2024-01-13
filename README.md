# Hierarchical AC Optimal Power Flow of Multi-microgrid Systems Using a Combination of Learning-based and Lagrangian Methods
### EE 300 Thesis

`cases` folder: contains the MATPOWER cases for the simulation testbed (IEEE 69-bus system and 7 microgrids)\
`code_power_exchange_determination.m`: determines if there is a surplus or a deficiency, along with the offer price for the surplus\
`code_dispatch_ds.m`: performs an AC OPF for economic dispatch at the distribution system (DS) level\
`code_dispatch_mg.m`: performs an AC OPF for economic dispatch at the microgrid (MG) level\
`version19.ipynb`: facilitates the training of the artificial neural network-multilayer perception (ANN-MLP) model for the DS-level AC OPF\
`model.h5`: contains the resulting ANN-MLP model for the simulation testbed\
