--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:31:23 11/20/2013
-- Design Name:   
-- Module Name:   /home/nick/Hardcode/Test_SyncGenerator.vhd
-- Project Name:  Hardcode
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: SyncGenerator
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
use work.video_types.all;
 
ENTITY Test_SyncGenerator IS
END Test_SyncGenerator;
 
ARCHITECTURE behavior OF Test_SyncGenerator IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SyncGenerator
    PORT(
         en : IN STD_LOGIC;
         clk : IN  std_logic;
         rst : IN  std_logic;
         din : IN  std_logic_vector(15 downto 0);
         Load_FrontPorch : IN  std_logic;
         Load_SyncPulse : IN  std_logic;
         Load_BackPorch : IN  std_logic;
         Load_Display : IN  std_logic;
         Load_SyncActiveHigh : IN  std_logic;
         Load_Advance : IN std_logic;
         done : OUT std_logic;
         sync : OUT  std_logic;
         display_count : out std_logic_vector(15 downto 0);
         bright : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal din : std_logic_vector(15 downto 0) := (others => '0');
   signal Load_FrontPorch : std_logic := '0';
   signal Load_SyncPulse : std_logic := '0';
   signal Load_BackPorch : std_logic := '0';
   signal Load_Display : std_logic := '0';
   signal Load_SyncActiveHigh : std_logic := '0';
   signal Load_Advance : std_logic := '0';
   signal en : std_logic := '0';

 	--Outputs
   signal sync : std_logic;
   signal bright : std_logic;
   signal done : std_logic;

   -- Clock period definitions
   constant clk_period : time := 40 ns;
   
   constant advance : natural := 0;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SyncGenerator PORT MAP (
          en  => en,
          clk => clk,
          rst => rst,
          din => din,
          Load_FrontPorch => Load_FrontPorch,
          Load_SyncPulse => Load_SyncPulse,
          Load_BackPorch => Load_BackPorch,
          Load_Display => Load_Display,
          Load_SyncActiveHigh => Load_SyncActiveHigh,
          Load_Advance => Load_Advance,
          sync => sync,
          bright => bright,
          done => done
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

      rst <= '1';
      en <= '0';
      wait for clk_period * 10;
      rst <= '0';
      
      Load_Display <= '1';
      din <= std_logic_vector(Default_Display_h);
      wait for clk_period;
      load_display <= '0';
      load_frontporch <= '1';
      din <= std_logic_vector(Default_Frontporch_h);
      wait for clk_period;
      load_frontporch <= '0';
      load_syncpulse <= '1';
      din <= std_logic_vector(Default_syncpulse_h);
      wait for clk_period;
      load_syncpulse <= '0';
      load_backporch <= '1';
      din <= std_logic_vector(default_backporch_h);
      wait for clk_period;
      load_backporch <= '0';
      load_SyncActiveHigh <= '1';
      din <= "0000000000000000";
      wait for clk_period;
      load_syncActiveHigh <= '0';
      load_Advance <= '1';
      din <= std_logic_vector(to_unsigned(advance, din'length));
      wait for clk_period;
      load_advance <= '0';
      
      en <= '1';
      -- insert stimulus here 

      wait;
   end process;

END;
