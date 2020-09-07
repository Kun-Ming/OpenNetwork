k = 3;
a = rand(20,20);
layer_size = size(a);
presyn_pos.x = 9;
presyn_pos.y = 10;
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