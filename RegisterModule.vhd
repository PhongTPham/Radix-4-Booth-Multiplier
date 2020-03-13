
-- Company: Computer Architecture 
-- Engineer: Christian Terrado 
-- Create Date: 3/7/2020
-- Design Name: 
-- Module Name: RegisterMemory - Behavioral 
-- Project Name: Booths Hardware 
-- Description: Stores and writes to the internal registers 

library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 

entity RegisterMemory is
port(clock: IN std_logic;
    writeCtrlIn: IN std_logic_vector(2 downto 0); --Selects which signal to write 
    writeCtrlReg: IN std_logic_vector(2 downto 0);--Selects which register to write to 
    MathData: IN std_logic_vector(30 downto 0); --Signal from math modules 
    Immediate: IN std_logic_vector(30 downto 0); --Immediate data to load 
    Racc: OUT std_logic_vector(30 downto 0); --Acc register output 
    Radd: OUT std_logic_vector(30 downto 0); --Add register output 
    Bplus: OUT std_logic_vector(30 downto 0); --Bplus register output 
    DBplus: OUT std_logic_vector(30 downto 0)); --B2plus register output 
end RegisterMemory; 

architecture Behavioral of RegisterMemory is 

signal AccReg, AddReg, BplusReg, BminusReg, DBplusReg, DBminusReg: std_logic_vector(30 downto 0); -- Internal Register Signals 
signal toWrite: std_logic_vector(30 downto 0); -- Signal between multiplexers 

begin 

-- Multiplexer that controls which register the signal is written to 
process(clock, writeCtrlReg) 
begin 
    if (clock'event and clock = '1') then 
        if (writeCtrlReg = "000") then 
            AccReg <= toWrite; 
        end if; 
        if (writeCtrlReg = "001") then 
            AddReg <= toWrite; 
        end if; 
        if (writeCtrlReg = "010") then 
            BplusReg <= toWrite; 
        end if; 
        if (writeCtrlReg = "011") then 
            BminusReg <= toWrite; 
        end if; 
        if (writeCtrlReg = "100") then 
            DBplusReg <= toWrite; 
        end if; 
        if (writeCtrlReg = "101") then 
            DBminusReg <= toWrite; 
        end if; 
    end if; 
end process; 

-- Multiplexer that controls which input signal is written 
process(writeCtrlIn, Immediate, MathData, BplusReg, BminusReg) 
begin 
    case writeCtrlIn is 
        when "000" => toWrite <= Immediate; 
        when "001" => toWrite <= MathData; 
        when "010" => toWrite <= BplusReg; 
        when "011" => toWrite <= BminusReg;
        when "100" => toWrite <= DBplusReg; 
        when "101" => toWrite <= DBminusReg;
        when others => toWrite <= "0000000000000000000000000000000"; 
    end case; 
end process; 
-- Send internal signals to outputs 

Racc <= AccReg;
Radd <= AddReg;
Bplus <= BplusReg;
DBplus <= DBplusReg;
    
end Behavioral;
