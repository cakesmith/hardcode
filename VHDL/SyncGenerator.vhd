----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:46:15 11/14/2013 
-- Design Name: 
-- Module Name:    SyncGenerator - Behavioral 
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
 
entity SyncGenerator is

Port (
       -------INPUTS---------
       clk : in std_logic;
       rst : in std_logic;
       en : in std_logic;
       
       din : in std_logic_vector(15 downto 0);
       
       Load_FrontPorch  : in std_logic;
       Load_SyncPulse   : in std_logic;
       Load_BackPorch   : in std_logic;
       Load_Display     : in std_logic;
       Load_Advance     : in std_logic;
       Load_SyncActiveHigh : in std_logic;

       
       --------OUTPUTS--------
       sync  : out std_logic;
       bright : out std_logic;
       done : out std_logic;
       display_count : out std_logic_vector(15 downto 0)
       
);


       
end SyncGenerator;

architecture Behavioral of SyncGenerator is

   Type SyncGenStates is (  
                            ST_INIT,
                            ST_DISPLAY,              
                            ST_FRONTPORCH, 
                            ST_SYNCPULSE,
                            ST_BACKPORCH
                            
                         );
   
   signal curr_st, next_st  : SyncGenStates;
   
   signal FrontPorch : Unsigned(15 downto 0) := (others => '0');
   signal Display    : Unsigned(15 downto 0) := (others => '0');
   signal BackPorch  : Unsigned(15 downto 0) := (others => '0');
   signal SyncPulse  : Unsigned(15 downto 0) := (others => '0');
   
   signal Advance    : Unsigned(15 downto 0)  := (others => '0');
   
   signal SyncActiveHigh : std_logic := '1';

   signal counter : Unsigned(15 downto 0) := (others => '0');
 
begin


LoadRegs: process(clk, 
                  Load_Display, 
                  Load_FrontPorch, 
                  Load_SyncPulse, 
                  Load_BackPorch,
                  Load_SyncActiveHigh,
                  Load_Advance)
begin
      
   if rising_edge(clk) then 
      
      if Load_FrontPorch = '1' then
         FrontPorch <= Unsigned(din);
      end if;
      
      if Load_SyncPulse = '1' then
         SyncPulse <= Unsigned(din);
      end if;
      
      if Load_BackPorch = '1' then
         BackPorch <= Unsigned(din);
      end if;
      
      if Load_Display = '1' then
         Display <= Unsigned(din);
      end if;
   
      
      if Load_SyncActiveHigh = '1' then
         SyncActiveHigh <= din(0);
      end if;
      
      if Load_Advance = '1' then
         Advance <= Unsigned(din);
      end if;
               
   -- some sanity checks on our advance register
   if BackPorch > 0 then
      if Advance > BackPorch - 1 then
         Advance <= BackPorch - to_unsigned(1, Advance'length);
      end if;
   end if;
      
      
   end if;
   

end process;

NextStateDecode: process(curr_st, 
                         Load_FrontPorch, 
                         Load_Display, 
                         Load_BackPorch, 
                         Load_SyncPulse,
                         Load_SyncActiveHigh,
                         Load_Advance,
                         counter)
                         
   variable LoadRegs : std_logic := '0';
   
   
begin

   LoadRegs := Load_FrontPorch
            or Load_Display 
            or Load_BackPorch 
            or Load_SyncPulse
            or Load_SyncActiveHigh
            or Load_Advance;
   
   next_st <= ST_INIT;     -- default next state condition

   case curr_st is
   
      when ST_INIT =>
      
         if LoadRegs = '1' then
            next_st <= ST_INIT;
         else
            next_st <= ST_DISPLAY;
         end if; 
    
        when ST_DISPLAY =>
         if LoadRegs  = '1' then
            next_st <= ST_INIT;    
         elsif counter < Display - 1 then
            next_st <= ST_DISPLAY;     
         else       
            next_st <= ST_FRONTPORCH; 
         end if;
                  
     
      when ST_FRONTPORCH =>
         if LoadRegs = '1' then
            next_st <= ST_INIT;
         elsif counter < Display + FrontPorch + Advance - 1 then
            next_st <= ST_FRONTPORCH;
         else
            next_st <= ST_SYNCPULSE;
         end if;
         
     
      when ST_SYNCPULSE =>
         if LoadRegs = '1' then
            next_st <= ST_INIT;
         elsif counter < Display + FrontPorch + SyncPulse - 1 then
            next_st <= ST_SYNCPULSE;
         else
            next_st <= ST_BACKPORCH;
         end if;
    
      when ST_BACKPORCH =>
         if LoadRegs = '1' then
            next_st <= ST_INIT;
         elsif counter < Display + FrontPorch + SyncPulse + BackPorch - Advance - 1 then
            next_st <= ST_BACKPORCH;
         else
            next_st <= ST_DISPLAY;
         end if;
         
  
  
      when others =>
         next_st <= ST_INIT;
      end case;
      
      
end process;


CreateCurrentState: process(clk, rst)


begin
   if rst = '1' then
      curr_st <= ST_INIT;
   elsif rising_edge(clk) then
      if next_st = ST_INIT or en = '1' then
         curr_st <= next_st;
      end if;
   end if;
end process;

ConditionSynchronousOutputs: process(curr_st, clk)
   
   
begin
   
   if rising_edge(clk) and en = '1' then
   
      done <= '0';
         
      case curr_st is
      
         when ST_INIT =>
         
            done <= '1';
            
         when ST_FRONTPORCH | ST_SYNCPULSE =>
         
            counter <= counter + 1;
            
         when ST_DISPLAY =>
         
            if counter = Display - 1 then
               done <= '1';
            else
               done <= '0';
            end if;
            counter <= counter + 1;
            
         when ST_BACKPORCH =>
         
            if counter = Display + FrontPorch + SyncPulse + BackPorch - Advance - 1
            then
               counter <= (others => '0');
            else
               counter <= counter + 1;  
            end if;
            
         when others =>
            counter <= (others => '0');
      end case;
   end if; 
end process;

ConditionCombinitorialOutputs: process(curr_st, counter)
begin
   case curr_st is
   
      when ST_INIT =>
      
         display_count <= (others => '0');
         sync <= '0' xnor SYNCActiveHigh;
         bright <= '0';
    
      when ST_DISPLAY =>
         
         display_count <= std_logic_vector(counter);                  
         sync <= '0' xnor SYNCActiveHigh;
         bright <= '1';
        
      when ST_FRONTPORCH | ST_BACKPORCH =>
      
         display_count <= (others => '0');
         sync <= '0' xnor SYNCActiveHigh;
         bright <= '0';
      
      when ST_SYNCPULSE =>
      
         display_count <= (others => '0');
         sync <= '1' xnor SYNCActiveHigh;
         bright <= '0';

      when others =>
      
         display_count <= (others => '0');
         sync <= '0' xnor SYNCActiveHigh;
         bright <= '0';
     
   end case;

end process;

end Behavioral;






