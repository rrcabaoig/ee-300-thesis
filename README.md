# Hierarchical AC Optimal Power Flow of Multi-microgrid Systems Using a Combination of Learning-based and Lagrangian Methods
### EE 300 Thesis

`cases` folder: contains the MATPOWER cases for the simulation testbed (IEEE 69-bus distribution system and 7 microgrids)<br>
`code_power_exchange_determination.m`: determines the amount of surplus/deficiency, along with the offer price for the surplus<br>
`code_dispatch_ds.m`: performs a Lagrangian-based/conventional AC OPF for economic dispatch at the distribution system (DS) level<br>
`code_dispatch_mg.m`: performs a Lagrangian-based/conventional AC OPF for economic dispatch at the microgrid (MG) level<br>
`version19.ipynb` (*rename* - version19, initial release): facilitates the training of the artificial neural network-multilayer perceptron (ANN-MLP) model for the DS-level learning-based AC OPF<br>
`model.h5` (version19, initial release): contains the resulting ANN-MLP model of the DS-level learning-based AC OPF for the simulation testbed<br><br>

Note: The codes/scripts and MATPOWER cases are only applicable to the selected simulation testbed. For other multi-microgrid systems, please adjust the system parameters and ANN-MLP architecture.
