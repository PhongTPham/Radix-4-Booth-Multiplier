-- Company: Computer Architecture
-- Engineer: Phong Pham
-- Create Date:    7:02 3/7/2020
-- Design Name: 
-- Module Name:    InvertModule - Behavioral 
-- Project Name: TeaFang Booth Radix-4
-- Target Devices: 
-- Tool versions: 
-- Description: 
------------------------------------------------------------------------
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
