--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:15:31 11/25/2013
-- Design Name:   
-- Module Name:   /home/nick/Hardcode/Test_ALU.vhd
-- Project Name:  Hardcode
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
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

use work.cpu_types.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY Test_ALU IS
END Test_ALU;
 
ARCHITECTURE behavior OF Test_ALU IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(15 downto 0);
         D : IN  std_logic_vector(15 downto 0);
         opcode : IN  std_logic_vector(5 downto 0);
         dout : OUT  std_logic_vector(15 downto 0);
         zr : OUT  std_logic;
         ng : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(15 downto 0) := (others => '0');
   signal D : std_logic_vector(15 downto 0) := (others => '0');
   signal opcode : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal dout : std_logic_vector(15 downto 0);
   signal zr : std_logic;
   signal ng : std_logic;
   -- No clocks detected in port list. Replace clk below with 
   -- appropriate port name 
   signal clk : std_logic;
   
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          D => D,
          opcode => opcode,
          dout => dout,
          zr => zr,
          ng => ng
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
--"0"   : "101010",
--"1"   : "111111",
--"-1"  : "111010",
--"D"   : "001100",
--"A"   : "110000",
--"!D"  : "001101",
--"!A"  : "110001",
--"-D"  : "001111",
--"-A"  : "110011",
--"D+1" : "011111",
--"A+1" : "110111",
--"D-1" : "001110",
--"A-1" : "110010",
--"D+A" : "000010",
--"A+D" : "000010",
--"D-A" : "010011",
--"A-D" : "000111",
--"D&A" : "000000",
--"D|A" : "010101" 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      
      
      
      
      
      --"0"   : "101010",

      A <= std_logic_vector(to_signed(256, A'length));
      D <= std_logic_vector(to_signed(32000, D'length));
      
      opcode <= "101010";
      
      wait for clk_period;
 
      assert dout = std_logic_vector(to_signed(0, D'length))
         report "failure at opcode 0, dout = " & to_string(dout)
            severity failure;
            
      assert zr = '1'
         report "failure at opcode 0, zr = " & std_logic'image(zr)
            severity failure;
            
      assert ng = '0'
         report "failure at opcode 0, ng =" & std_logic'image(ng)
            severity failure;
            



--"1"   : "111111",

      A <= std_logic_vector(to_signed(256, A'length));
      D <= std_logic_vector(to_signed(32000, D'length));

      opcode <= "111111";
      
      wait for clk_period;
 
      assert dout = std_logic_vector(to_signed(1, D'length))
         report "failure at opcode 1, dout = " & to_string(dout)
            severity failure;
            
      assert zr = '0'
         report "failure at opcode 1, zr = " & std_logic'image(zr)
            severity failure;
            
      assert ng = '0'
         report "failure at opcode 1, ng =" & std_logic'image(ng)
            severity failure;
            
            

--"-1"  : "111010",

      A <= std_logic_vector(to_signed(256, A'length));
      D <= std_logic_vector(to_signed(32000, D'length));            
      opcode <= "111010";
      
      wait for clk_period;
 
      assert dout = std_logic_vector(to_signed(-1, D'length))
         report "failure at opcode -1, dout = " & to_string(dout)
            severity failure;
            
      assert zr = '0'
         report "failure at opcode -1, zr = " & std_logic'image(zr)
            severity failure;
            
      assert ng = '1'
         report "failure at opcode -1, ng =" & std_logic'image(ng)
            severity failure;


--"D"   : "001100",
      A <= std_logic_vector(to_signed(256, A'length));
      D <= std_logic_vector(to_signed(32000, D'length));            
      opcode <= "001100";
      
      wait for clk_period;
 
      assert dout = std_logic_vector(to_signed(32000, D'length))
         report "failure at opcode D, dout = " & to_string(dout)
            severity failure;
            
      assert zr = '0'
         report "failure at opcode D, zr = " & std_logic'image(zr)
            severity failure;
            
      assert ng = '0'
         report "failure at opcode D, ng =" & std_logic'image(ng)
            severity failure;
            
--"A"   : "110000",

      A <= std_logic_vector(to_signed(256, A'length));
      D <= std_logic_vector(to_signed(32000, D'length));            
      opcode <= "110000";
      
      wait for clk_period;
 
      assert dout = std_logic_vector(to_signed(256, D'length))
         report "failure at opcode A, dout = " & to_string(dout)
            severity failure;
            
      assert zr = '0'
         report "failure at opcode A, zr = " & std_logic'image(zr)
            severity failure;
            
      assert ng = '0'
         report "failure at opcode A, ng =" & std_logic'image(ng)
            severity failure;
            
--"!D"  : "001101",

      A <= std_logic_vector(to_signed(256, A'length));
      D <= std_logic_vector(to_signed(32000, D'length));            
      opcode <= "001101";
      
      wait for clk_period;
 
      assert dout = std_logic_vector(not to_unsigned(32000, D'length))
         report "failure at opcode !D, dout = " & to_string(dout)
            severity failure;
            
      assert zr = '0'
         report "failure at opcode !D, zr = " & std_logic'image(zr)
            severity failure;
            
      assert ng = '1'
         report "failure at opcode !D, ng =" & std_logic'image(ng)
            severity failure;
            
--"!A"  : "110001",

      A <= std_logic_vector(to_signed(256, A'length));
      D <= std_logic_vector(to_signed(32000, D'length));            
      opcode <= "110001";
      
      wait for clk_period;
 
      assert dout = std_logic_vector(not to_unsigned(256, D'length))
         report "failure at opcode !A, dout = " & to_string(dout)
            severity failure;
            
      assert zr = '0'
         report "failure at opcode !A, zr = " & std_logic'image(zr)
            severity failure;
            
      assert ng = '1'
         report "failure at opcode !A, ng =" & std_logic'image(ng)
            severity failure;
--"-D"  : "001111",
      A <= std_logic_vector(to_signed(256, A'length));
      D <= std_logic_vector(to_signed(32000, D'length));            
      opcode <= "001111";
      
      wait for clk_period;
 
      assert dout = std_logic_vector(to_signed(-32000, D'length))
         report "failure at opcode -D, dout = " & to_string(dout)
            severity failure;
            
      assert zr = '0'
         report "failure at opcode -D, zr = " & std_logic'image(zr)
            severity failure;
            
      assert ng = '1'
         report "failure at opcode -D, ng =" & std_logic'image(ng)
            severity failure;
--"-A"  : "110011",
      A <= std_logic_vector(to_signed(256, A'length));
      D <= std_logic_vector(to_signed(32000, D'length));            
      opcode <= "110011";
      
      wait for clk_period;
 
      assert dout = std_logic_vector(to_signed(-256, D'length))
         report "failure at opcode -A, dout = " & to_string(dout)
            severity failure;
            
      assert zr = '0'
         report "failure at opcode -A, zr = " & std_logic'image(zr)
            severity failure;
            
      assert ng = '1'
         report "failure at opcode -A, ng =" & std_logic'image(ng)
            severity failure;
--"D+1" : "011111",

      A <= std_logic_vector(to_signed(256, A'length));
      D <= std_logic_vector(to_signed(32000, D'length));            
      opcode <= "011111";
      
      wait for clk_period;
 
      assert dout = std_logic_vector(to_signed(32001, D'length))
         report "failure at opcode D+1, dout = " & to_string(dout)
            severity failure;
            
      assert zr = '0'
         report "failure at opcode D+1, zr = " & std_logic'image(zr)
            severity failure;
            
      assert ng = '0'
         report "failure at opcode D+1, ng =" & std_logic'image(ng)
            severity failure;
--"A+1" : "110111",
      A <= std_logic_vector(to_signed(256, A'length));
      D <= std_logic_vector(to_signed(32000, D'length));            
      opcode <= "110111";
      
      wait for clk_period;
 
      assert dout = std_logic_vector(to_signed(257, D'length))
         report "failure at opcode A+1, dout = " & to_string(dout)
            severity failure;
            
      assert zr = '0'
         report "failure at opcode A+1, zr = " & std_logic'image(zr)
            severity failure;
            
      assert ng = '0'
         report "failure at opcode A+1, ng =" & std_logic'image(ng)
            severity failure;
            
--"D-1" : "001110",
      A <= std_logic_vector(to_signed(256, A'length));
      D <= std_logic_vector(to_signed(32000, D'length));            
      opcode <= "001110";
      
      wait for clk_period;
 
      assert dout = std_logic_vector(to_signed(31999, D'length))
         report "failure at opcode D-1, dout = " & to_string(dout)
            severity failure;
            
      assert zr = '0'
         report "failure at opcode D-1, zr = " & std_logic'image(zr)
            severity failure;
            
      assert ng = '0'
         report "failure at opcode D-1, ng =" & std_logic'image(ng)
            severity failure;



--"A-1" : "110010",
      A <= std_logic_vector(to_signed(256, A'length));
      D <= std_logic_vector(to_signed(32000, D'length));            
      opcode <= "110010";
      
      wait for clk_period;
 
      assert dout = std_logic_vector(to_signed(255, D'length))
         report "failure at opcode A-1, dout = " & to_string(dout)
            severity failure;
            
      assert zr = '0'
         report "failure at opcode A-1, zr = " & std_logic'image(zr)
            severity failure;
            
      assert ng = '0'
         report "failure at opcode A-1, ng =" & std_logic'image(ng)
            severity failure;
--"D+A" : "000010",

      A <= std_logic_vector(to_signed(256, A'length));
      D <= std_logic_vector(to_signed(32000, D'length));            
      opcode <= "000010";
      
      wait for clk_period;
 
      assert dout = std_logic_vector(to_signed(32256, D'length))
         report "failure at opcode D+A, dout = " & to_string(dout)
            severity failure;
            
      assert zr = '0'
         report "failure at opcode D+A, zr = " & std_logic'image(zr)
            severity failure;
            
      assert ng = '0'
         report "failure at opcode D+A, ng =" & std_logic'image(ng)
            severity failure;

--"D-A" : "010011",
      A <= std_logic_vector(to_signed(256, A'length));
      D <= std_logic_vector(to_signed(32000, D'length));            
      opcode <= "010011";
      
      wait for clk_period;
 
      assert dout = std_logic_vector(to_signed(31744, D'length))
         report "failure at opcode D-A, dout = " & to_string(dout)
            severity failure;
            
      assert zr = '0'
         report "failure at opcode D-A, zr = " & std_logic'image(zr)
            severity failure;
            
      assert ng = '0'
         report "failure at opcode D-A, ng =" & std_logic'image(ng)
            severity failure;
--"A-D" : "000111",
      A <= std_logic_vector(to_signed(256, A'length));
      D <= std_logic_vector(to_signed(32000, D'length));            
      opcode <= "000111";
      
      wait for clk_period;
 
      assert dout = std_logic_vector(to_signed(-31744, D'length))
         report "failure at opcode A-D, dout = " & to_string(dout)
            severity failure;
            
      assert zr = '0'
         report "failure at opcode A-D, zr = " & std_logic'image(zr)
            severity failure;
            
      assert ng = '1'
         report "failure at opcode A-D, ng =" & std_logic'image(ng)
            severity failure;
--"D&A" : "000000",
      A <= std_logic_vector(to_signed(256, A'length));
      D <= std_logic_vector(to_signed(32000, D'length));            
      opcode <= "000000";
      
      wait for clk_period;
 
      assert dout = std_logic_vector(to_signed(256, D'length))
         report "failure at opcode , dout = " & to_string(dout)
            severity failure;
            
      assert zr = '0'
         report "failure at opcode , zr = " & std_logic'image(zr)
            severity failure;
            
      assert ng = '0'
         report "failure at opcode , ng =" & std_logic'image(ng)
            severity failure;
--"D|A" : "010101" 
      A <= std_logic_vector(to_signed(256, A'length));
      D <= std_logic_vector(to_signed(32000, D'length));            
      opcode <= "010101";
      
      wait for clk_period;
 
      assert dout = std_logic_vector(to_signed(32000, D'length))
         report "failure at opcode , dout = " & to_string(dout)
            severity failure;
            
      assert zr = '0'
         report "failure at opcode , zr = " & std_logic'image(zr)
            severity failure;
            
      assert ng = '0'
         report "failure at opcode , ng =" & std_logic'image(ng)
            severity failure;
            
--"D<A" = "010111"
            
      A <= std_logic_vector(to_signed(256, A'length));
      D <= std_logic_vector(to_signed(32000, D'length));            
      opcode <= "010111";
      
      wait for clk_period;
 
      assert dout = std_logic_vector(to_signed(-1, D'length))
         report "failure at opcode D<A, dout = " & to_string(dout)
            severity failure;
            
      assert zr = '0'
         report "failure at opcode D<A, zr = " & std_logic'image(zr)
            severity failure;
            
      assert ng = '1'
         report "failure at opcode D<A, ng =" & std_logic'image(ng)
            severity failure;
            
      A <= std_logic_vector(to_signed(32000, A'length));
      D <= std_logic_vector(to_signed(256, D'length));            
      opcode <= "010111";
      
      wait for clk_period;
 
      assert dout = std_logic_vector(to_signed(1, D'length))
         report "failure at opcode D<A, dout = " & to_string(dout)
            severity failure;
            
      assert zr = '0'
         report "failure at opcode D<A, zr = " & std_logic'image(zr)
            severity failure;
            
      assert ng = '0'
         report "failure at opcode D<A, ng =" & std_logic'image(ng)
            severity failure;
            
      A <= std_logic_vector(to_signed(256, A'length));
      D <= std_logic_vector(to_signed(256, D'length));            
      opcode <= "010111";
      
      wait for clk_period;
 
      assert dout = std_logic_vector(to_signed(0, D'length))
         report "failure at opcode D<A, dout = " & to_string(dout)
            severity failure;
            
      assert zr = '1'
         report "failure at opcode D<A, zr = " & std_logic'image(zr)
            severity failure;
            
      assert ng = '0'
         report "failure at opcode D<A, ng =" & std_logic'image(ng)
            severity failure;

 
--      A <= std_logic_vector(to_signed(256, A'length));
--      D <= std_logic_vector(to_signed(32000, D'length));            
--      opcode <= ;
--      
--      wait for clk_period;
-- 
--      assert dout = std_logic_vector(to_signed(, D'length))
--         report "failure at opcode , dout = " & to_string(dout)
--            severity failure;
--            
--      assert zr = ''
--         report "failure at opcode , zr = " & std_logic'image(zr)
--            severity failure;
--            
--      assert ng = ''
--         report "failure at opcode , ng =" & std_logic'image(ng)
--            severity failure;
            
  
      -- insert stimulus here 

      wait;
   end process;

END;
