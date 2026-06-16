# btsp-memristive
This repository contains MATLAB code and Simulink models for ongoing research with a goal of memristive implementation of Behavioral Timescale Synaptic Plasticity (BTSP). The MATLAB code and Simulink models intend to implement a representation of the models presented in following papers:

1) Ian Cone and Harel Z. Shouval - Behavioral Time Scale Plasticity of Place Fields: Mathematical Analysis (2021)
2) Katie C Bittner, Aaron D Milstein, Christine Grienberger, Sandro Romani, Jeffrey C Magee - Behavioral time scale synaptic plasticity underlies CA1 place fields       (2017)

In this repository you will find:

1) Systems representation of a single synapse (under "systems-approach")
   Representation of the model using standard Simulink blocks.
   
2) Electrical representation of a single synapse (under "electrical")
   Representation of the model using standard analog electronic components. This representation could serve as an alternative to a memristive implementation, with       some necessary improvements regarding the implementation of accurate constants.

3) Memristive representation - initial stage (under "memristive")
   The initial stage of a memristive representation of the model. This section is currently being developed.

Prerequisites to run the code/models:
1) MATLAB (the version used was MATLAB R2024a)
2) Simulink

Instructions to run the code/models:
1) Clone or download the repository.
2) Open MATLAB and set Current Folder to the root directory of this repository.
3) For each representation, first run the corresponding .m file (if any) to load the parameters into the Workspace, and the run the Simulink model simulation
