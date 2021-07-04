Qbot 2 Simulation Instructions

Once the .zip folder containing the simulation has been downloaded, 
load the simulation by running the following command 
in the MATLAB command window: load_qbot2_sim

Running this command initializes everything 
neccessary for the simulation to complete.  
This file calls the following configuration files:
 - init_qbot2_params.m
 - IMU_Error_Properties.m
 - qbot2_motion_plan.m
 - aiding_sensor_config.m

ADJUSTING SIMULATION PARAMETERS
___________________________________________________________________________
These four files can be modified to accomplish the following items:

IMU_Error_Properties.m
 - Toggle the true/false flags to turn on/off IMU errors.  
   Each error source can be turned on or off 
   to simulate a varietty of situations.  

qbot2_motion_plan.m
 - Comment/Uncomment any motion profile for the Qbot 2 to perform.  
   Many options have already been set-up, new motion plans 
   can be created using the other examples. 
   This file generates "ground truth" for the simulation.  

aiding_sensor_config.m
 - Select the derised aiding sensor configuration specified in the comments
   at the begining of the file.  The complimentary filter can also 
   be turned on and off.  Additionally, the Kalman filter models depend on
   parameters that are measured quantities within the simulation.  You can 
   choose either ground truth or measurements into the Kalman filter. 
   Finally, fake aiding sensor noise levels can be modified in this file.

   *** As of 04 July, only conifugrations 0-4 are operational ***

Anytime any of these files are moidified, the command "load_qbot2_sim" 
must be ran again for changes to take effect.  

SELECTING SIMULATION OUTPUTS
___________________________________________________________________________

Within the folder titled "Plot_Functions", open the file titled 
"plot_sim.m".

Toggle the true/false flags to plot different simulation outputs. 

Running the command "load_qbot2_sim" is not required when flags 
within plot_sim.m are adjusted.  



These instructions should serve as a start to running the simulation.  
For questions, feel free to reach out at the following information below.  

David Olson
(512) 496-7290
dolson8@jh.edu