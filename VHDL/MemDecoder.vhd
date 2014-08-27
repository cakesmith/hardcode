----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:32:17 11/25/2013 
-- Design Name: 
-- Module Name:    MemDecoder - Behavioral 
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

entity MemDecoder is
Port( clk    : in std_logic;
      addr : in std_logic_vector(15 downto 0);
      wr     : in std_logic;
      
      -- here will be the interface ports to various components
      --
      -- (RW) RAM             = 0x0000 to 0x3999 (16383)
      -- (W)  Screen          = 0x4000 to 0x52FF 
      --      Registers       = 0x5300 to 0x5FFF
            
            ------------ REGISTERS -----------
      --    (W) video registers = 0x5300 to 0x530C
      --
      --    ----------------------------------
      -- 
      -- (RW) Keyboard        = 0x6000 (24576)
      
      
      -- RAM
      RAM_Addr : out std_logic_vector(13 downto 0);
      RAM_wr   : out std_logic;
      
      -- Screen
      VR_addr : out std_logic_vector(12 downto 0);
      VR_wr   : out std_logic;
      
      H_Load_Frontporch : out std_logic;
      H_Load_SyncPulse : out std_logic;
		H_Load_BackPorch : out std_logic;
		H_Load_Display : out std_logic;
		H_Load_Advance : out std_logic;
		H_Load_SyncActiveHigh : out std_logic;
      
      V_Load_Frontporch : out std_logic;
      V_Load_SyncPulse : out std_logic;
		V_Load_BackPorch : out std_logic;
		V_Load_Display : out std_logic;
		V_Load_Advance : out std_logic;
		V_Load_SyncActiveHigh : out std_logic;
      
      KBD_Data : in std_logic_vector(15 downto 0);
      RAM_Data : in std_logic_vector(15 downto 0);
      
      dout : out std_logic_vector(15 downto 0)
      
   );
end MemDecoder;

architecture Behavioral of MemDecoder is
   
begin

process(addr, wr)
   variable u_addr : unsigned(addr'range);

begin

      RAM_addr <= (others => '0');
      VR_addr <= (others => '0');
      H_Load_Frontporch <= '0';
      H_Load_SyncPulse <= '0';
		H_Load_BackPorch <= '0';
		H_Load_Display <= '0';
		H_Load_Advance <= '0';
		H_Load_SyncActiveHigh <= '0';
      
      V_Load_Frontporch <= '0';
      V_Load_SyncPulse <= '0';
		V_Load_BackPorch <= '0';
		V_Load_Display <= '0';
		V_Load_Advance <= '0';
		V_Load_SyncActiveHigh <= '0';
   
  
      if u_addr < 16#4000# then
   
         RAM_addr <= addr(13 downto 0);
      
      elsif u_addr < 16#52FF# then
      
         VR_addr <= std_logic_vector(unsigned(addr(12 downto 0)) - to_unsigned(16384, VR_addr'length));
   
      elsif u_addr = 16#5300# then
      
         H_Load_Frontporch <= wr;
      
      elsif u_addr = 16#5301# then

         H_Load_SyncPulse <= wr;
      
      elsif u_addr = 16#5302# then
      
         H_Load_BackPorch <= wr;
      
      elsif u_addr = 16#5303# then
         
         H_Load_Display <= wr;
      
      elsif u_addr = 16#5304# then
      
         H_Load_Advance <= wr;
		
      elsif u_addr = 16#5305# then
      
         H_Load_SyncActiveHigh <= wr;
      
      elsif u_addr = 16#5306# then
      
         V_Load_Frontporch <= wr;
      
      elsif u_addr = 16#5307# then
      
         V_Load_SyncPulse <= wr;
         
      elsif u_addr = 16#5308# then
      
         V_Load_BackPorch <= wr;
         
      elsif u_addr = 16#5309# then
       
         V_Load_Display <= wr;
      
      elsif u_addr = 16#530A# then
      
         V_Load_Advance <= wr;
         
      elsif u_addr = 16#530B# then
      
         V_Load_SyncActiveHigh <= wr;
         
      end if;
   end process;
end Behavioral;

