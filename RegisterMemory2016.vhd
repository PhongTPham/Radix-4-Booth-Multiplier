---------------------------------------------------------------------------------- 
— Company: 	Computer Architecture 
—Engineer:  		Richard Arkusinski 
-- Create Date: 10:38:47 02/18/2016
-- Design Name: 
-- Module Name: RegisterMemory - Behavioral 
-- Project Name: Booths Hardware 
-- Description: Stores and writes to the internal registers 
—
---------------------------------------------------------------------------------- 
library IEEE; 
use IEEE.STD LOGIC 1164.ALL; 

entity RegisterMemory is
port(clock: IN std_logic;
	 writeCtrlln: IN std_logic_vector(2 downto 0); --Selects which signal to write 
	writeCtrlReg: IN std_logic_vector(1 downto 0);--Selects which register to write to 
	MathData: IN std_logic_vector(30 downto 0); --Signal from math modules 
	Immediate: IN std_logic_vector(30 downto 0); --Immediate data to load 
	Racc: OUT std_logic_vector(30 downto 0); --Acc register output 
	Radd: OUT std_logic_vector(30 downto 0); --Add register output 
	Bplus: OUT std_logic_vector(30 downto 0)); --Bplus register output 
end RegisterMemory; 

architecture Behavioral of RegisterMemory is 

signal AccReg, AddReg, BplusReg, BminusReg: std_logic_vector(30 downto 0); -- Internal Register Signals 
signal toWrite: std_logic_vector(30 downto 0); --Signal between multiplexers 

begin 

-- Multiplexer that controls which register the signal is written to 
process(clock, writeCtrlReg) 
begin 
	if (clock'event and clock = '1') then 
		if (writeCtrlReg = "00") then 
			AccReg <= toWrite; 
	end if; 
	if (writeCtrlReg = "01") then 
		Add Reg <= toWrite; 
	end if; 
	if (writeCtrlReg = "10") then 
		BplusReg <= toWrite; 
	end if; 
	if (writeCtrlReg = "11") then 
		BminusReg <= toWrite; 
		end if; 
	end if; 
end process; 

-- Multiplexer that controls which input signal is written 
process(writeCtrlln, Immediate, MathData, BplusReg, BminusReg) 
begin 
	case writeCtrlln is 
		when "000" => toWrite <= Immediate; 
		when "001" => toWrite <= Math Data; 
		when "010" => toWrite <= BplusReg; 
		when "011" => toWrite <= BminusReg; 
		when others => toWrite <= "0000000000000000000000000000000"; 
	end case; 
end process; 
-- Send internal signals to outputs 

Racc <= AccReg;
Radd <= AddReg;
Bplus <= BplusReg;

end Behavioral;
