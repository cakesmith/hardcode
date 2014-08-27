--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:40:20 11/20/2013
-- Design Name:   
-- Module Name:   /home/nick/Hardcode/Test_CountGenerator.vhd
-- Project Name:  Hardcode
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CountGenerator
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY Test_CountGenerator IS
END Test_CountGenerator;
 
ARCHITECTURE behavior OF Test_CountGenerator IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CountGenerator
    PORT(
         hbright : IN  std_logic;
         vbright : IN  std_logic;
         hcount : OUT  std_logic_vector(15 downto 0);
         vcount : OUT  std_logic_vector(15 downto 0);
         clk : IN  std_logic;
         rst : IN  std_logic;
         din : IN  std_logic_vector(15 downto 0);
         Load_Display_V : IN  std_logic;
         Load_Display_H : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal hbright : std_logic := '0';
   signal vbright : std_logic := '0';
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal din : std_logic_vector(15 downto 0) := (others => '0');
   signal Load_Display_V : std_logic := '0';
   signal Load_Display_H : std_logic := '0';

 	--Outputs
   signal hcount : std_logic_vector(15 downto 0);
   signal vcount : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CountGenerator PORT MAP (
          hbright => hbright,
          vbright => vbright,
          hcount => hcount,
          vcount => vcount,
          clk => clk,
          rst => rst,
          din => din,
          Load_Display_V => Load_Display_V,
          Load_Display_H => Load_Display_H
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
      hbright <= '0';
      vbright <= '0';
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      
      din <= std_logic_vector(to_unsigned(640, din'length));
      Load_Display_H <= '1';
      wait for clk_period;
      Load_Display_H <= '0';
      din <= std_logic_vector(to_unsigned(480, din'length));
      Load_Display_V <= '1';
      wait for clk_period;
      Load_Display_V <= '0';
      
      for j in 1 to 10 loop
      
      vbright <= '1';

         for i in 1 to 480 loop
            hbright <= '1';
            wait for clk_period * 640;
            hbright <= '0';
            wait for clk_period * 320;
         end loop;
         
      vbright <= '0';
      
      wait for clk_period * 500;
      
      end loop;
      
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
