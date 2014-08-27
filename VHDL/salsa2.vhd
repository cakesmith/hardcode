----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:31:03 12/06/2013 
-- Design Name: 
-- Module Name:    salsa - Behavioral 
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
use work.scrypt_types.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity salsa is

port (
   clk : in std_logic;
   din : in din_array;
   result : out din_array
   );
   
   
end salsa;

architecture Behavioral of salsa is 

   subtype pipeline_type is integer range 0 to 68;
   signal stage : pipeline_type := 0;

begin

   process (din, clk)
      
      type x_array is array(0 to 15) of unsigned(31 downto 0);
      
      variable x : x_array;
      
   begin
   
   if rising_edge(clk) then
   
      for stage in 0 to 68 loop
      
         case stage is
         
         when 0 =>

         for i in 0 to 15 loop
         
            x(i) := din(i);
            
         end loop;
         
         when 1 | 35 =>
         
      
            for i in 0 to 15 loop
               x(i) := x(i) xor din(16 + i);
            end loop;
            
            
         when 2 | 10 | 18 | 26 | 36 | 44 | 52 | 60 =>
            
               x(4)  := (x(4)  xor (x(0) + x(12))) rol 7;
               x(8)  := (x(8)  xor (x(4) + x(0)))  rol 9;
               x(12) := (x(12) xor (x(8) + x(4)))  rol 13;
               x(0)  := (x(0)  xor (x(12) + x(8))) rol 18;
               
        when 3 | 11 | 19 | 27 | 37 | 45 | 53 | 61 =>
               
               x(9)  := (x(9)  xor (x(5) + x(1)))  rol 7;
               x(13) := (x(13) xor (x(9) + x(5)))  rol 9;
               x(1)  := (x(1)  xor (x(13) + x(9))) rol 13;
               x(5)  := (x(5)  xor (x(1) + x(13))) rol 18;
               
        when 4 | 12 | 20 | 28 | 38 | 46 | 54 | 62 =>
        
               x(14) := (x(14) xor (x(10) + x(6)))  rol 7;
               x(2)  := (x(2)  xor (x(14) + x(10))) rol 9;
               x(6)  := (x(6)  xor (x(2) + x(14)))  rol 13;
               x(10) := (x(10) xor (x(6) + x(2)))   rol 18;
               
        when 5 | 13 | 21 | 29 | 39 | 47 | 55 | 63 =>
        
               x(3)  := (x(3)  xor (x(3) + x(3)))   rol 7;
               x(7)  := (x(7)  xor (x(7) + x(7)))   rol 9;
               x(11) := (x(11) xor (x(11) + x(11))) rol 13;
               x(15) := (x(15) xor (x(15) + x(15))) rol 18;
        
        when 6 | 14 | 22 | 30 | 40 | 48 | 56 | 64 =>       
               
               x(1) := (x(1) xor (x(0) + x(3))) rol 7;
               x(2) := (x(2) xor (x(1) + x(0))) rol 9;
               x(3) := (x(3) xor (x(2) + x(1))) rol 13;
               x(0) := (x(0) xor (x(3) + x(2))) rol 18;
        
        when 7 | 15 | 23 | 31 | 41 | 49 | 57 | 65 =>
               
               x(6) := (x(6) xor (x(5) + x(4))) rol 7;
               x(7) := (x(7) xor (x(6) + x(5))) rol 9;
               x(4) := (x(4) xor (x(7) + x(6))) rol 13;
               x(5) := (x(5) xor (x(4) + x(7))) rol 18;
               
        when 8 | 16 | 24 | 32 | 42 | 50 | 58 | 66 =>
               
               x(11) := (x(11) xor (x(10) + x(9)))  rol 7;
               x(8)  := (x(8)  xor (x(11) + x(10))) rol 9;
               x(9)  := (x(9)  xor (x(8) + x(11)))  rol 13;
               x(10) := (x(10) xor (x(9) + x(8)))   rol 18;
               
        when 9 | 17 | 25 | 33 | 43 | 51 | 59 | 67 =>
        
        
               x(12) := (x(12) xor (x(15) + x(14))) rol 7;
               x(13) := (x(13) xor (x(12) + x(15))) rol 9;
               x(14) := (x(14) xor (x(13) + x(12))) rol 13;
               x(15) := (x(15) xor (x(14) + x(13))) rol 18;
               
         
        when 34 =>

         
         
            for i in 0 to 15 loop    
               x(i) := x(i) + din(i);
            end loop;
         
            for i in 0 to 15 loop
               result(i) <= x(i);
            end loop;
            
        when 68 =>
        
           for i in 0 to 15 loop    
               x(i) := x(i) + din(i);
            end loop;
         
            for i in 0 to 15 loop
               result(16 + i) <= x(i);
            end loop;

        end case;
     
     end loop;

   end if;
   
   end process;

end Behavioral;

