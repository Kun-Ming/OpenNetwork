function  generate_synapse(obj, syn_param)
%     parameters:
%     syn_param: a struct to pass paramter of synapse
% 
%     syn_param
%             ├──exc
%             |    ├──fast: taud, taur, conn_strength
%             |    |                                ├──exc2exc  
%             |    |                                └──exc2inh
%             |    |
%             |    └──slow: taud, taur, conn_strength
%             |                                     ├──exc2exc  
%             |                                     └──exc2inh
%             |
%             ├──inh
%                  ├──fast: taud, taur, conn_strength(minus)
%                  |                                      ├──inh2exc  
%                  |                                      └──inh2inh
%                  └──slow: taud, taur, conn_strength(minus)
%                                                         ├──inh2exc  
%                                                         └──inh2inh
    
    
%     keOutDegree = sum(1 : 1 : obj.ke-2) * 4 + (obj.ke - 1) * 4; % a diamond shape of projection range    
%     kiOutDegree = sum(1 : 1 : obj.ki-2) * 4 + (obj.ki - 1) * 4;
    total_neurons = obj.total_neurons;
    ei_type = [obj.neuron_in_layer(:).ei_type];
    N_exc_neuron = obj.N_exc_neuron;
    neuron_in_layer = obj.neuron_in_layer;
    reshape(neuron_in_layer, size(obj.neuron_in_layer));
    ke = obj.ke;
    ki = obj.ki;
    syn_type = obj.syn_type;
    syn_in_layer = cell(total_neurons, 1);
    
    parfor i = 1 : total_neurons   % generate synapse from ith neuron to other neurons
        fprintf("feedforwardLayer generating synapse: presyn neuron ID = %d\n", i);
        if ei_type(i) < N_exc_neuron / total_neurons    % presynaptic neuron: exc neuron
            postsyn_IDs = get_projection_field(i, ke, size(neuron_in_layer));
            post_syn_arr = cell(max(size(postsyn_IDs)) - 1, 1); % minus 1 for itself
            
            for j = 1 : max(size(postsyn_IDs)) - 1
                
                if i == postsyn_IDs(j)
                    continue
                end
                
                postsyn_neuron = findobj(neuron_in_layer, 'ID', postsyn_IDs(j));
                
                judgement = rand;
                
                if judgement < syn_type && postsyn_neuron.ei_type < N_exc_neuron / total_neurons  % slow && post cell is exc
                    post_syn_arr{j} = Synapse.base_synapse( postsyn_neuron,...
                                                              neuron_in_layer(i), ...
                                                              syn_param.exc.slow.taud,...
                                                              syn_param.exc.slow.taur,...
                                                              syn_param.exc.slow.conn_strength.exc2exc,...
                                                              'exc');
                end
                
                if judgement < syn_type && postsyn_neuron.ei_type > N_exc_neuron / total_neurons  % slow && post cell is inh
                    post_syn_arr{j} = Synapse.base_synapse( postsyn_neuron,...
                                                              neuron_in_layer(i), ...
                                                              syn_param.exc.slow.taud,...
                                                              syn_param.exc.slow.taur,...
                                                              syn_param.exc.slow.conn_strength.exc2inh,...
                                                              'exc');
                end
                
                if judgement > syn_type && postsyn_neuron.ei_type < N_exc_neuron / total_neurons  % fast && post cell is exc
                    post_syn_arr{j} = Synapse.base_synapse(postsyn_neuron,...
                                                              neuron_in_layer(i), ...
                                                              syn_param.exc.fast.taud,...
                                                              syn_param.exc.fast.taur,...
                                                              syn_param.exc.fast.conn_strength.exc2exc,...
                                                              'exc');
                end
                
                if judgement > syn_type && postsyn_neuron.ei_type > N_exc_neuron / total_neurons  % fast && post cell is inh
                    post_syn_arr{j} = Synapse.base_synapse(postsyn_neuron,...
                                                              neuron_in_layer(i), ...
                                                              syn_param.exc.fast.taud,...
                                                              syn_param.exc.fast.taur,...
                                                              syn_param.exc.fast.conn_strength.exc2inh,...
                                                              'exc');
                end
            end
            
        else                                            % presynaptic neuron: inh neuron
            postsyn_IDs = get_projection_field(i, ki, size(neuron_in_layer));
            post_syn_arr = cell(max(size(postsyn_IDs)), 1);
            
            for j = 1 : max(size(postsyn_IDs))
                postsyn_neuron = findobj(neuron_in_layer, 'ID', postsyn_IDs(j));
                
                judgement = rand;
                
                if judgement < syn_type && postsyn_neuron.ei_type < N_exc_neuron / total_neurons  % slow && post cell is exc
                    post_syn_arr{j} = Synapse.base_synapse(postsyn_neuron,...
                                                              neuron_in_layer(i), ...
                                                              syn_param.inh.slow.taud,...
                                                              syn_param.inh.slow.taur,...
                                                              syn_param.inh.slow.conn_strength.inh2exc,...
                                                              'inh');
                end
                
                if judgement < syn_type && postsyn_neuron.ei_type > N_exc_neuron / total_neurons  % slow && post cell is inh
                    post_syn_arr{j} = Synapse.base_synapse(postsyn_neuron,...
                                                              neuron_in_layer(i), ...
                                                              syn_param.inh.slow.taud,...
                                                              syn_param.inh.slow.taur,...
                                                              syn_param.inh.slow.conn_strength.inh2inh,...
                                                              'inh');
                end
                
                if judgement > syn_type && postsyn_neuron.ei_type < N_exc_neuron / total_neurons  % fast && post cell is exc
                    post_syn_arr{j} = Synapse.base_synapse(postsyn_neuron,...
                                                              neuron_in_layer(i), ...
                                                              syn_param.inh.fast.taud,...
                                                              syn_param.inh.fast.taur,...
                                                              syn_param.inh.fast.conn_strength.inh2exc,...
                                                              'inh');
                end
                
                if judgement > syn_type && postsyn_neuron.ei_type > N_exc_neuron / total_neurons  % fast && post cell is inh
                    post_syn_arr{j} = Synapse.base_synapse(postsyn_neuron,...
                                                              neuron_in_layer(i), ...
                                                              syn_param.inh.fast.taud,...
                                                              syn_param.inh.fast.taur,...
                                                              syn_param.inh.fast.conn_strength.inh2inh,...
                                                              'inh');
                end
            end
        end
        post_syn_arr(cellfun(@isempty,post_syn_arr))=[];
        syn_in_layer{i} = post_syn_arr;
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


