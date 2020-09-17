classdef FeedforwardLayer < Layers.BaseLayer
    properties
        %parameter
        N_exc_neuron
        N_inh_neuron
        syn_type    % precentage of fast or slow
        simulationTime
        ke
        ki
        
        %data
        neuron_in_layer    % neuron's distribution in this layer, a 1d/2d/3d matrix of neuron object.
        syn_in_layer
    end
    
    methods
        function obj = FeedforwardLayer(N_neurons_in_dim, N_exc_neuron, N_inh_neuron, syn_type, ...
                simulationTime, ke, ki)
            assert(isequal(N_exc_neuron + N_inh_neuron, prod(N_neurons_in_dim)), ...
                "constructing FeedforwardLayer error: N_exc_neuron + N_inh_neuron != N_neurons_in_dim");
            
            obj = obj@Layers.BaseLayer(N_neurons_in_dim);
            
            obj.N_exc_neuron = N_exc_neuron;
            obj.N_inh_neuron = N_inh_neuron;
            obj.syn_type = syn_type;
            obj.simulationTime = simulationTime;
            obj.ke = ke;
            obj.ki = ki;
            
            neuron = allNeurons.EIFneurons(0, simulationTime);  % object for proivde param in next line
            obj.neuron_in_layer = arrayfun(@(x) allNeurons.EIFneurons(x, simulationTime), ...
                (neuron.v_lb - neuron.v_th)*rand(N_neurons_in_dim) + neuron.v_th);
            a = (1 : 1 : obj.total_neurons);
            neuronID = mat2cell(a(:), ones(1, obj.total_neurons));
            [obj.neuron_in_layer.ID] = neuronID{:};
            
            % determin exc or inh
            [obj.neuron_in_layer(:).ei_type] = deal(rand);
            
            obj.syn_in_layer = cell(obj.total_neurons, 1);
        end
        
        generate_synapse(obj, conn_strength, type, speed);
        simulation(obj, time_now);   
    end
end