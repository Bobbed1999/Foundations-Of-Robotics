clc
clear all
close all
%% demo
sys = tf([1],[2,8,16])    % plant model
pd = pidtune(sys,'pd')
%%
pidTuner(sys,pd)