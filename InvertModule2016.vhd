-- Company: Computer Architecture 
-- Engineer: Richard Arkusinski 
-- Create Date: 13:54:56 02/26/2016 
-- Design Name: 
-- Module Name: InvertModule - Behavioral 
-- Project Name: Booths Hardware 
-- Description: Inverts the lower 15 bits of Bplus in 2s compliment 
-----------------------------------------
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use ieee.numeric_std.all; 

entity InvertModule is 
    port(Bplus: IN std_logic_vector(30 downto 0); 
    lout: OUT std_logic_vector(30 downto 0)); 
end InvertModule; 

architecture Behavioral of InvertModule is 
begin 
    lout <= "0000000000000000" & std_logic_vector(-signed(Bplus(14 downto 0))); 
end Behavioral; 