--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:09:20 11/20/2013
-- Design Name:   
-- Module Name:   /home/nick/Hardcode/Test_LoadSyncRegs.vhd
-- Project Name:  Hardcode
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: LoadSyncRegs
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
--USE ieee.numeric_std.ALL;
 
ENTITY Test_LoadSyncRegs IS
END Test_LoadSyncRegs;
 
ARCHITECTURE behavior OF Test_LoadSyncRegs IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT LoadSyncRegs
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         dout : OUT  std_logic_vector(15 downto 0);
         Load_Display_H : OUT  std_logic;
         Load_SyncPulse_H : OUT  std_logic;
         Load_FrontPorch_H : OUT  std_logic;
         Load_BackPorch_H : OUT  std_logic;
         Load_HsyncActiveHigh : OUT  std_logic;
         Load_Display_V : OUT  std_logic;
         Load_SyncPulse_V : OUT  std_logic;
         Load_FrontPorch_V : OUT  std_logic;
         Load_BackPorch_V : OUT  std_logic;
         Load_VsyncActiveHigh : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal dout : std_logic_vector(15 downto 0);
   signal Load_Display_H : std_logic;
   signal Load_SyncPulse_H : std_logic;
   signal Load_FrontPorch_H : std_logic;
   signal Load_BackPorch_H : std_logic;
   signal Load_HsyncActiveHigh : std_logic;
   signal Load_Display_V : std_logic;
   signal Load_SyncPulse_V : std_logic;
   signal Load_FrontPorch_V : std_logic;
   signal Load_BackPorch_V : std_logic;
   signal Load_VsyncActiveHigh : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: LoadSyncRegs PORT MAP (
          clk => clk,
          rst => rst,
          dout => dout,
          Load_Display_H => Load_Display_H,
          Load_SyncPulse_H => Load_SyncPulse_H,
          Load_FrontPorch_H => Load_FrontPorch_H,
          Load_BackPorch_H => Load_BackPorch_H,
          Load_HsyncActiveHigh => Load_HsyncActiveHigh,
          Load_Display_V => Load_Display_V,
          Load_SyncPulse_V => Load_SyncPulse_V,
          Load_FrontPorch_V => Load_FrontPorch_V,
          Load_BackPorch_V => Load_BackPorch_V,
          Load_VsyncActiveHigh => Load_VsyncActiveHigh
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
