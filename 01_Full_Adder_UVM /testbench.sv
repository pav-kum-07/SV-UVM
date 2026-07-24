// The interface acts as a bundle of wires to connect the UVM TB to the DUT
interface fa_interface;
    logic a;
    logic b;
    logic cin;
    logic sum;
    logic cout;
endinterface


// Include the UVM macros and package
`include "uvm_macros.svh"
import uvm_pkg::*;

// 1. The Sequence Item Class
class fa_sequence_item extends uvm_sequence_item;
  
  // Register the class with the UVM factory so UVM knows it exists
  `uvm_object_utils(fa_sequence_item)

  // Declare stimulus inputs as 'rand' so UVM can generate random scenarios
  rand bit a;
  rand bit b;
  rand bit cin;
  
  // Outputs from the DUT do not need to be randomized
  bit sum;
  bit cout;

  // UVM requires every object class constructor to have a default name string
  function new(string name = "fa_sequence_item");
    super.new(name);
  endfunction

endclass

// 2. The UVM Driver Component
class fa_driver extends uvm_driver #(fa_sequence_item);
  
  // Register with the factory
  `uvm_component_utils(fa_driver)

  // Handle to the virtual interface (the bridge to physical wires)
  virtual fa_interface vif;

  // Components use a different constructor than objects; they need a parent handle
  function new(string name = "fa_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // The build_phase is where components get configured and allocated
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    // Fetch the physical interface wire bundle from the global configuration database
    if (!uvm_config_db#(virtual fa_interface)::get(this, "", "vif", vif)) begin
      `uvm_fatal("DRV", "Could not get virtual interface handle 'vif' from config_db!")
    end
  endfunction

  // The run_phase handles the actual driving behavior
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    // Instead of using the full UVM sequencer connection yet, 
    // we'll pass a dummy packet for this standalone test step.
    `uvm_info("DRV", "Driver's run_phase has started and is waiting to drive...", UVM_LOW)
  endtask
  
  // Create a custom method inside the driver to physically drive the wires
  virtual task drive_packet(fa_sequence_item tx);
    // Drive the virtual interface wires using data from the transaction object
    vif.a   <= tx.a;
    vif.b   <= tx.b;
    vif.cin <= tx.cin;
    
    `uvm_info("DRV", $sformatf("Driving Wires: A=%b, B=%b, Cin=%b", tx.a, tx.b, tx.cin), UVM_LOW)
  endtask

endclass

module tb_top;

    // 1. Instantiate the interface (our bundle of wires)
    fa_interface inf();

    // 2. Instantiate the Design Under Test (DUT)
    full_adder dut (
        .a(inf.a),
        .b(inf.b),
        .cin(inf.cin),
        .sum(inf.sum),
        .cout(inf.cout)
    );

    initial begin
        fa_driver drv;
        fa_sequence_item item;
        
        // 1. Setup the interface database connection
        uvm_config_db#(virtual fa_interface)::set(null, "*", "vif", inf);
        
        // 2. Create the driver and packet objects
        drv = fa_driver::type_id::create("drv", null);
        drv.build_phase(null);
        
        item = fa_sequence_item::type_id::create("item");
        
        // 3. ADDED A LOOP: Repeat the randomization and driving process 5 times
        repeat(5) begin
            if (item.randomize()) begin
                drv.drive_packet(item); 
                
                #10; // Wait for combinational logic to evaluate
                
                `uvm_info("TOP", $sformatf("DUT Output Observed: Sum=%b, Cout=%b", inf.sum, inf.cout), UVM_LOW)
                $display("------------------------------------"); // Visual separator
            end
        end
        
        $finish;
    end
  
endmodule
