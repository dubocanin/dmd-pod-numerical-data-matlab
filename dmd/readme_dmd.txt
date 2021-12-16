- all files except "DMD_gridded/scattered" are functions used by the script "DMD_gridded/scattered"
- before using the code paths should be adjusted

- to perform the DMD analysis, run the "DMD_analysis.mat" script
	1. load the desired file, and specify variable to perform the DMD on
	2. adjust the name of your variable within the variable "X"
	3. specify the amount of energy to be preserved (between 0 and 0.999)
	4. once informed about how many DMD modes (look out for [r] in workspace) preserves
	   required amount of energy, you will be promped to select num-row * num-col 
	   of subplots where each mode will be shown.
	5. the rest of a script runs on its own