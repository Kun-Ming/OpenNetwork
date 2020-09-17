classdef base_synapse < handle
    properties
        presyn_neuron % neuron
        postsyn_neuron % neuron
        
        taud    % tau decay
        taur    % tau rise
        conn_strength  % connection strengh
        pre_ei_type
    end
    
    methods
        function obj = base_synapse(post_neuron, pre_neuron, taud, taur, conn_strength, type)
            if nargin > 1
                obj.postsyn_neuron = post_neuron;
                obj.presyn_neuron = pre_neuron;
                obj.taud = taud;
                obj.taur = taur;
                obj.conn_strength = conn_strength;
                obj.pre_ei_type = type;
            end
        end
        
        syn_simulation(obj);
    end
end