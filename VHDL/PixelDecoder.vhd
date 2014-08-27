----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:52:01 11/16/2013 
-- Design Name: 
-- Module Name:    PixelDecoder - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PixelDecoder is
PORT ( clk : in std_logic;
       rst : in std_logic;

       hcount : in std_logic_vector(15 downto 0);
       vcount : in std_logic_vector(15 downto 0);
       
       GlyphROM_addr : OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
       GlyphROM_data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
       
       VideoRAM_addr : OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
       VideoRAM_data : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
       
       Pixel : out RGB
       
     );


end PixelDecoder;

architecture Behavioral of PixelDecoder is


   subtype px_type is natural range 0 to 7;
   type px_fifo is array (1 downto 0) of px_type;
   signal px : px_fifo;

   subtype glyphcolor is natural range 0 to 15;
   signal fg, bg : glyphcolor;
   

begin


   process (hcount, vcount, clk)
     
      variable hc : Unsigned(hcount'high - 3 downto 0);
      variable vc : Unsigned(vcount'high - 3 downto 0);
        
      
   begin
      
      hc := unsigned(hcount(hcount'high downto 3));

      vc := Unsigned(vcount(vcount'high downto 3));      
      vc := resize(vc * "1010000", vc'length);
      
      VideoRAM_addr <= std_logic_vector(vc + hc);
      
      if rising_edge(clk) then

         for i in px'range loop
            if i > 0 then
               px(i - 1) <= px(i);
            end if;
         end loop;
         px(px'high) <= to_integer(unsigned(hcount(2 downto 0)));

      end if;
      
   end process;
   
   process(VideoRAM_data, clk)
   begin
   
      GlyphROM_addr(10 downto 3) <= VideoRAM_data(15 downto 8);
      GlyphROM_addr(2 downto 0) <= vcount(2 downto 0);
      
      if rising_edge(clk) then
      
         fg <= to_integer(unsigned(VideoRAM_data(7 downto 4)));
         bg <= to_integer(unsigned(VideoRAM_data(3 downto 0)));
  
      end if;
   end process;
 
 process(clk)
   variable reverse_data : std_logic_vector(GlyphROM_data'range);
   
 begin

   reverse_data := reverse_vector(GlyphROM_data);
 
    if rising_edge(clk) then
      if reverse_data(px(0)) = '1' then
         Pixel <= VGAPalette(fg);
      else
         Pixel <= VGAPalette(bg);
      end if;
    end if;
 end process;



end Behavioral;