----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:11:32 02/19/2020 
-- Design Name: 
-- Module Name:    register_file - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity register_file is
Port(
	in_clk: in STD_LOGIC;
	in_enable: in STD_LOGIC;
	in_write_en: in STD_LOGIC;
	in_rAsel: in STD_LOGIC_VECTOR (2 downto 0); 
	in_rBsel: in STD_LOGIC_VECTOR (2 downto 0); 
	in_rDsel: in STD_LOGIC_VECTOR (2 downto 0); 
	in_rdataD: in STD_LOGIC_VECTOR (15 downto 0);
	out_rA: out STD_LOGIC_VECTOR (15 down to 0);
	out_rB: out STD_LOGIC_VECTOR (15 down to 0));
end register_file;

architecture Behavioral of register_file is

begin
process(in_clk)
	begin
		if rising_edge(in_clk) and in_enable = '1' then
			-- stuff
		end if;
	end process;

end Behavioral;

