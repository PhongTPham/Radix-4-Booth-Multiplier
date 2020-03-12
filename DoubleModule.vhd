-- Company: Computer Architecture 
-- Engineer: Phong Pham
-- Create Date: 12:55:22 03/06/2020
-- Design Name: 
-- Module Name: DoubleModule - Behavioral 
-- Project Name: Booths Hardware 
-- Description: Doubles the value of B
----------------------------------------------------
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use ieee.numeric_std.all; 

entity DoubleModule is 
    port(
    Bplus: IN std_logic_vector(30 downto 0); -- B value
    DBout: OUT std_logic_vector(30 downto 0)); -- Output
    
end DoubleModule; 

architecture Behavioral of DoubleModule is 
begin
     DBout <=  "0000000000000000" & std_logic_vector(2 * signed(Bplus(14 downto 0)));
     
end Behavioral; 
