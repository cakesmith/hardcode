--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:35:15 12/01/2013
-- Design Name:   
-- Module Name:   /home/nick/Hardcode/test_salsa8.vhd
-- Project Name:  Hardcode
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: salsa8
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
use work.scrypt.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_salsa8 IS
END test_salsa8;
 
ARCHITECTURE behavior OF test_salsa8 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT salsa8
    PORT(
         Xin : IN  word;
         clk : in std_logic;
         rst : in std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Xin : word := (others => '0');
   signal clk : std_logic;
   signal rst : std_logic;
   
   -- No clocks detected in port list. Replace clk below with 
   -- appropriate port name 
 
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: salsa8 PORT MAP (
          Xin => Xin,
          clk => clk,
          rst => rst
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
