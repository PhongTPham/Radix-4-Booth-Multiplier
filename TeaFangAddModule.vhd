-- Company: Computer Architecture
-- Engineer: Phong Pham
-- Create Date: 3/7/2020 
-- Design Name: 
-- Module Name: AddModule - Behavioral 
-- Project Name: TeaFang Booth Radix-4
-- Target Devices: 
-- Tool versions: 
-- Description: 
--------------------------------
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use ieee.numeric_std.all; 

entity AdderModule is 
    port(Radd: IN std_logic_vector(30 downto 0); --Add Register 
    Racc: IN std_logic_vector(30 downto 0); --Accumulator register 
    Aout: OUT std_logic_vector(30 downto 0)); --Output 
end AdderModule; 

architecture Behavioral of AdderModule is 
begin
     Aout <= std_logic_vector(unsigned(Radd(14 downto 0) & "0000000000000000") + unsigned(Racc)); 
     
end Behavioral; 
