--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:01:32 11/15/2013
-- Design Name:   
-- Module Name:   /home/nick/Hardcode/Test_HVSyncGenerator.vhd
-- Project Name:  Hardcode
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: HVSyncGenerator
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

use work.video_types.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY Test_HVSyncGenerator IS
END Test_HVSyncGenerator;
 
ARCHITECTURE behavior OF Test_HVSyncGenerator IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT HVSyncGenerator
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         en  : in std_logic;
         din : IN  std_logic_vector(15 downto 0);
         
         Load_VerticalFrontPorch : IN  std_logic;
         Load_VerticalSyncPulse : IN  std_logic;
         Load_VerticalBackPorch : IN  std_logic;
         Load_VerticalDisplay : IN  std_logic;
         
         Load_HorizontalFrontPorch : IN  std_logic;
         Load_HorizontalSyncPulse : IN  std_logic;
         Load_HorizontalBackPorch : IN  std_logic;
         Load_HorizontalDisplay : IN  std_logic;
         
         hsync : OUT  std_logic;
         hcount : OUT  std_logic_vector(15 downto 0);
         vsync : OUT  std_logic;
         vcount : OUT  std_logic_vector(15 downto 0);
         bright : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal en  : std_logic := '0';
   signal din : std_logic_vector(15 downto 0) := (others => '0');
   
   signal Load_VerticalFrontPorch : std_logic := '0';
   signal Load_VerticalSyncPulse : std_logic := '0';
   signal Load_VerticalBackPorch : std_logic := '0';
   signal Load_VerticalDisplay : std_logic := '0';
   
   signal Load_HorizontalFrontPorch : std_logic := '0';
   signal Load_HorizontalSyncPulse : std_logic := '0';
   signal Load_HorizontalBackPorch : std_logic := '0';
   signal Load_HorizontalDisplay : std_logic := '0';

 	--Outputs
   signal hsync : std_logic;
   signal hcount : std_logic_vector(15 downto 0);
   signal vsync : std_logic;
   signal vcount : std_logic_vector(15 downto 0);
   signal bright : std_logic;

   -- Clock period definitions
   constant clk_period : time := 40 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: HVSyncGenerator PORT MAP (
          clk => clk,
          rst => rst,
          din => din,
          en => en,
          Load_VerticalFrontPorch => Load_VerticalFrontPorch,
          Load_VerticalSyncPulse => Load_VerticalSyncPulse,
          Load_VerticalBackPorch => Load_VerticalBackPorch,
          Load_VerticalDisplay => Load_VerticalDisplay,
          Load_HorizontalFrontPorch => Load_HorizontalFrontPorch,
          Load_HorizontalSyncPulse => Load_HorizontalSyncPulse,
          Load_HorizontalBackPorch => Load_HorizontalBackPorch,
          Load_HorizontalDisplay => Load_HorizontalDisplay,
          hsync => hsync,
          hcount => hcount,
          vsync => vsync,
          vcount => vcount,
          bright => bright
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
     wait for 100 ns;	
      rst <= '1';
      wait for clk_period*10;
      rst <= '0';

      din <= std_logic_vector(to_unsigned(PIXELS, din'length));
      load_Horizontaldisplay <= '1';
      
      wait for clk_period;
      
      load_Horizontaldisplay <= '0';
      load_HorizontalFrontPorch <= '1';
      
      din <= std_logic_vector(to_unsigned(hfp, din'length));
      
      wait for clk_period;
      
      load_Horizontalfrontporch <= '0';
      
      wait for clk_period * 3;
      
      
      load_Horizontalsyncpulse <= '1';
      
      din <= std_logic_vector(to_unsigned(hpulse, din'length));
      
      wait for clk_period;
      
      load_Horizontalsyncpulse <= '0';
      load_Horizontalbackporch <= '1';
      
      din <= std_logic_vector(to_unsigned(hbp, din'length));
      
      wait for clk_period;
      
      load_Horizontalbackporch <= '0';
      
      Load_VerticalDisplay <= '1';
      
      din <= std_logic_vector(to_unsigned(LINES, din'length));
      
      wait for clk_period;
      
      load_verticaldisplay <= '0';
      
      load_verticalFrontPorch <= '1';
      
      din <= std_logic_vector(to_unsigned(vfp, din'length));
      
      wait for clk_period;
      
      load_verticalfrontporch <= '0';
      
      load_verticalsyncpulse <= '1';
      
      din <= std_logic_vector(to_unsigned(vpulse, din'length));
      
      wait for clk_period;
      
      load_verticalsyncpulse <= '0';
      
      load_verticalbackporch <= '1';
      
      din <= std_logic_vector(to_unsigned(vbp, din'length));
      
      wait for clk_period;
      
      load_verticalbackporch <= '0';
      
      en <= '1';
      
      
      -- insert stimulus here 

      wait;
   end process;

END;
