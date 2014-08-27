--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:12:58 11/20/2013
-- Design Name:   
-- Module Name:   /home/nick/Hardcode/Test_VGA.vhd
-- Project Name:  Hardcode
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: VGA
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
 
ENTITY Test_VGA IS
END Test_VGA;
 
ARCHITECTURE behavior OF Test_VGA IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT VGA
    PORT(
         CLK : IN  std_logic;
         I_RESET : IN  std_logic;
         O_HSYNC : OUT  std_logic;
         O_VSYNC : OUT  std_logic;
         O_VIDEO_R : OUT  std_logic_vector(3 downto 0);
         O_VIDEO_G : OUT  std_logic_vector(3 downto 0);
         O_VIDEO_B : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal I_RESET : std_logic := '0';
   signal I_SW : std_logic_vector(3 downto 0);
   
 	--Outputs
   signal O_HSYNC : std_logic;
   signal O_VSYNC : std_logic;
   signal O_VIDEO_R : std_logic_vector(3 downto 0);
   signal O_VIDEO_G : std_logic_vector(3 downto 0);
   signal O_VIDEO_B : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 31.25 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: VGA PORT MAP (
          CLK => CLK,
          I_RESET => I_RESET,
          O_HSYNC => O_HSYNC,
          O_VSYNC => O_VSYNC,
          O_VIDEO_R => O_VIDEO_R,
          O_VIDEO_G => O_VIDEO_G,
          O_VIDEO_B => O_VIDEO_B
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
 --     I_RESET <= '1';
      wait for 100 ns;	
      I_RESET <= '0';
      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
