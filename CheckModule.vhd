----------------------------------------------------
--Company: Walla Walla University Computer Architecture
--Engineer: Christian & Phong
--
--Create Date:
--Design Name:
--Module Name: CheckModule - Behavioral
--Project Name: Booth's Radix-4 Hardware
-- Description: Checks last two bits in the accumlator register and outputs a control signal that follows booth's
--		algorithm
-----------------------------------------------------
libraray IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CheckModule is
	port(Racc: IN std_logic_vector(30 downto 0); 
	Rselect: OUT std_logic_vector(1 downto 0));
Add ()1 + B, 10 -B, 00 0)
end CheckModule

architecture Behavioral of CheckModule is

begin

process(Racc)
begin
	case Racc(1 downto 0) is
		when "01" => Rselect <= "01"; --Add B
		when "10" => Rselect <= "10"; --Add -B
		when others => Rselect <= "00"; --Add 0
	end case;
end process;

end Behavioral;
