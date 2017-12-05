%% The main script to run the FLIPPY multi-contact walking simulation


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Load Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
old_param_file = [cur,'/param/fanuc_6DOF_2017_09_07_1655B2A.yaml'];

[params,x0] = loadParam(old_param_file);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Run the simulator
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% you can assign these function handle to have additional processing
% functions in the simulation
% flippy.PreProcess = str2func('nop'); %called before ode
% flippy.PostProcess = str2func('nop');% called after ode
% flippy.UserNlpConstraint = str2func('nop');


t0 = 0;
tf = params.ppos(1);
params.epsilon = 10;
eventnames = 'deltafinal';
sim_opts=[];
logger = SimLogger(flippy);

% control  = IOFeedback('IO');
control = CLFCBFQP('CLFCBF',flippy,params);
    
tic
flippy.simulate(t0, x0, tf, control, params, logger, eventnames, sim_opts);
toc

%% Plot the Data

Analyze(logger.flow,false);
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Run the animator
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% export_file = fullfile(cur,'tmp','flippy_move.avi');
% anim_obj = animator(flippy);
% anim_obj.Options.ViewAngle=[39,24];
% anim_obj.animate(flippy_move.Flow, export_file);
