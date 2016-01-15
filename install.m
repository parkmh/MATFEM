% For more information, see <a href="matlab: 
% web('http://www.grandmaster.colorado.edu/~parkmh')">Minho Park's Web site</a>.
Ver = 1.0;
user = 'Minho Park';
email = 'min.park@nottingham.ac.uk';

clc
fprintf(' ********************************************\n')
fprintf('\n')
fprintf(' Matlab Finite Element Method Toolbox  %s \n',Ver) 
fprintf('\n')
fprintf('%20s %s\n','Written by', user);
fprintf('%13s %s\n','email :',email);
fprintf(' ********************************************\n')

cwd = pwd;
femroot = cwd;

% Add path
addpath(femroot);
savepath;


fprintf('Finished!!!\n')

