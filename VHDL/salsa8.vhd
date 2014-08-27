----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:25:14 12/01/2013 
-- Design Name: 
-- Module Name:    salsa8 - Behavioral 
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
use work.scrypt.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity salsa8 is
port ( Xin : in std_logic_vector(31 downto 0);
       clk : in std_logic; 
       rst : in std_logic
       
     );

end salsa8;

architecture Behavioral of salsa8 is
   type int_ram is array (0 to 15) of std_logic_vector(31 downto 0);
   type state is ( init1, init2, init3, init4,
                    a1, a2, a3, a4,
                    b1, b2, b3, b4,
                    c1, c2, c3, c4,
                    d1, d2, d3, d4,
                    
                    e1, e2, e3, e4,
                    f1, f2, f3, f4,
                    g1, g2, g3, g4,
                    h1, h2, h3, h4 );
                    
   signal curr_st, next_st : state;
   
   signal RAM : int_ram;
   
begin

   NextStateDecode: process(curr_st)

   begin

      next_st <= init1;
      
      case curr_st is
         
         when init1 => 
         
            next_st <= init2;
                     
         when init2 =>
         
            next_st <= init3;
         
         when init3 =>
         
            next_st <= init4;

         when init4 =>
         
            next_st <= a1;
         
         when a1 =>
         
         when a2 =>
         
         when a3 =>
         
         when a4 =>
         
         when b1 =>
         
         when b2 =>
         
         when b3 =>
         
         when b4 =>
         
         when c1 =>
         
         when c2 =>
         
         when c3 =>
         
         when c4 =>
         
         when d1 =>
         
         when d2 =>
         
         when d3 =>
         
         when d4 =>
         
         when e1 =>
         
         when e2 =>
         
         when e3 =>
         
         when e4 =>
         
         when f1 =>
         
         when f2 =>
         
         when f3 =>
         
         when f4 =>
         
         when g1 =>
         
         when g2 =>
         
         when g3 =>
         
         when g4 =>
         
         when h1 =>
         
         when h2 =>
         
         when h3 =>
         
         when h4 =>
         
         when others =>
         
         
      end case;
         
            
      
      
      
      
   end process;

   CreateCurrentState: process(clk, rst)
   begin
   
      if rst = '1' then
         curr_st <= init1;
      elsif rising_edge(clk) then
         curr_st <= next_st;
      end if;

   
   end process;
   
   ConditionRegisters: process(curr_st, clk)
   
   
   begin
   
      case curr_st is
         
         when init1 => 
                     
         when init2 =>
         
         when init3 =>

         when init4 =>
         
         when a1 =>
         
         when a2 =>
         
         when a3 =>
         
         when a4 =>
         
         when b1 =>
         
         when b2 =>
         
         when b3 =>
         
         when b4 =>
         
         when c1 =>
         
         when c2 =>
         
         when c3 =>
         
         when c4 =>
         
         when d1 =>
         
         when d2 =>
         
         when d3 =>
         
         when d4 =>
         
         when e1 =>
         
         when e2 =>
         
         when e3 =>
         
         when e4 =>
         
         when f1 =>
         
         when f2 =>
         
         when f3 =>
         
         when f4 =>
         
         when g1 =>
         
         when g2 =>
         
         when g3 =>
         
         when g4 =>
         
         when h1 =>
         
         when h2 =>
         
         when h3 =>
         
         when h4 =>
         
         when others =>
         
         
      end case;
   
   end process;
   


end Behavioral;

