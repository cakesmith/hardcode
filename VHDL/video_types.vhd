--
--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 
--
--   To use any of the example code shown below, uncomment the lines and modify as necessary
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;


package video_types is

-- Declare constants
--
-- constant <constant_name>		: time := <time_unit> ns;
-- constant <constant_name>		: integer := <value;


constant C_PIXELS : integer := 640;

constant C_LINES : integer := 400;

   -- these are measured in clocks
constant    hfp : positive := 16;	-- Horizontal Front Porch
constant hpulse : positive := 96;	-- Hsync Pulse
constant    hbp : positive := 48;	-- Horizontal Back Porch

-- these are measured in lines
constant    vfp : positive := 12;	-- Vertical Front Porch
constant vpulse : positive := 2;		-- Vsync Pulse
constant    vbp : positive := 35;	-- Vertical Back Porch

constant Default_HSAH : STD_LOGIC := '0';    -- if '1' sync is active high,
															 -- if '0' sync is active low.
constant Default_VSAH : STD_LOGIC := '1';
	
   
   constant Default_FrontPorch_H : Unsigned(15 downto 0) := to_unsigned(hfp, 16);
   constant Default_Display_H    : Unsigned(15 downto 0) := to_unsigned(C_PIXELS, 16);
   constant Default_BackPorch_H  : Unsigned(15 downto 0) := to_unsigned(hbp, 16);
   constant Default_SyncPulse_H  : Unsigned(15 downto 0) := to_unsigned(hpulse, 16);
   
   constant Default_FrontPorch_V : Unsigned(15 downto 0) := to_unsigned(vfp, 16);
   constant Default_Display_V    : Unsigned(15 downto 0) := to_unsigned(C_LINES, 16);
   constant Default_BackPorch_V  : Unsigned(15 downto 0) := to_unsigned(vbp, 16);
   constant Default_SyncPulse_V  : Unsigned(15 downto 0) := to_unsigned(vpulse, 16);
	
   constant advance : positive := 4;
-- type <new_type> is
--  record
--    <type_name>        : std_logic_vector( 7 downto 0);
--    <type_name>        : std_logic;
-- end record;
--
      
	
type rgb is

	record
		Red	: std_logic_vector(3 downto 0);
		Green : std_logic_vector(3 downto 0);
		Blue  : std_logic_vector(3 downto 0);
	end record;
	
	
	
-- let's define some colors (:
        --------------------------Red-----Green---Blue---------
      constant White   : rgb := ("1111", "1111", "1111");
      constant Silver  : rgb := ("0111", "0111", "0111");
      constant Gray    : rgb := ("0011", "0011", "0011");
      constant Black   : rgb := ("0000", "0000", "0000");        
      constant Red     : rgb := ("1111", "0000", "0000");
      constant Maroon  : rgb := ("0011", "0000", "0000");
      constant Yellow  : rgb := ("1111", "1111", "0000");
      constant Olive   : rgb := ("0011", "0111", "0000");
      constant Lime    : rgb := ("0000", "1111", "0000");
      constant Green   : rgb := ("0000", "0011", "0000");
      constant Aqua    : rgb := ("0000", "1111", "1111");
      constant Teal    : rgb := ("0000", "0011", "0011");
      constant Blue    : rgb := ("0000", "0010", "1111");
      constant Navy    : rgb := ("0000", "0000", "0011");
      constant Fuchsia : rgb := ("1111", "0000", "1111");
      constant Purple  : rgb := ("0011", "0000", "0011");
        
      type Palette is array (0 to 15) of rgb;
      
      constant VGAPalette : Palette := 
      
      (  0 => White,
         1 => Silver, 
         2 => Gray,
         3 => Black,
         4 => Red,
         5 => Maroon,
         6 => Yellow,
         7 => Olive,
         8 => Lime,
         9 => Green,
        10 => Aqua,
        11 => Teal,
        12 => Blue,
        13 => Navy,
        14 => Fuchsia,
        15 => Purple 
      );

  
--
-- Declare functions and procedure
--
-- function <function_name>  (signal <signal_name> : in <type_declaration>) return <type_declaration>;
-- procedure <procedure_name> (<type_declaration> <constant_name>	: in <type_declaration>);
--
  function f_log2 (x : positive) return natural;
  function reverse_vector (a: in std_logic_vector) return std_logic_vector;
  
end video_types;

package body video_types is

---- Example 1
--  function <function_name>  (signal <signal_name> : in <type_declaration>  ) return <type_declaration> is
--    variable <variable_name>     : <type_declaration>;
--  begin
--    <variable_name> := <signal_name> xor <signal_name>;
--    return <variable_name>; 
--  end <function_name>;

---- Example 2
--  function <function_name>  (signal <signal_name> : in <type_declaration>;
--                         signal <signal_name>   : in <type_declaration>  ) return <type_declaration> is
--  begin
--    if (<signal_name> = '1') then
--      return <signal_name>;
--    else
--      return 'Z';
--    end if;
--  end <function_name>;

  function f_log2 (x : positive) return natural is
      variable i : natural;
   begin
      i := 0;  
      while (2**i < x) and i < 31 loop
         i := i + 1;
      end loop;
      return i;
   end function;
   
   function reverse_vector (a: in std_logic_vector)
return std_logic_vector is
  variable result: std_logic_vector(a'RANGE);
  alias aa: std_logic_vector(a'REVERSE_RANGE) is a;
begin
  for i in aa'RANGE loop
    result(i) := aa(i);
  end loop;
  return result;
end;

---- Procedure Example
--  procedure <procedure_name>  (<type_declaration> <constant_name>  : in <type_declaration>) is
--    
--  begin
--    
--  end <procedure_name>;



end video_types;
