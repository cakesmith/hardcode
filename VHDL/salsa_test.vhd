--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:42:31 12/06/2013
-- Design Name:   
-- Module Name:   /home/nick/Hardcode/salsa_test.vhd
-- Project Name:  Hardcode
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: salsa
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.scrypt_types.all;

 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY salsa_test IS
END salsa_test;
 
ARCHITECTURE behavior OF salsa_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT salsa
    PORT(
         clk : in std_logic;
         result : out din_array;
         din : IN  din_array
        );
    END COMPONENT;
    

   --Inputs
   signal din : din_array := (others => (others => '0'));
   signal result : din_array := (others => (others => '0'));
   signal clk : std_logic;
   
   
   -- No clocks detected in port list. Replace clk below with 
   -- appropriate port name 
 
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: salsa PORT MAP (
          clk => clk,
          din => din,
          result => result
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
