classdef base_synapse < handle
    properties
        postsyn_neuron % neuron
        
        taud    % tau decay
        taur    % tau rise
        J       % connection strengh
        ei_type
    end
    
    methods
        function obj = base_synapse(neuron, taud, taur, J, type)
            obj.postsyn_neuron = neuron;
            obj.taud = taud;
            obj.taur = taur;
            obj.J = J;
            obj.ei_type = type;
        end
    end
end