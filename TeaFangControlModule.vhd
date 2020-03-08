-- Company: Computer Architecture
-- Engineer: Christian Terrado
-- Create Date:    10:55:31 3/4/2020
-- Design Name: 
-- Module Name:    ControlModule - Behavioral 
-- Project Name: TeaFang Booth Radix-4
-- Target Devices: 
-- Tool versions: 
-- Description: Brings in the instruction and decides what each control signal
--			should be
library IEEE; 
use IEEE.STD LOGIC 1164.ALL;
 use ieee.numeric std.all; 
entity ControlModule is
	port(Instruct: IN std_logic_vector(3 downto 0);
	Rselect: IN std_logic_vector(1 downto 0);
	shftCtrl: OUT std_logic; --Controls in which direction to shift 
	mathCtrl: OUT std_logic_vector(1 downto 0); --Controls which math module the register output 
	goes to 
	writeCtrlReg: OUT std_logic_vector(1 downto 0); --Controls which register is written to 
	writeCtrlln: OUT std_logic_vector(2 downto 0); -- Selects the write input, either from a register or the math modules 
	Immediate: OUT std_logic_vector(30 downto 0); -- Sent A, B value 
	Cease: OUT std_logic); 
end ControlModule; 

architecture Behavioral of ControlModule is 

begin 

process(Instruct, rselect) 
begin 
    case Instruct is 
	    when "0000" => -- Load A 
            shftCtrl <= '0'; 
            mathCtrl <= "000"; 
		    writeCtrlReg <= "000"; --Write to accumulate 
            writeCtrlln <= "000"; --Write from immediate 
            Immediate <= "0000000000000000" & std logic vector(to_signed(7,15)); --A value 
		    cease <= '0'; when "0001" => --load B  
	    when “0001” =>  -- Load B
            shftCtrl <= '0'; 
            mathCtrl <= "000"; 
		    writeCtrIReg <= "001"; --Write to B 
		    writeCtrlln <= "000"; --Write from immediate 
		    Immediate <= std logic_vector(to_signed(10,31)); 
		    cease <= '0'; -- won't stop 
	    when "0010" => -- Load 2B
            shftCtrl <= '0'; 
            mathCtrl <= "100"; --using Double 
		    writeCtrIReg <= "100"; --Write to 2B 
		    writeCtrlln <= "001"; --Write from math 
		    Immediate <= "0000000000000000000000000000000"; 
		    cease <= '0';  — don’t stopp
	    when "0011" => -- Invert B 
		    shftCtrl <= '0'; --L 
		    mathCtrl <= "001";  --using shifter 
		    writeCtrIReg <= "00"; --Write to accumulate 
		    writeCtrlln <= "001"; --Write from math 
		    Immediate <= "0000000000000000000000000000000"; 
		    cease <= '0'; yee shall not stop 
	    when "0100" => -- Invert 2B
            shftCtrl <= '1'; --R 
            mathCtrl <= "001"; --using shifter 
		    writeCtrIReg <= "00"; --Write to accumulate 
		    writeCtrlln <= "001"; --Write from math 
		    Immediate <= "0000000000000000000000000000000"; 
		    cease <= '0'; -- please oh please don't stop 
		when "0101" => -- Shift L