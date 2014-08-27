----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:31:51 11/25/2013 
-- Design Name: 
-- Module Name:    CPU - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.video_types.all;

use work.cpu_types.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

Entity CPU is

Port (   clk : in std_logic;
         rst : in std_logic;
         
         DataIn : in std_logic_vector(15 downto 0);
         
         AddrOut : out std_logic_vector(15 downto 0);
         wr      : out std_logic;
         DataOut : out std_logic_vector(15 downto 0)
      );

end CPU;

architecture Behavioral of CPU is

   COMPONENT ALU
	PORT(
		A : IN std_logic_vector(15 downto 0);
		D : IN std_logic_vector(15 downto 0);
		opcode : IN std_logic_vector(5 downto 0);          
		dout : OUT std_logic_vector(15 downto 0);
		zr : OUT std_logic;
		ng : OUT std_logic
		);
	END COMPONENT;
   
   COMPONENT RAM
  PORT (
    a : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
    d : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    clk : IN STD_LOGIC;
    we : IN STD_LOGIC;
    spo : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END COMPONENT;


   signal A, D, dout : std_logic_vector(15 downto 0);
   signal opcode : std_logic_vector(5 downto 0);
   signal zr, ng : std_logic;
   
begin

Inst_ALU: ALU PORT MAP(
   A => A,
   D => D,
   opcode => opcode,
   dout => dout,
   zr => zr,
   ng => ng
   );







end Behavioral;

