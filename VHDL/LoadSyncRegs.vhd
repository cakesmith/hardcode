----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:40:44 11/20/2013 
-- Design Name: 
-- Module Name:    Load_Hsync_Regs - Behavioral 
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

entity LoadSyncRegs is
Port (
   clk : in std_logic;
   rst : in std_logic;
   
   dout : out std_logic_vector(15 downto 0) := (others => '0');
   
   Load_Display_H : out std_logic := '0';
   Load_SyncPulse_H : out std_logic := '0';
   Load_FrontPorch_H : out std_logic := '0';
   Load_BackPorch_H : out std_logic := '0';
   Load_HsyncActiveHigh : out std_logic := '0';
   
   Load_Display_V : out std_logic := '0';
   Load_SyncPulse_V : out std_logic := '0';
   Load_FrontPorch_V : out std_logic := '0';
   Load_BackPorch_V : out std_logic := '0';
   Load_VsyncActiveHigh : out std_logic := '0';
   
   Load_Advance_H : out std_logic := '0';
   Load_Advance_V : out std_logic := '0';
   
   en : out std_logic := '0'

);
   
end LoadSyncRegs;

architecture Behavioral of LoadSyncRegs is

   signal countdown : integer := 11;
   

begin

   LoadRegs: process(clk, rst)
   
      variable i,j : integer := 0;
      
   begin

      if rst = '1' then
         i := 0;
         j := 0;
         countdown <= 11;
         dout <= (others => '0');
         
      elsif rising_edge(clk) then
         
         case countdown is
         
            when 11 =>
               Load_Advance_H <= '1';
               dout <= std_logic_vector(to_unsigned(advance, dout'length));
               countdown <= countdown - 1;
               en <= '0';
         
            when 10 =>
               Load_Advance_H <= '0';
               Load_SyncPulse_H <= '1';
               dout <= std_logic_vector(Default_SyncPulse_H);
               countdown <= countdown - 1;
               en <= '0';
            when 9 => 
            Load_SyncPulse_H <= '0';
               Load_Display_H <= '1';
               dout <= std_logic_vector(Default_Display_H);
               countdown <= countdown - 1;
               en <= '0';
            when 8 =>
               Load_Display_H <= '0';

               Load_FrontPorch_H <= '1';
               dout <= std_logic_vector(Default_FrontPorch_H);
               countdown <= countdown - 1;
               en <= '0';
            when 7 => 
               Load_FrontPorch_H <= '0';

               Load_BackPorch_H <= '1';
               dout <= std_logic_vector(Default_BackPorch_H);
               countdown <= countdown - 1;
               en <= '0';
            when 6 => 
               Load_BackPorch_H <= '0';

               Load_HsyncActiveHigh <= '1';
               dout(dout'high downto 1) <= (others => '0');
               dout(0) <= Default_HSAH;
               countdown <= countdown - 1;       
               en <= '0';
            when 5 => 
               Load_HsyncActiveHigh <= '0';

               Load_Display_V <= '1';
               dout <= std_logic_vector(Default_Display_V);
               countdown <= countdown - 1;       
               en <= '0';
            when 4 =>
               Load_Display_V <= '0';

               Load_SyncPulse_V <= '1';
               dout <= std_logic_vector(Default_SyncPulse_V);
               countdown <= countdown - 1;       
               en <= '0';
            when 3 =>
               Load_SyncPulse_V <= '0';

               Load_BackPorch_V <= '1';
               dout <= std_logic_vector(Default_BackPorch_V);
               countdown <= countdown - 1;       
               en <= '0';
            when 2 => 
               Load_BackPorch_V <= '0';

               Load_FrontPorch_V <= '1';
               dout <= std_logic_vector(Default_FrontPorch_V);
               countdown <= countdown - 1;
               en <= '0';
            when 1 =>
               Load_FrontPorch_V <= '0';

               Load_VsyncActiveHigh <= '1';
               dout(dout'high downto 1) <= (others => '0');
               dout(0) <= Default_VSAH;
               countdown <= countdown - 1;
               en <= '0';
            when others =>
            
               Load_VsyncActiveHigh <= '0';
               en <= '1';
         
         end case;
      
      end if;
      
   end process;
      
end Behavioral;

