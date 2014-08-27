--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:20:03 11/26/2013
-- Design Name:   
-- Module Name:   /home/nick/Hardcode/Test_MemDecoder.vhd
-- Project Name:  Hardcode
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MemDecoder
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
 
ENTITY Test_MemDecoder IS
END Test_MemDecoder;
 
ARCHITECTURE behavior OF Test_MemDecoder IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MemDecoder
    PORT(
         clk : IN  std_logic;
         addr : IN  std_logic_vector(15 downto 0);
         wr : IN  std_logic;
         RAM_Addr : OUT  std_logic_vector(13 downto 0);
         RAM_wr : OUT  std_logic;
         VR_addr : OUT  std_logic_vector(12 downto 0);
         VR_wr : OUT  std_logic;
         H_Load_Frontporch : OUT  std_logic;
         H_Load_SyncPulse : OUT  std_logic;
         H_Load_BackPorch : OUT  std_logic;
         H_Load_Display : OUT  std_logic;
         H_Load_Advance : OUT  std_logic;
         H_Load_SyncActiveHigh : OUT  std_logic;
         V_Load_Frontporch : OUT  std_logic;
         V_Load_SyncPulse : OUT  std_logic;
         V_Load_BackPorch : OUT  std_logic;
         V_Load_Display : OUT  std_logic;
         V_Load_Advance : OUT  std_logic;
         V_Load_SyncActiveHigh : OUT  std_logic;
         KBD_Data : IN  std_logic_vector(15 downto 0);
         RAM_Data : IN  std_logic_vector(15 downto 0);
         dout : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal addr : std_logic_vector(15 downto 0) := (others => '0');
   signal wr : std_logic := '0';
   signal KBD_Data : std_logic_vector(15 downto 0) := (others => '0');
   signal RAM_Data : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal RAM_Addr : std_logic_vector(13 downto 0);
   signal RAM_wr : std_logic;
   signal VR_addr : std_logic_vector(12 downto 0);
   signal VR_wr : std_logic;
   signal H_Load_Frontporch : std_logic;
   signal H_Load_SyncPulse : std_logic;
   signal H_Load_BackPorch : std_logic;
   signal H_Load_Display : std_logic;
   signal H_Load_Advance : std_logic;
   signal H_Load_SyncActiveHigh : std_logic;
   signal V_Load_Frontporch : std_logic;
   signal V_Load_SyncPulse : std_logic;
   signal V_Load_BackPorch : std_logic;
   signal V_Load_Display : std_logic;
   signal V_Load_Advance : std_logic;
   signal V_Load_SyncActiveHigh : std_logic;
   signal dout : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MemDecoder PORT MAP (
          clk => clk,
          addr => addr,
          wr => wr,
          RAM_Addr => RAM_Addr,
          RAM_wr => RAM_wr,
          VR_addr => VR_addr,
          VR_wr => VR_wr,
          H_Load_Frontporch => H_Load_Frontporch,
          H_Load_SyncPulse => H_Load_SyncPulse,
          H_Load_BackPorch => H_Load_BackPorch,
          H_Load_Display => H_Load_Display,
          H_Load_Advance => H_Load_Advance,
          H_Load_SyncActiveHigh => H_Load_SyncActiveHigh,
          V_Load_Frontporch => V_Load_Frontporch,
          V_Load_SyncPulse => V_Load_SyncPulse,
          V_Load_BackPorch => V_Load_BackPorch,
          V_Load_Display => V_Load_Display,
          V_Load_Advance => V_Load_Advance,
          V_Load_SyncActiveHigh => V_Load_SyncActiveHigh,
          KBD_Data => KBD_Data,
          RAM_Data => RAM_Data,
          dout => dout
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
