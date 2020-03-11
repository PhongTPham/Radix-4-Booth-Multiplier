--Company: Computer Architecture
--Engineer: Christian Terrado & Phong Pham
--
--Create Date: 14:11:21 02/26/2016
--Design Name:
--Module Name: CheckModule - Behavioral
--Project Name: Booth's Radix-4 Hardware
-- Description: Checks last two bits in the accumlator register and outputs a control signal that follows booth's
--		algorithm
libraray IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CheckModule is
    port(Racc: IN std_logic_vector(30 downto 0); 
    Rselect: OUT std_logic_vector(2 downto 0)); -- Add ()
end CheckModule

architecture Behavioral of CheckModule is

begin

process(Racc)
begin
    case Racc(2 downto 0) is
        when "001" => Rselect <= "001"; --Add -2B
        when "010" => Rselect <= "010"; --Add 2B
        when "011" => Rselect <= "011"; -- Add -B
        when "100" => Rselect <= "100"; -- Add B
        when others => Rselect <= "000"; --Add 0
    end case;
end process;

end Behavioral;
