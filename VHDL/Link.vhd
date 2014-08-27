----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:01:24 12/22/2013 
-- Design Name: 
-- Module Name:    Link - Behavioral 
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

entity Link is

generic ( addr_width : positive := 32;
          data_width : positive := 32;
           num_cells : positive := 1
        );
          
   Port (  in_address : in std_logic_vector(addr_width - 1 downto 0);
              in_data : in std_logic_vector(data_width - 1 downto 0);
                in_wr : in std_logic;
          
          out_address : out std_logic_vector(addr_width - 1 downto 0);
             out_data : out std_logic_vector(data_width - 1 downto 0);
               out_wr : out std_logic;
          
           my_address : out std_logic_vector(addr_width - 1 downto 0);
           my_in_data : in std_logic_vector(data_width - 1 downto 0);
          my_out_data : out std_logic_vector(data_width - 1 downto 0);
                my_wr : out std_logic
          
         );
      
end Link;

architecture Behavioral of Link is


begin

   process (in_address, in_data, in_wr) 
   
      variable u_in_address : unsigned (addr_width -1 downto 0);
      variable  u_num_cells : unsigned (data_width - 1 downto 0);
      variable   u_all_ones : unsigned (addr_width - 1 downto 0) := (others => '1');
      
   begin
   
   
      u_in_address := unsigned(in_address);
       u_num_cells := to_unsigned(num_cells, u_num_cells'length); 


      ------INIT MODE------
      if u_in_address = 0 then

            out_data <= std_logic_vector(unsigned(in_data) + 1);
         out_address <= (others => '0');
              out_wr <= '0';
         
               my_wr <= '0';
          my_address <= (others => '0');
         my_out_data <= (others => '0');

      ------QUERY MODE------        
      elsif u_in_address = 1 then
      
            out_data <= std_logic_vector(u_num_cells);
         out_address <= (others => '1');
              out_wr <= '0';
         
               my_wr <= '0';
          my_address <= (others => '0');
         my_out_data <= (others => '0');
         
         
      ------PASSTHROUGH MODE------
      elsif u_in_address = u_all_ones then
      
            out_data <= in_data;
         out_address <= (others => '1');
              out_wr <= '0';
         
               my_wr <= '0';
          my_address <= (others => '0');
         my_out_data <= (others => '0');
         
      
      ------ACCESS MODE------
      elsif u_in_address >= 2 and u_in_address <= (num_cells + 1) then
      
            out_data <= my_in_data;
         out_address <= (others => '1');
              out_wr <= '0';
         
               my_wr <= in_wr;
          my_address <= std_logic_vector(u_in_address - 2);
         my_out_data <= in_data;


      ------PASSDOWN MIDE------
      elsif u_in_address > (num_cells + 1) then
      
            out_data <= in_data;
         out_address <= std_logic_vector(unsigned(in_address) - (num_cells + 1));
              out_wr <= in_wr;
         
               my_wr <= '0';
          my_address <= (others => '0');
         my_out_data <= (others => '0');
         
      else
      
            out_data <= (others => '0');
         out_address <= (others => '0');
              out_wr <= '0';
         
               my_wr <= '0';
          my_address <= (others => '0');
         my_out_data <= (others => '0');
      
      end if;
      
 
   end process;


end Behavioral;

