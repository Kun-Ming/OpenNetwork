classdef BaseLayer < handle 
    properties
        % parameter
        total_neurons
        dim
        N_neurons_in_dim
        
        % data
        synapse     % type: containers.Map
    end
    
    methods
        function obj = BaseLayer(N_neurons_in_dim)            
            obj.total_neurons = prod(N_neurons_in_dim);
            obj.dim = length(N_neurons_in_dim);
            obj.N_neurons_in_dim = N_neurons_in_dim;    
            obj.synapse = containers.Map;
        end
    end
    
    methods(Abstract)
        [all_syn_layer] = generate_synapse(conn_strength, type, speed);     %super parameter
    end
end