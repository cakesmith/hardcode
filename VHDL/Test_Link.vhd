--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:31:55 12/27/2013
-- Design Name:   
-- Module Name:   /home/nick/Hardcode/Test_Link.vhd
-- Project Name:  Hardcode
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Link
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
 
ENTITY Test_Link IS
END Test_Link;
 
ARCHITECTURE behavior OF Test_Link IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Link
    PORT(
         in_address : IN  std_logic_vector(31 downto 0);
         in_data : IN  std_logic_vector(31 downto 0);
         in_wr : IN  std_logic;
         out_address : OUT  std_logic_vector(31 downto 0);
         out_data : OUT  std_logic_vector(31 downto 0);
         out_wr : OUT  std_logic;
         my_address : OUT  std_logic_vector(31 downto 0);
         my_in_data : IN  std_logic_vector(31 downto 0);
         my_out_data : OUT  std_logic_vector(31 downto 0);
         my_wr : OUT  std_logic
        );
    END COMPONENT;
    
   signal clk : std_logic;

   --Inputs
   signal in_address : std_logic_vector(31 downto 0) := (others => '0');
   signal in_data : std_logic_vector(31 downto 0) := (others => '0');
   signal in_wr : std_logic := '0';
   signal my_in_data : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal out_address : std_logic_vector(31 downto 0);
   signal out_data : std_logic_vector(31 downto 0);
   signal out_wr : std_logic;
   signal my_address : std_logic_vector(31 downto 0);
   signal my_out_data : std_logic_vector(31 downto 0);
   signal my_wr : std_logic;
   -- No clocks detected in port list. Replace clk below with 
   -- appropriate port name 
 
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Link PORT MAP (
          in_address => in_address,
          in_data => in_data,
          in_wr => in_wr,
          out_address => out_address,
          out_data => out_data,
          out_wr => out_wr,
          my_address => my_address,
          my_in_data => my_in_data,
          my_out_data => my_out_data,
          my_wr => my_wr
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
   
      variable a : natural;
      
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      a := 0;
      
      in_address <= std_logic_vector(to_unsigned(a, in_address'length));

      wait for clk_period*10;
      
      a := 1;
      
      in_address <= std_logic_vector(to_unsigned(a, in_address'length));
      
       wait for clk_period*10;
      
      a := 2;
      
      in_address <= std_logic_vector(to_unsigned(a, in_address'length));
      
       wait for clk_period*10;
      
      a := 3;
      
      in_address <= std_logic_vector(to_unsigned(a, in_address'length));
      
       wait for clk_period*10;
      
      a := 4;
      
      in_address <= std_logic_vector(to_unsigned(a, in_address'length));
      
      

      -- insert stimulus here 

      wait;
   end process;

END;
