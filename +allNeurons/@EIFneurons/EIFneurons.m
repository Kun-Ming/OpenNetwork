classdef EIFneurons < neurons
    properties
        Cm
        gl
        El
        Delta_T
        vT
    end
    
    methods
        function obj = EIFneurons(v_th, v, v_re, type, Cm, gl, El, Delta_T, vT)
            
            obj = obj@neurons(v_th, v, v_re, type);
            
            obj.Cm=Cm;
            obj.gl=gl;
            obj.El=El;
            obj.Delta_T=Delta_T;
            obj.vT=vT;
        end
        
        spike_time = EIF_Integrate(I_input);
            
    end
end