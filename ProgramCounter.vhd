-- Company: Computer Architecture
-- Engineer: Phong Pham
-- Create Date: 3/7/2020 
-- Design Name: 
-- Module Name: ProgramCounter - Behavioral 
-- Project Name: TeaFang Booth Radix-4
-- Target Devices: 
-- Tool versions: 
-- Description: 
--------------------------------

library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL; 

entity ProgramCounter is 
    port(clock: IN std_logic; 

    cease: IN std_logic; 
    reset: IN std_logic; 
    PC: OUT std_logic_vector(30 downto 0));
End ProgramCounter; 

architecture Behavioral of ProgramCounter is 
signal PCcount : std_logic_vector(30 downto 0);

begin 

process(clock, PCcount, reset) 
begin 
if (clock'event and clock = '1') then --standard counter 
    if reset = '1' then 
        PCcount <= "0000000000000000000000000000000"; 
    elsif cease = '1' then 
        PCcount <= "1111111111111111111111111111111"; 
    else 
        PCcount <= std_logic_vector(unsigned(PCcount) +1); 
    end if; 
else 
    PCcount <= PCcount; 
end if; 
end process; 

PC <= PCcount;

end Behavioral;
