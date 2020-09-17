import Layers.*
import allNeurons.*
import Synapse.*
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
layer1 = Layers.FeedforwardLayer([20,20], 300, 100, .2, 6, 3, 2);
layer1.neuron_in_layer(4).spike_train = [0 1 1 1 0 1 1];

syn_param.exc.fast.taud = 100;
syn_param.exc.fast.taur = 2;
syn_param.exc.fast.conn_strength.exc2exc = 80;
syn_param.exc.fast.conn_strength.exc2inh = -240;

syn_param.exc.slow.taud = 5;
syn_param.exc.slow.taur = 1;
syn_param.exc.slow.conn_strength.exc2exc = 80;
syn_param.exc.slow.conn_strength.exc2inh = -240;

syn_param.inh.fast.taud = 100;
syn_param.inh.fast.taur = 2;
syn_param.inh.fast.conn_strength.inh2exc = 40;
syn_param.inh.fast.conn_strength.inh2inh = -300;

syn_param.inh.slow.taud = 8;
syn_param.inh.slow.taur = 2;
syn_param.inh.slow.conn_strength.inh2exc = 40;
syn_param.inh.slow.conn_strength.inh2inh = -300;

layer1.generate_synapse(syn_param);

for time = 1 : 20
    layer1.simulation(time);
end














