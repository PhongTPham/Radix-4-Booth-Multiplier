-- Company: Computer Architecture 
-- Engineer: Richard Arkusinski 
-- Create Date: 11:04:32 02/25/2016 
-- Design Name: 
-- Module Name: AdderModule - Behavioral 
-- Project Name: Booths Hardware 
-- Description: Adds the lower 16 bits of the accumulator to the upper 15 bits of the Add register 
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use ieee.numeric_std.all; 

entity AdderModule is 
    port(Radd: IN std_logic_vector(30 downto 0); --Add Register 
    Racc: IN std_logic_vector(30 downto 0); --Accemulator register 
    Aout: OUT std_logic_vector(30 downto 0)); --Output 
end AdderModule; 

architecture Behavioral of AdderModule is 
begin
     Aout <= std_logic_vector(unsigned(Radd(14 downto 0) & "0000000000000000") + unsigned(Racc)); 
     
end Behavioral; 
