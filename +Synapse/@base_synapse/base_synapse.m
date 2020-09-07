classdef base_synapse < handle
    properties
        presyn_neuron % neuron
        postsyn_neuron % neuron
        
        taud    % tau decay
        taur    % tau rise
        conn_strength  % connection strengh
        ei_type
    end
    
    methods
        function obj = base_synapse(neuron, taud, taur, conn_strength, type)
            obj.postsyn_neuron = neuron;
            obj.taud = taud;
            obj.taur = taur;
            obj.conn_strength = conn_strength;
            obj.ei_type = type;
        end
        simulation(obj);
    end
end