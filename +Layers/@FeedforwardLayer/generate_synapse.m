function [syn_in_layer] = generate_synapse(obj, conn_strength, speed)
    % parameters   :
    % conn_strength: 2*2 matrix, contain 2 connecting strength of each synapse.
    %                    exc | inh
    %               fast  *    *
    %               slow  *    *
    %                 
    % speed : 3*2 matrix: 
    %        decay | rise
    %       E  *       *
    %       I  *       *
    %       X  *       *
    %                 
    % ke           : radius of exc projection range.
    % ki           : radius of inh projection range.
    
    keOutDegree = sum(1 : 1 : obj.ke-2) * 4 + (obj.ke - 1) * 4; % a diamond shape of projection range    
    kiOutDegree = sum(1 : 1 : obj.ki-2) * 4 + (obj.ki - 1) * 4;
    
    for i = 1 : obj.total_neurons   % generate synapse from ith neuron to other nerurons
        if rand < obj.N_exc_neuron / total_neurons      % presynaptic neuron: exc neuron
            postsyn_IDs = get_projection_field(presyn_ID, obj.ke, size(obj.neuron_in_layer));
            
            % 构造synapse数组，用find()函数找出postsyn_IDs的neuron
            
        else                                            % presynaptic neuron: inh neuron
            postsyn_IDs = get_projection_field(presyn_ID, obj.ki, size(obj.neuron_in_layer));
            [temp_inh(:).ID] = postsyn_IDs{:};
            [temp_exc(:).ei_type] = 'inh';
            [temp_inh(:).taur] = deal(speed(1, 2));
            [temp_inh(:).taud] = deal(speed(1, 1));
            
            obj.syn_in_layer(i) = temp_inh;
        end
    end
end

function [postsyn_IDs] = get_projection_field(presyn_ID, k, layer_size)
%   return a cell array
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
    
    % resizing, delete zero padding
    layer = layer(ceil(lx/2) : size(layer, 1) - floor(lx/2),...
        ceil(ly/2) : size(layer, 2) - floor(ly/2));
    postsyn_IDs = find(layer);
end



















