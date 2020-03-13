-- Company: Computer Architecture 
-- Engineer: Phong Pham
-- Create Date: 12:55:22 03/06/2020
-- Design Name: 
-- Module Name: InvertDoubleModule - Behavioral 
-- Project Name: Booths Hardware 
-- Description: Doubles and inverts the value of B
-----------------------------------------
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use ieee.numeric_std.all; 

entity InvertDoubleModule is 
    port(Bplus: IN std_logic_vector(30 downto 0); 
    DIout: OUT std_logic_vector(30 downto 0)); 
end InvertDoubleModule; 

architecture Behavioral of InvertDoubleModule is 
begin 

    DIout <= "000000000000000" & std_logic_vector(-signed(Bplus(14 downto 0)& "0")); 

end Behavioral; 
