# Hierarchical AC Optimal Power Flow of Multi-microgrid Systems Using a Combination of Learning-based and Lagrangian Methods
### EE 300 Thesis

`cases` folder: contains the MATPOWER cases for the simulation testbed (IEEE 69-bus system and 7 microgrids)<br>
`code_power_exchange_determination.m`: determines if there is a surplus or a deficiency, along with the offer price for the surplus<br>
`code_dispatch_ds.m`: performs a Lagrangian-based/conventional AC OPF for economic dispatch at the distribution system (DS) level<br>
`code_dispatch_mg.m`: performs a Lagrangian-based/conventional AC OPF for economic dispatch at the microgrid (MG) level<br>
`version19.ipynb` (*rename*): facilitates the training of the artificial neural network-multilayer perception (ANN-MLP) model for the DS-level learning-based AC OPF<br>
`model.h5`: contains the resulting ANN-MLP model for the simulation testbed<br><br>

Note: The codes/scripts and MATPOWER cases are only applicable to the selected simulation testbed. For other multi-microgrid systems, please change the system parameters and ANN-MLP architecture.
