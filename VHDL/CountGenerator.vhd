----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:20:00 11/20/2013 
-- Design Name: 
-- Module Name:    CountGenerator - Behavioral 
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

entity CountGenerator is
    Port ( hbright : in  STD_LOGIC;
           vbright : in  STD_LOGIC;
           hcount : out  STD_LOGIC_VECTOR(15 downto 0);
           vcount : out  STD_LOGIC_VECTOR(15 downto 0);
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           din : in  STD_LOGIC_VECTOR (15 downto 0);
           Load_Display_V : in  STD_LOGIC;
           Load_Display_H : in STD_LOGIC);
end CountGenerator;

architecture Behavioral of CountGenerator is

   signal Display_V : Unsigned(15 downto 0) := (others => '0');
   signal Display_H : Unsigned(15 downto 0) := (others => '0');
   
begin

LoadRegs: process ( clk, rst , Load_Display_V)
begin
   if rst = '1' then
      Display_V <= (others => '0');
   elsif rising_edge(clk) then
      if Load_Display_V = '1' then
         Display_V <= Unsigned(din);
      end if;
      if Load_Display_H = '1' then
         Display_H <= Unsigned(din);
      end if;
   end if;
end process;


Count: process (clk, rst, hbright, vbright)
   
   
   variable hc, vc : Unsigned(15 downto 0) := (others => '0');

begin

   if rst = '1' then
      hcount <= (others => '0');
      vcount <= (others => '0');
      hc := (others => '0');
      vc := (others => '0');
      
   elsif  rising_edge(clk) then

      if vbright = '1' then
   
        if hc >= Display_H - 1 then
            hc := (others => '0');
  
            
            if vc >= Display_V - 1 then
               vc := (others => '0');
            else
               vc := vc + 1;
            end if;

        elsif hbright = '1' then
 
            hc := hc + 1;
  
        else
            hc := (others => '0');
        end if;
         
      


      elsif vbright = '0' then
         hc := (others => '0');
         vc := (others => '0');
      end if;
      
      end if;
      
      hcount <= std_logic_vector(hc);
      vcount <= std_logic_vector(vc);
end process;



end Behavioral;

