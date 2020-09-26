classdef connectionLayer < handle
    properties
        exc_out
        inh_out
        Nx
        syn_in_layer
        syn_type
    end
    
    methods
        function obj = connectionLayer(exc_out, inh_out, Nx, total_neurons, syn_type)
            obj.exc_out = exc_out;
            obj.inh_out = inh_out;
            obj.Nx = Nx;
            obj.syn_in_layer = cell(total_neurons, 1);
            obj.syn_type = syn_type;
        end
        
        generate_synapse(obj, layer1, layer2, param);
        simulation(obj, time_now);  
    end
end