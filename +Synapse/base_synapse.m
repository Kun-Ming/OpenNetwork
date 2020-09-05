classdef base_synapse < handle
    properties
        postsyn % neuron
        
        taud    % tau decay
        taur    % tau rise
        J       % connection strengh
        
    end
    
    methods
        function obj = base_synapse(neuron, taud, taur, J)
            obj.postsyn = neuron;
            obj.taud = taud;
            obj.taur = taur;
            obj.J = J;
        end
    end
end