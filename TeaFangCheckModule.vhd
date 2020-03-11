
-- Company: Computer Architecture
-- Engineer: Phong Pham
-- Create Date: 3/7/2020 
-- Design Name: 
-- Module Name: AddModule - Behavioral 
-- Project Name: TeaFang Booth Radix-4
-- Target Devices: 
-- Tool versions: 
-- Description: 
--------------------------------

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
	case Racc(2 downto 0) is
		when "001" => Rselect <= "001"; --Add B
		when "010" => Rselect <= "010"; --Add B
		when "011" => Rselect <= "011"; --Add B
		when "100" => Rselect <= "100"; --Add B
		when "101" => Rselect <= "101"; --Add B
		when "110" => Rselect <= "110"; --Add -B
		when others => Rselect <= "000"; --Add 0
	end case;
end process;

end Behavioral;
