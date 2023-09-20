%--------------------------------------------------------------------------
%------------- Read raw data from folder without separation into sbfolders
%--------------------------------------------------------------------------
% Configuration Initial
clc; close all; clear;

if ispc
    d = '\';
else
    d = '/';
end

n_classes     = 13;
n_repetitions = 5;
Data          = cell(n_classes, n_repetitions);
% info to read of data
ext_data = '.csv';
path_bd  = uigetdir(pwd, 'Database derectory');
files_bd = dir([path_bd d '*' ext_data]);
n_files  = length(files_bd);

% read of all data in folder
val = 0;
for j1 = 1:n_files
      flag = mod(j1,5);
      if flag == 0
        val = val + 1;
        ind = val;
      else
        ind = val + 1;
      end
      sep   = split(files_bd(j1).name, '_');
      if (length(sep) == 5)
          niter = split(sep{5}, '.');
          rep   = str2num(niter{1});
      else
          niter = split(sep{3}, '.');
          rep   = str2num(niter{1});
      end
      % read data
      Data{ind, rep} = readmatrix([path_bd d files_bd(j1).name]);
end
