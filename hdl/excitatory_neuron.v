`timescale 1ns/1ns

module excitatory_neuron #(PREV_LAYER_NEURONS = 784,
                           WEIGHT_WIDTH = 32,
                           POTENT_WIDTH = 48)
                          (input reg clk,
                           input reg rstn,
                           input reg en,
                           input reg [9:0] waddr,
                           input reg [WEIGHT_WIDTH-1:0] wdata,
                           input reg wen,
                           input reg [PREV_LAYER_NEURONS-1:0] spike_in,
                           output wire spike_out);
    
    localparam potent_thres = 48'h000600000000; // threshold to trigger a spike
    localparam potent_rest  = 48'h000280000000; // resting potential
    
    reg signed [POTENT_WIDTH-1:0] potent;
    
    reg signed [WEIGHT_WIDTH-1:0] synapse_weigth [PREV_LAYER_NEURONS-1:0];
    reg signed [WEIGHT_WIDTH-1:0] potent_in [PREV_LAYER_NEURONS-1:0]; // won't exceed weigth width
    reg signed [WEIGHT_WIDTH-1:0] sum_potent_in;
    
    localparam refrac_len = 'd1;
    reg refrac_en;
    reg [3:0] refrac_timer;
    
    always @(posedge clk) begin
        if (wen) synapse_weigth[waddr] <= wdata; // must manually initialize; don't reset
    end
    
    always begin
        for (integer i = 0; i < PREV_LAYER_NEURONS; i++)
            potent_in[i] = spike_in[i] ? synapse_weigth[i] : '0;
    end
    
    always begin
        sum_potent_in = '0;
        for (integer i = 0; i < PREV_LAYER_NEURONS; i++)
            sum_potent_in = sum_potent_in + potent_in[i];
    end
    
    always @(posedge clk) begin
        if (!rstn) begin
            refrac_en    <= '0;
            refrac_timer <= '0;
            end else if (en) begin
            if (spike_out == 1'b1) begin
                refrac_en <= 1'b1; // enter refractory period in next clock
            end
                if (refrac_timer == refrac_len - 1) begin
                    refrac_en    <= 1'b0;
                    refrac_timer <= '0;
                    end else if (refrac_en) begin
                    refrac_timer <= refrac_timer + 1'b1;
                end
        end
    end
    
endmodule
