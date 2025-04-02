//======================================
// Snake Game PRNG Module Testbench - prng_tb.v
//======================================
`timescale 1ns/10ps

`define CLOCK \
  begin \
    in_clka = 0; in_clkb = 0; #10; \
    in_clka = 1; in_clkb = 0; #10; \
    in_clka = 0; in_clkb = 0; #10; \
    in_clka = 0; in_clkb = 1; #10; \
  end

module prng_tb();

// Inputs to module
reg       in_clka, in_clkb, in_restart;
reg       in_request_rand;

// Outputs from module
wire       out_prng_done;
wire [5:0] out_random_num;

// Create an instance of the module
prng         numgen (.clka (in_clka),
                    .clkb (in_clkb),
                    .restart (in_restart),
                    .request_rand (in_request_rand),
                    .prng_done (out_prng_done),
                    .random_num (out_random_num),
)

initial
begin



// restart
in_restart = 1;
in_request_rand = 0;
`CLOCK

// idle for a few cycles to show that the prng module does not do anything
in_restart = 0;
in_request_rand = 0;
`CLOCK
`CLOCK
`CLOCK
`CLOCK

// request a new random number!
in_request_rand = 1;
`CLOCK

// a few clock cycles just to make sure that random_num doesn't change 
in_request_rand = 0;
`CLOCK
`CLOCK
`CLOCK

// request a new random number!
in_request_rand = 1;
`CLOCK

// a few clock cycles just to make sure that random_num doesn't change 
in_request_rand = 0;
`CLOCK
`CLOCK
`CLOCK

// request a new random number!
in_request_rand = 1;
`CLOCK

// a few clock cycles just to make sure that random_num doesn't change 
in_request_rand = 0;
`CLOCK
`CLOCK
`CLOCK

// idle for a few clock cycles after we're done
`CLOCK
`CLOCK
`CLOCK




$dumpfile ("prng_tb.vcd");
$dumpvars;
$stop;

end

endmodule