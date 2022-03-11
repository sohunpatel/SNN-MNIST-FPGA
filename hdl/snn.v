`timescale 1ns/1ns

module snn #(WEIGHT_WIDTH = 32,
             POTENT_WIDTH = 48,
             TIMESTEP_MAX = 200)
            (input reg clk,
             input reg rstn,
             input reg en,
             output wire [3:0] result);
    
    localparam INPUT_LAYER_NEURONS  = 'd784;
    localparam HIDDEN_LAYER_NEURONS = 'd100; // currently only one hidden layer
    localparam BRAM_LATENCY         = 'd2;
    localparam INIT_STEPS           = INPUT_LAYER_NEURONS + BRAM_LATENCY;
    localparam TIMESTEP_MAX_I       = TIMESTEP_MAX + BRAM_LATENCY; // num of lines in the input coe file + bram latency
    localparam CNT_WIDTH            = 'd7; // width of spiking cnt,            = width of TIMESTEP/2
    
    
    
endmodule
