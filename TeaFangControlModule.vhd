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
	Rselect: IN std_logic_vector(2 downto 0);
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

    -- mathCtrl
        -- "000" "0000000000000000000000000000000" 
        -- "001"  Sout
        -- "010"  Aout
        -- "011"  Iout
        -- "100" Dout
        -- "others"  DIout
    -- mathCtrlReg
        -- "000" accumulate
        -- "001" addreg
        -- "010" BplusReg
        -- "011" BminusReg
        -- "100" DBplusReg
        -- "101" DBminusReg
    -- mathCtrlIn
        -- "000" immediate
        -- "001" Math Data
        -- "010" BplusReg 
        -- "011" BminusReg
	    -- "100" DBplusReg; 
        -- "101" DBminusReg;
        -- "others" "0000000000000000000000000000000"
    case Instruct is 
	    when "0000" => -- Load A 
            shftCtrl <= '0'; 
            mathCtrl <= "000"; 
		    writeCtrlReg <= "000"; -- Write to accumulate 
            writeCtrlIn <= "000"; -- Write from immediate 
            Immediate <= "0000000000000000" & std logic vector(to_signed(7,15)); -- A value 
		    cease <= '0'; -- we aint ever stopping         
	    when “0001” =>  -- Load B
            shftCtrl <= '0'; 
            mathCtrl <= "000"; 
		    writeCtrlReg <= "010"; -- Write to B 
		    writeCtrlIn <= "000"; -- Write from immediate 
		    Immediate <= std logic_vector(to_signed(10,31)); 
		    cease <= '0'; -- can't stop 
	    when "0010" => -- Load 2B
            shftCtrl <= '0'; 
            mathCtrl <= "100"; -- using Double 
		    writeCtrlReg <= "100"; -- Write to 2B 
		    writeCtrlIn <= "001"; -- Write from math 
		    Immediate <= "0000000000000000000000000000000"; 
		    cease <= '0';  -- no hold up
	    when "0011" => -- Invert B 
		    shftCtrl <= '0';
		    mathCtrl <= "011";  -- using Invert 
		    writeCtrlReg <= "011"; -- Write to -B 
		    writeCtrlIn <= "001"; -- Write from math 
		    Immediate <= "0000000000000000000000000000000"; 
		    cease <= '0'; -- a hard go from me dawg
	    when "0100" => -- Invert 2B
            shftCtrl <= '0';  
            mathCtrl <= "100"; -- using Double 
		    writeCtrlReg <= "101"; -- Write to -2B 
		    writeCtrlIn <= "001"; -- Write from math 
		    Immediate <= "0000000000000000000000000000000"; 
		    cease <= '0'; -- keep going probably
		when "0101" => -- Shift L
	        shftCtrl <= '0'; --L 
		    mathCtrl <= "001";  -- using shifter 
		    writeCtrlReg <= "000"; -- Write to accumulate 
		    writeCtrlIn <= "001"; -- Write from math 
		    Immediate <= "0000000000000000000000000000000"; 
		    cease <= '0'; -- not yet
        when "0110" => --Check
	        shftCtrl <= '0'; 
            mathCtrl <= "000"; 
		    writeCtrlReg <= "001"; -- Write to add 
		    if Rselect = "000" then 
			    writeCtrlIn <= "111"; -- Write from 0 
		    elsif Rselect = "001" then
				writeCtrlIn <= "101"; -- Write from -2B
			elsif Rselect = "010" then 
			    writeCtrlIn <= "100"; -- Write from 2B
			elsif Rselect = "011" then 
				writeCtrlIn <= "011"; -- Write from -B
		    else
			    writeCtrlIn <= "010";  --Write from B 
		    end if; 
			Immediate <= "0000000000000000000000000000000"; 
			cease <= '0';  -- whatever I don't even care any more           
        when "1000" => -- Shift R
	        shftCtrl <= '1'; --R 
            mathCtrl <= "001"; --using shifter 
		    writeCtrlReg <= "000"; --Write to accumulate 
		    writeCtrlIn <= "001"; --Write from math 
		    Immediate <= "0000000000000000000000000000000"; 
		    cease <= '0'; -- wait for the drop
        when "
        when "others" => -- Terminate Program
            shftCtrl <= '0';
            mathCtrl <= "000";
            writeCtrlReg <= "001";
			writeCtrlIn <= "000";
            Immediate <= "0000000000000000000000000000000";
            cease <= '1'; -- End its suffering
        end process;
        end Behavioral;
