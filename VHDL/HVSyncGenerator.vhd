----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:37:25 11/15/2013 
-- Design Name: 
-- Module Name:    HVSyncGenerator - Behavioral 
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

entity HVSyncGenerator is
Port (
       -------INPUTS---------
       clk : in std_logic;
       rst : in std_logic;
       en  : in std_logic;
       
       din : in std_logic_vector(15 downto 0);
       
       Load_VerticalFrontPorch     : in std_logic;
       Load_VerticalSyncPulse      : in std_logic;
       Load_VerticalBackPorch      : in std_logic;
       Load_VerticalDisplay        : in std_logic;
       
       Load_HorizontalFrontPorch   : in std_logic;
       Load_HorizontalSyncPulse    : in std_logic;
       Load_HorizontalBackPorch    : in std_logic;
       Load_HorizontalDisplay      : in std_logic;
       
       
       --------OUTPUTS--------
       hsync  : out std_logic;
       hcount : out std_logic_vector(15 downto 0) := (others => '0');
       
       vsync  : out std_logic;
       vcount : out std_logic_vector(15 downto 0) := (others => '0');
       
       bright : out std_logic
       
       
);


end HVSyncGenerator;

architecture Behavioral of HVSyncGenerator is

COMPONENT SyncGenerator
Port (
       -------INPUTS---------
       clk : in std_logic;
       rst : in std_logic;
        en : in std_logic;
       
       din : in std_logic_vector(15 downto 0);
       
       Load_FrontPorch : in std_logic;
       Load_SyncPulse  : in std_logic;
       Load_BackPorch  : in std_logic;
       Load_Display    : in std_logic;
       
       
       --------OUTPUTS--------
       sync   : out std_logic;
       bright : out std_logic;
       done   : out std_logic;
       count  : out std_logic_vector(15 downto 0) := (others => '0')
);

end component;

   signal h_sync, v_sync, h_bright, v_bright, h_done, v_done : std_logic := '0';

begin

HsyncGenerator: SyncGenerator 
PORT MAP (     clk => clk,
               rst => rst,
                en => en,
               din => din,
   Load_FrontPorch => Load_HorizontalFrontPorch,
    Load_SyncPulse => Load_HorizontalSyncPulse,
    Load_BackPorch => Load_HorizontalBackPorch,
      Load_Display => Load_HorizontalDisplay,
              sync => hsync,
            bright => h_bright,
              done => h_done,
             count => hcount
   );
   
VSyncGenerator: SyncGenerator
PORT MAP (     clk => clk,
               rst => rst,
                en => h_done,
               din => din,
   Load_FrontPorch => Load_VerticalFrontPorch,
    Load_SyncPulse => Load_VerticalSyncPulse,
    Load_BackPorch => Load_VerticalBackPorch,
      Load_Display => Load_VerticalDisplay,
              sync => vsync,
            bright => v_bright,
              done => v_done,
             count => vcount
   );
   
   
   bright <= h_bright and v_bright;
   
   
   
   

end Behavioral;

