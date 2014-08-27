----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Nick LaRosa
-- 
-- Create Date:    14:36:52 11/25/2013 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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
--"A+D" : "000010",
--"A-D" : "000111",
--"D-A" : "010011",
--"A&D" : "000000",
--"A|D" : "010101", 
--"A<D" : "011000",
--"A=D" : "011001",
--"A>D" : "011010"

entity ALU is

Generic ( data_width : positive := 16 );

Port ( A : in std_logic_vector(data_width downto 0);
       D : in std_logic_vector(data_width downto 0);
  opcode : in std_logic_vector(5 downto 0);
  
    dout : out std_logic_vector(data_width downto 0);
      zr : out std_logic;
      ng : out std_logic

      );


end ALU;

architecture Behavioral of ALU is

begin

process(A, D, opcode)

   variable result : Signed(dout'range) := (others => '0');
   
begin


   case opcode is
   
      when "101010" =>
         result := (others => '0'); 
      when "111111" =>
         result := to_signed(1, result'length);
      when "111010" =>
         result := to_signed(-1, result'length);
      when "001100" =>
         result := signed(D);
      when "110000" =>
         result := signed(A);
      when "001101" =>
         result := not signed(D);
      when "110001" =>
         result := not signed(A);
      when "001111" =>
         result := 0 - signed(D);
      when "110011" =>
         result := 0 - signed(A);
      when "011111" =>
         result := signed(D) + 1;
      when "110111" =>
         result := signed(A) + 1;
      when "001110" =>
         result := signed(D) - 1;
      when "110010" =>
         result := signed(A) - 1;
      when "000010" =>
         result := signed(D) + signed(A);
      when "010011" =>
         result := signed(D) - signed(A);
      when "000111" =>
         result := signed(A) - signed(D);
      when "000000" =>
         result := signed(D) and signed(A);
      when "010101" =>
         result := signed(D) or signed(A);
      when "011000" =>
      
         if signed(A) < signed(D) then
            result := (others => '1');
         else
            result := (others => '0');
         end if;
         
      when "011001" =>
      
         if signed(A) = signed(D) then
            result := (others => '1');
         else
            result := (others => '0');
         end if;
         
      when "011010" =>
      
         if signed(A) > signed(D) then
            result := (others => '1');
         else
            result := (others => '0');
         end if;
         
            
      when others =>
         result := (others => '0');
   end case;
   
   if result < 0 then
      zr <= '0';
      ng <= '1';
   elsif result = 0 then
      zr <= '1';
      ng <= '0';
   else
      zr <= '0';
      ng <= '0';
   end if;
   
   dout <= std_logic_vector(result);
   
   

end process;


end Behavioral;

