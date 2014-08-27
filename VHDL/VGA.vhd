----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:39:48 11/20/2013 
-- Design Name: 
-- Module Name:    VGA - Behavioral 
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

entity VGA is

Port (   CLK : in std_logic;
         I_RESET : in std_logic; 

         O_HSYNC : out STD_LOGIC;
         O_VSYNC : out STD_LOGIC;
          
         O_VIDEO_R : out STD_LOGIC_VECTOR(3 downto 0);
         O_VIDEO_G : out STD_LOGIC_VECTOR(3 downto 0);
         O_VIDEO_B : out STD_LOGIC_VECTOR(3 downto 0)
      );

end VGA;

architecture Behavioral of VGA is

	COMPONENT LoadSyncRegs
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;  
      en : out std_logic;
		dout : OUT std_logic_vector(15 downto 0);
		Load_Display_H : OUT std_logic;
		Load_SyncPulse_H : OUT std_logic;
		Load_FrontPorch_H : OUT std_logic;
		Load_BackPorch_H : OUT std_logic;
		Load_HsyncActiveHigh : OUT std_logic;
		Load_Display_V : OUT std_logic;
		Load_SyncPulse_V : OUT std_logic;
		Load_FrontPorch_V : OUT std_logic;
		Load_BackPorch_V : OUT std_logic;
		Load_VsyncActiveHigh : OUT std_logic;
      Load_Advance_H : out std_logic;
      Load_Advance_V : out std_logic
		);
	END COMPONENT;
   
   

	COMPONENT PixelDecoder
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		hcount : IN std_logic_vector(15 downto 0);
		vcount : IN std_logic_vector(15 downto 0);
		GlyphROM_data : IN std_logic_vector(7 downto 0);
		VideoRAM_data : IN std_logic_vector(15 downto 0);          
		GlyphROM_addr : OUT std_logic_vector(10 downto 0);
		VideoRAM_addr : OUT std_logic_vector(12 downto 0);
		Pixel : OUT RGB
		);
	END COMPONENT;
   
   COMPONENT SyncGenerator
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		en : IN std_logic;
		din : IN std_logic_vector(15 downto 0);
		Load_FrontPorch : IN std_logic;
		Load_SyncPulse : IN std_logic;
		Load_BackPorch : IN std_logic;
		Load_Display : IN std_logic;
		Load_SyncActiveHigh : IN std_logic; 
      Load_Advance : in std_logic;
		sync : OUT std_logic;
		bright : OUT std_logic;
		done : OUT std_logic;
      display_count : out std_logic_vector(15 downto 0)
		);
	END COMPONENT;

   COMPONENT GlyphROM
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END COMPONENT;	
   COMPONENT PixelClockGenerator
	PORT(
		CLKIN_IN : IN std_logic;
		RST_IN : IN std_logic;          
		CLKFX_OUT : OUT std_logic;
		CLKIN_IBUFG_OUT : OUT std_logic;
		CLK0_OUT : OUT std_logic
		);
	END COMPONENT;
   
   COMPONENT VideoRAM
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    clkb : IN STD_LOGIC;
    addrb : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END COMPONENT;

   signal wea : std_logic_vector(0 downto 0) := (others => '0');
   signal addra : std_logic_vector(12 downto 0) := (others => '0');
   signal dina : std_logic_vector(15 downto 0) := (others => '0');
   signal PixelClock : std_logic;
   signal hbright, hdone, h_en : std_logic;
   signal vbright, vdone, v_en : std_logic;
   signal hcount, vcount : std_logic_vector(15 downto 0);
	signal	Load_Display_H, 
            Load_SyncPulse_H, 
            Load_FrontPorch_H, 
            Load_BackPorch_H, 
            Load_HsyncActiveHigh, 
            Load_Advance_H,
            Load_Display_V, 
            Load_SyncPulse_V, 
            Load_FrontPorch_V, 
            Load_BackPorch_V,
            Load_VsyncActiveHigh,
            Load_Advance_V : std_logic;            
   signal dataBus : std_logic_vector(15 downto 0);
   signal VideoRAM_address : std_logic_vector(12 downto 0);
   signal VideoRAM_data : std_logic_vector(15 downto 0);
   signal GlyphROM_address : std_logic_vector(10 downto 0);
   signal GlyphROM_data : std_logic_vector(7 downto 0);
   signal Pixel : rgb;


