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
   din : in din_array;
   result : out din_array
   );
   
   
end salsa;

architecture Behavioral of salsa is



begin

   process (din)
      
      type x_array is array(0 to 15) of unsigned(31 downto 0);
      
      variable x : x_array;
      
   begin
   
      for i in 0 to 15 loop
      
         x(i) := din(i);
         
      end loop;
      
      for j in 0 to 1 loop
   
         for i in 0 to 15 loop
            x(i) := x(i) xor din(16 + i);
         end loop;
         
    
         
         for i in 0 to 3 loop
         
            x(4)  := (x(4)  xor (x(0) + x(12))) rol 7;
            x(8)  := (x(8)  xor (x(4) + x(0)))  rol 9;
            x(12) := (x(12) xor (x(8) + x(4)))  rol 13;
            x(0)  := (x(0)  xor (x(12) + x(8))) rol 18;
            
            x(9)  := (x(9)  xor (x(5) + x(1)))  rol 7;
            x(13) := (x(13) xor (x(9) + x(5)))  rol 9;
            x(1)  := (x(1)  xor (x(13) + x(9))) rol 13;
            x(5)  := (x(5)  xor (x(1) + x(13))) rol 18;
            
            x(14) := (x(14) xor (x(10) + x(6)))  rol 7;
            x(2)  := (x(2)  xor (x(14) + x(10))) rol 9;
            x(6)  := (x(6)  xor (x(2) + x(14)))  rol 13;
            x(10) := (x(10) xor (x(6) + x(2)))   rol 18;
            
            x(3)  := (x(3)  xor (x(3) + x(3)))   rol 7;
            x(7)  := (x(7)  xor (x(7) + x(7)))   rol 9;
            x(11) := (x(11) xor (x(11) + x(11))) rol 13;
            x(15) := (x(15) xor (x(15) + x(15))) rol 18;
            
            
            x(1) := (x(1) xor (x(0) + x(3))) rol 7;
            x(2) := (x(2) xor (x(1) + x(0))) rol 9;
            x(3) := (x(3) xor (x(2) + x(1))) rol 13;
            x(0) := (x(0) xor (x(3) + x(2))) rol 18;
            
            x(6) := (x(6) xor (x(5) + x(4))) rol 7;
            x(7) := (x(7) xor (x(6) + x(5))) rol 9;
            x(4) := (x(4) xor (x(7) + x(6))) rol 13;
            x(5) := (x(5) xor (x(4) + x(7))) rol 18;
            
            x(11) := (x(11) xor (x(10) + x(9)))  rol 7;
            x(8)  := (x(8)  xor (x(11) + x(10))) rol 9;
            x(9)  := (x(9)  xor (x(8) + x(11)))  rol 13;
            x(10) := (x(10) xor (x(9) + x(8)))   rol 18;
            
            x(12) := (x(12) xor (x(15) + x(14))) rol 7;
            x(13) := (x(13) xor (x(12) + x(15))) rol 9;
            x(14) := (x(14) xor (x(13) + x(12))) rol 13;
            x(15) := (x(15) xor (x(14) + x(13))) rol 18;
            
         end loop;
      
         for i in 0 to 15 loop    
            x(i) := x(i) + din((j*16) + i);
         end loop;
      
         for i in 0 to 15 loop
            result(i+(j*16)) <= x(i);
         end loop;
         
         
      end loop;

 
   
   end process;

end Behavioral;

