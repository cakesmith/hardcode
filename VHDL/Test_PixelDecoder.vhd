--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:13:36 11/17/2013
-- Design Name:   
-- Module Name:   /home/nick/Hardcode/Test_PixelDecoder.vhd
-- Project Name:  Hardcode
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PixelDecoder
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.video_types.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY Test_PixelDecoder IS
END Test_PixelDecoder;
 
ARCHITECTURE behavior OF Test_PixelDecoder IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PixelDecoder
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         hcount : IN  std_logic_vector(15 downto 0);
         vcount : IN  std_logic_vector(15 downto 0);
         GlyphROM_addr : OUT  std_logic_vector(10 downto 0);
         GlyphROM_data : IN  std_logic_vector(7 downto 0);
         VideoRAM_addr : OUT  std_logic_vector(12 downto 0);
         VideoRAM_data : IN  std_logic_vector(15 downto 0);
         Pixel : OUT  RGB
        );
    END COMPONENT;
    
    COMPONENT GlyphROM
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
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
    
   signal wea : STD_LOGIC_VECTOR(0 DOWNTO 0) := (others => '0');
   signal addra : STD_LOGIC_VECTOR(12 DOWNTO 0) := (others => '0');
   signal dina : STD_LOGIC_VECTOR(15 DOWNTO 0) := (others => '0');
    
   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal hcount : Unsigned(15 downto 0) := (others => '0');
   signal vcount : Unsigned(15 downto 0) := (others => '0');
   signal GlyphROM_data : std_logic_vector(7 downto 0) := (others => '0');
   signal VideoRAM_data : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal GlyphROM_addr : std_logic_vector(10 downto 0);
   signal VideoRAM_addr : std_logic_vector(12 downto 0);
   signal Pixel : RGB;
   


   -- Clock period definitions
   constant clk_period : time := 40 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PixelDecoder PORT MAP (
          clk => clk,
          rst => rst,
          hcount => std_logic_vector(hcount),
          vcount => std_logic_vector(vcount),
          GlyphROM_addr => GlyphROM_addr,
          GlyphROM_data => GlyphROM_data,
          VideoRAM_addr => VideoRAM_addr,
          VideoRAM_data => VideoRAM_data,
          Pixel => Pixel
        );
        
        Glyphs : GlyphROM
  PORT MAP (
    clka => clk,
    addra => GlyphROM_addr,
    douta => GlyphROM_data
  );
        
        
        VRAM : VideoRAM
  PORT MAP (
    clka => clk,
    wea => wea,
    addra => addra,
    dina => dina,
    clkb => clk,
    addrb => VideoRAM_addr,
    doutb => VideoRAM_data
  );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
   

 

   -- Stimulus process
   stim_proc: process
   
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      
      rst <= '1';

      wait for clk_period*10;

      rst <= '0';
      
      -- setup time
      
      wait for clk_period * 2;
      
      
      loop
         
         
         
         if hcount < C_PIXELS-1 then
            hcount <= hcount + 1;
            
         else 
            hcount <= (others => '0');
            wait for clk_period*(96+16+48);
            
            if vcount < C_LINES-1 then
            vcount <= vcount + 1;
            
            else
               vcount <= (others => '0'); 
               wait for clk_period*(1600+8000+23200);
            
               
            end if;
         
         end if;
         wait for clk_period;
		end loop;
		
      
      -- insert stimulus here 

      wait;
   end process;

END;
