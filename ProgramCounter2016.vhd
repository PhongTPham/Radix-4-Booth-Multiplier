-- Company: Computer Architecture 
-- Engineer: Todd Defluiter 
-- Create Date: 11:22:47 03/01/2016 
-- Design Name: 
-- Module Name: PCModule - Behavioral 
-- Project Name: Booths Hardware 
-- Description: Counts up from 0 and outputs the number. Shifts the count to 0 if reset is pressed, shifts to max if cease goes high 
library IEEE; 
use IEEE.STD LOGIC 1164.ALL; 
use IEEE.NUMERIC STD.ALL; 

entity ProgramCounter is 
    port(clock: IN std_logic; 

    cease: IN std_logic; 
    reset: IN std _logic; 
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
