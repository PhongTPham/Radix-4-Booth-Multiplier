-- Company: Computer Architecture 
-- Engineer: Christian Terrado 
-- Create Date: 3/4/2020
-- Design Name: 
-- Module Name: InstructionMemory - Behavioral 
-- Project Name: TeaFang Booth Radix-4
-- Description: Outputs an instruction for each program count. 
------------------------------------------------------
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;

entity InstructionMemory is 
    port(PC: in STD_LOGIC_VECTOR (30 downto 0); 
        Instruct : out STD_LOGIC_VECTOR (3 downto 0)); 
End InstructionMemory; 

architecture Behavioral of InstructionMemory is 

begin 

process(PC) 
begin
    case PC is 
        when "0000000000000000000000000000000" => Instruct <= "0000"; -- Load A 
        when "0000000000000000000000000000001" => Instruct <= "0001"; -- Load B 
        when "0000000000000000000000000000010" => Instruct <= "0010"; -- Load 2B
        when "0000000000000000000000000000011" => Instruct <= "0011"; -- Invert B
        when "0000000000000000000000000000100" => Instruct <= "0100"; -- Invert 2B
        when "0000000000000000000000000000101" => Instruct <= "0101"; -- Shift Left to create pad bit 
        when "0000000000000000000000000000110" => Instruct <= "0110"; -- Check1 
        when "0000000000000000000000000000111" => Instruct <= "0111"; -- Add1 
        when "0000000000000000000000000001000" => Instruct <= "1000"; -- Shift1
        when "0000000000000000000000000001001" => Instruct <= "0110"; -- Check2 
        when "0000000000000000000000000001010" => Instruct <= "0111"; -- Add2 
        when "0000000000000000000000000001011" => Instruct <= "1000"; -- Shift3 
        when "0000000000000000000000000001100" => Instruct <= "0110"; -- Check4 
        when "0000000000000000000000000001101" => Instruct <= "0111"; -- Add4 
        when "0000000000000000000000000001110" => Instruct <= "1000"; -- Shift4 
        when "0000000000000000000000000001111" => Instruct <= "0110"; -- Check5
        when "0000000000000000000000000010000" => Instruct <= "0111"; -- Add5 
        when "0000000000000000000000000010001" => Instruct <= "1000"; -- Shift5
        when "0000000000000000000000000010010" => Instruct <= "0110"; -- Check6
        when "0000000000000000000000000010011" => Instruct <= "0111"; -- Add6
        when "0000000000000000000000000010100" => Instruct <= "1000"; -- Shift6
        when "0000000000000000000000000010101" => Instruct <= "0110"; -- Check7
        when "0000000000000000000000000010110" => Instruct <= "0111"; -- Add7
        when "0000000000000000000000000010111" => Instruct <= "1000"; -- Shift7
        when "0000000000000000000000000011000" => Instruct <= "0110"; -- Check8
        when "0000000000000000000000000011001" => Instruct <= "0111"; -- Add8
        when "0000000000000000000000000011010" => Instruct <= "1000"; -- Shift8
        when "0000000000000000000000000011011" => Instruct <= "1000"; -- Shift to get rid of pad bit 
        when others => Instruct <= "1111"; -- Cease program 
    end case; 
end process;

end Behavioral; 
