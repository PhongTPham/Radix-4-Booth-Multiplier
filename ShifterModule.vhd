-- Company: Computer Architecture 
-- Engineer: Christian Terrado 
-- Create Date: 3/4/2020
-- Design Name: 
-- Module Name: InstructionMemory - Behavioral 
-- Project Name: TeaFang Booth Radix-4
-- Description: Outputs an instruction for each program count. 
--------------------------------------------------------------------------------
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 

entity ShifterModule is 
port(Racc: IN std_logic_vector(30 downto 0); --Accumulator Input 
    shftCtrl: IN std_logic;                  --Which direction to shift: 0 left, 1 right 
    Sout: OUT std_logic_vector(30 downto 0)); --Shifted output 

end ShifterModule; 
architecture Behavioral of ShifterModule is 

begin 

process(Racc, shftCtrl) 
begin 
    if shftCtrl = '0' then --Shift Left 
        Sout <= Racc(29 downto 0) & '0'; 
    else                   -- Shift Right 
        if Racc(30) = '1' then -- Sign extend 
            Sout <= '1' & Racc(30 downto 1); 
        else 
            Sout <= '0' & Racc(30 downto 1); 
        end if; 
    end if; 
end process; 
        
end Behavioral;