begin



   
	Inst_LoadSyncRegs: LoadSyncRegs PORT MAP(
		clk => PixelClock,
		rst => I_RESET,
      en => h_en,
		dout => dataBus,
		Load_Display_H => Load_Display_H,
		Load_SyncPulse_H => Load_SyncPulse_H,
		Load_FrontPorch_H => Load_FrontPorch_H,
		Load_BackPorch_H => Load_BackPorch_H,
		Load_HsyncActiveHigh => Load_HsyncActiveHigh,
      Load_Advance_H => Load_Advance_H,
		Load_Display_V => Load_Display_V,
		Load_SyncPulse_V => Load_SyncPulse_V,
		Load_FrontPorch_V => Load_FrontPorch_V,
		Load_BackPorch_V => Load_BackPorch_V,
		Load_VsyncActiveHigh => Load_VsyncActiveHigh,
      Load_Advance_V => Load_Advance_V
	);

	Inst_PixelDecoder: PixelDecoder PORT MAP(
		clk => PixelClock,
		rst => I_RESET,
		hcount => hcount,
		vcount => vcount,
		GlyphROM_addr => GlyphROM_address,
		GlyphROM_data => GlyphROM_data,
		VideoRAM_addr => VideoRAM_address,
		VideoRAM_data => VideoRAM_data,
		Pixel => Pixel
	);

	Horizontal_SyncGenerator: SyncGenerator PORT MAP(
		clk => PixelClock,
		rst => I_RESET,
		en => h_en,
		din => dataBus,
		Load_FrontPorch => Load_FrontPorch_H,
		Load_SyncPulse => Load_SyncPulse_H,
		Load_BackPorch => Load_BackPorch_H,
		Load_Display => Load_Display_H,
		Load_SyncActiveHigh => Load_HSyncActiveHigh,
      Load_Advance => Load_Advance_H,
		sync => O_HSYNC,
		bright => hbright,
		done => hdone,
      display_count => hcount
	);
   
   Vertical_SyncGenerator: SyncGenerator PORT MAP(
		clk => PixelClock,
		rst => I_RESET,
		en => hdone,
		din => dataBus,
		Load_FrontPorch => Load_FrontPorch_V,
		Load_SyncPulse => Load_SyncPulse_V,
		Load_BackPorch => Load_BackPorch_V,
		Load_Display => Load_Display_V,
		Load_SyncActiveHigh => Load_VSyncActiveHigh,
      Load_Advance => Load_Advance_V,
		sync => O_VSYNC,
		bright => vbright,
		done => vdone,
      display_count => vcount
	);

   Inst_GlyphROM : GlyphROM  PORT MAP (
    clka => PixelClock,
    addra => GlyphROM_address,
    douta => GlyphROM_data
  );

	Inst_PixelClockGenerator: PixelClockGenerator PORT MAP(
		CLKIN_IN => clk,
		RST_IN => I_RESET,
		CLKFX_OUT => PixelClock,
		CLKIN_IBUFG_OUT => open,
		CLK0_OUT => open
	);
   
   

   Inst_VideoRAM : VideoRAM PORT MAP (
    clka => PixelClock,
    wea => wea,
    addra => addra,
    dina => dina,
    clkb => PixelClock,
    addrb => VideoRAM_address,
    doutb => VideoRAM_data
  );
  
ShowPixel: process(PixelClock, hbright, vbright)
   type fifo is array(0 to advance - 1) of std_logic;
   variable hbright_fifo : fifo;
   
begin

   if rising_edge(PixelClock) then

      for i in hbright_fifo'range loop
         if i > 0 then
            hbright_fifo(i - 1) := hbright_fifo(i);
         end if;
      end loop;
      
      hbright_fifo(hbright_fifo'high) := hbright;
      
      if hbright_fifo(0) = '1' and vbright = '1' then
         O_VIDEO_R <= Pixel.Red;
         O_VIDEO_B <= Pixel.Blue;
         O_VIDEO_G <= Pixel.Green;
      else
         O_VIDEO_R <= Black.Red;
         O_VIDEO_G <= Black.Green;
         O_VIDEO_B <= Black.Blue;
      end if;
   
   end if;
   
end process;


end Behavioral;

