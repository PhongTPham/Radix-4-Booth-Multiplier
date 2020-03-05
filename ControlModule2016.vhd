----------------------------------------------------------------------------------
-- Company: Computer Architecture
-- Engineer: Todd DeFluiter
-- 
-- Create Date:    10:55:31 02/25/2016 
-- Design Name: 
-- Module Name:    ControlModule - Behavioral 
-- Project Name: Booth's Hardware
-- Target Devices: 
-- Tool versions: 
-- Description: Brings in the instruction and decides what each control signal
--			should be
----------------------------------------------------------------------------------
-- Create Date: 10:55:31 02/25/2016 
-- Design Name: 
-- Module Name: ControlModule - Behavioral 
-- Project Name: Booths Hardware 
-- Description: Brings in the Instruction and decides what each control signal 
—			should be. 
——————————————————————————————
library IEEE; 
use IEEE.STD LOGIC 1164.ALL;
 use ieee.numeric std.all; 
entity ControlModule is
	port(Instruct: IN std_logic_vector(2 downto 0);
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
process(Instruct, rselect) begin 
--stop program counter 

case Instruct is 
	when "000" => --load A 
		shftCtrl <= '0'; mathCtrl <= "00"; 
		writeCtrlReg <= "00"; --Write to accumulate 
		writeCtrlln <= "000"; --Write from immediate Immediate <= "0000000000000000" & std logic vector(to_signed(7,15)); --A value 
		cease <= '0'; when "001" => --load B -- can't stop 
	when “001” =>  —load B
		shftCtrl <= '0'; mathCtrl <= "00"; 
		writeCtrIReg <= "10"; --Write to B 
		writeCtrlln <= "000"; --Write from immediate 
		Immediate <= std logic_vector(to_signed(10,31)); 
		cease <= '0'; -- won't stop 
	when "010" => --invert 
		shftCtrl <= '0'; mathCtrl <= "11"; --using inverter 
		writeCtrIReg <= "11"; --Write to -B 
		writeCtrlln <= "001"; --Write from math 
		Immediate <= "0000000000000000000000000000000"; 
		cease <= '0';  — don’t stopp
	 when "011" => --shift L 
		shftCtrl <= '0'; --L 
		mathCtrl <= "01";  --using shifter 
		writeCtrIReg <= "00"; --Write to accumulate 
		writeCtrlln <= "001"; --Write from math 
		Immediate <= "0000000000000000000000000000000"; 
		cease <= '0'; yee shall not stop 
	when "100" => --shift R 
		shftCtrl <= '1'; --R mathCtrl <= "01"; --using shifter 
		writeCtrIReg <= "00"; --Write to accumulate 
		writeCtrlln <= "001"; --Write from math 
		Immediate <= "0000000000000000000000000000000"; 
		cease <= '0'; -- please oh please don't stop 

	when "101" => --check 
		shftCtrl <= '0'; mathCtrl <= "00"; 
		writeCtrIReg <= "01"; --Write to add 
		if Rselect = "00" then 
			writeCtrlln <= "100"; --Write from 0 
		elsif Rselect = "10" then 
			writeCtrlln <= "011"; --Write from -B 
		else 
			writeCtrlln <= "010";  --Write from B 
		end if; 
			Immediate <= "0000000000000000000000000000000"; 
			cease <= '0';  -- whatever I don't even care any more 
	when "110" => --add shftCtrl <= '0'; —add
		shftCtrl <= ‘0’;
		mathCtrl <= "10"; --using adder 
		writeCtrIReg <= "00"; --Write to accumuluate
		writeCtrIln <= "001"; --Write from math 
		Immediate <= "00000000000000000000 
		cease <= '0'; 00000000000"; -- no parking at an time 
	when others => --terminate "j y ust stop" 
		shftCtrl <= '0'; 
		mathCtrl <= "00"; 
		writeCtrl Reg <= "01"; 
		writeCtrIln <= "000"; 
		Immediate <= "0000000000000000000000000000000"; 
		cease <= '1'; desist end case; 
	end process; 
	end Behavioral; 
