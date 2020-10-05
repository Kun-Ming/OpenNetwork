function generate_synapse(obj, layer1, layer2, syn_param)

    pre_syn_id = randi([1, layer1.total_neurons], obj.Nx, 1); % choose feedforward neuron randomly
    
    Nx = obj.Nx;
    exc_out = obj.exc_out;
    inh_out = obj.inh_out;
    syn_type = obj.syn_type;
    layer1_ei_type = [layer1.neuron_in_layer(:).ei_type];
    layer1_N_exc_neuron = layer1.N_exc_neuron;
    layer1_total_neurons = layer1.total_neurons;
    syn_in_layer = cell(1, Nx);
    
    for j = 1 : Nx
        fprintf("connectionLayer generating synapse: presyn neuron ID = %d\n", j);
%         i = pre_syn_id(j);
        if layer1_ei_type(pre_syn_id(j)) < layer1_N_exc_neuron / layer1_total_neurons % pre syn neuron is exc
            
            postsyn_IDs = get_projection_field(pre_syn_id(j), exc_out, size(layer2.neuron_in_layer));
            post_syn_arr = cell(max(size(postsyn_IDs)), 1);
            
            for k = 1 : max(size(postsyn_IDs))
%                 postsyn_neuron = findobj(layer2.neuron_in_layer, 'ID', postsyn_IDs(k));
                judgement = rand;
                
                if judgement < syn_type % slow syn
                    post_syn_arr{k} = Synapse.base_synapse( postsyn_IDs(k),...
                                                              pre_syn_id(j), ...
                                                              syn_param.slow.taud,...
                                                              syn_param.slow.taur,...
                                                              syn_param.slow.conn_strength.exc,...
                                                              'exc');
                else
                    post_syn_arr{k} = Synapse.base_synapse( postsyn_IDs(k),...
                                                              pre_syn_id(j), ...
                                                              syn_param.fast.taud,...
                                                              syn_param.fast.taur,...
                                                              syn_param.fast.conn_strength.exc,...
                                                              'exc');
                end
                
            end
            
        else    % pre syn neuron is inh
            postsyn_IDs = get_projection_field(pre_syn_id(j), inh_out, size(layer2.neuron_in_layer));
            post_syn_arr = cell(max(size(postsyn_IDs)), 1);
            
            for k = 1 : max(size(postsyn_IDs))
%                 postsyn_neuron = findobj(layer2.neuron_in_layer, 'ID', postsyn_IDs(k));
                judgement = rand;
                
                if judgement < syn_type % slow syn
                    post_syn_arr{k} = Synapse.base_synapse( postsyn_IDs(k),...
                                                              pre_syn_id(j), ...
                                                              syn_param.slow.taud,...
                                                              syn_param.slow.taur,...
                                                              syn_param.slow.conn_strength.inh,...
                                                              'inh');
                    
                else
                    post_syn_arr{k} = Synapse.base_synapse( postsyn_IDs(k),...
                                                              pre_syn_id(j), ...
                                                              syn_param.fast.taud,...
                                                              syn_param.fast.taur,...
                                                              syn_param.fast.conn_strength.inh,...
                                                              'inh');
                    
                end
            end
        end
        post_syn_arr(cellfun(@isempty,post_syn_arr))=[];
        syn_in_layer{j} = post_syn_arr;
        
    end
    obj.syn_in_layer = syn_in_layer;
    fprintf('\n\n\n---end---\n\n\n');
end

function [postsyn_IDs] = get_projection_field(presyn_ID, k, layer_size)
%   return a double vector, 25*1
    [presyn_pos.x, presyn_pos.y] = ind2sub(layer_size, presyn_ID);
    mask = strel('diamond', k).Neighborhood; % projection field, symboled by a diamond matrix
    [lx, ly] = size(mask);
    layer = zeros(layer_size);  % same size as neuron_in_layer
    sublayer = ones(lx, ly);    % same size as mask
    
    layer = padarray(layer, [floor(lx/2) floor(ly/2)]); % zero padding
    presyn_pos.x = presyn_pos.x + floor(lx/2); % transform position
    presyn_pos.y = presyn_pos.y + floor(ly/2);
    
    % embed projection field to layer
    layer( presyn_pos.x - floor(lx/2) : presyn_pos.x + floor(lx/2), ...
        presyn_pos.y - floor(ly/2) : presyn_pos.y + floor(ly/2)) = sublayer.*mask; 
    
    % resizing, delete padding
    layer = layer(ceil(lx/2) : size(layer, 1) - floor(lx/2),...
        ceil(ly/2) : size(layer, 2) - floor(ly/2));
    postsyn_IDs = find(layer);
end